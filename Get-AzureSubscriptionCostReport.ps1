function Get-AzureSubscriptionCostReport {
    <#
    .SYNOPSIS
    Enumerates Azure subscription resources and their accrued cost for the current billing period.

    .DESCRIPTION
    Queries the Azure Cost Management REST API via 'az rest' to retrieve per-resource cost data
    for the current calendar month (billing period). Results are written to the pipeline as
    structured objects and optionally exported to CSV.

    Requires:
    - Azure CLI (az) installed and logged in ('az login')
    - Cost Management Reader role or higher on the target subscription

    No Az PowerShell module dependency. Works with az CLI login only.

    .PARAMETER SubscriptionId
    Target Azure subscription ID. Defaults to the current default az CLI subscription.

    .PARAMETER ExportCsvPath
    Optional file path to export results as CSV. If omitted, results are returned to the pipeline only.

    .PARAMETER Top
    Maximum number of resource rows to return. Defaults to 500.

    .EXAMPLE
    Get-AzureSubscriptionCostReport
    Returns current-month accrued cost for all resources in the default subscription.

    .EXAMPLE
    Get-AzureSubscriptionCostReport -SubscriptionId 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' -ExportCsvPath 'C:\Reports\azure-costs.csv'
    Queries a specific subscription and exports results to CSV.

    .EXAMPLE
    Get-AzureSubscriptionCostReport | Sort-Object CostUSD -Descending | Select-Object -First 20 | Format-Table -AutoSize
    Returns the top 20 most expensive resources sorted by cost.

    .OUTPUTS
    [PSCustomObject] with ResourceName, ResourceType, ResourceGroup, Location, CostUSD,
    Currency, BillingMonth, SubscriptionId

    .NOTES
    Author: Tim Warner
    Uses az rest to POST to the Cost Management Query API (2023-11-01).
    Billing period is always the current calendar month (first day to today UTC).
    #>
    [CmdletBinding()]
    param(
        [Parameter()]
        [ValidatePattern('^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$')]
        [string]$SubscriptionId,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$ExportCsvPath,

        [Parameter()]
        [ValidateRange(1, 5000)]
        [int]$Top = 500
    )

    begin {
        Set-StrictMode -Version Latest
        $ErrorActionPreference = 'Stop'

        # Verify az CLI is available and logged in
        if (-not (Get-Command az -ErrorAction SilentlyContinue)) {
            throw 'Azure CLI (az) not found. Install from: https://aka.ms/installazurecli'
        }

        $accountJson = az account show 2>&1
        if ($LASTEXITCODE -ne 0) {
            throw 'Not logged in to Azure CLI. Run: az login'
        }

        $account = $accountJson | ConvertFrom-Json

        # Use parameter if supplied, otherwise use CLI default
        $resolvedSubscriptionId = if ($PSBoundParameters.ContainsKey('SubscriptionId')) {
            $SubscriptionId
        }
        else {
            $account.id
        }

        $subscriptionName = $account.name
        Write-Verbose "Targeting subscription: '$subscriptionName' ($resolvedSubscriptionId)"

        # Billing window: first day of current month through today (UTC)
        $today       = [datetime]::UtcNow.Date
        $periodStart = [datetime]::new($today.Year, $today.Month, 1)
        $periodEnd   = $today

        Write-Verbose "Billing window: $($periodStart.ToString('yyyy-MM-dd')) to $($periodEnd.ToString('yyyy-MM-dd'))"
    }

    process {
        try {
            # Cost Management Query API endpoint
            $apiVersion = '2023-11-01'
            $uri = "https://management.azure.com/subscriptions/$resolvedSubscriptionId/providers/Microsoft.CostManagement/query?api-version=$apiVersion"

            # Request body: group by resource dimensions, sum PreTaxCost, no time granularity
            $body = @{
                type       = 'ActualCost'
                timeframe  = 'Custom'
                timePeriod = @{
                    from = $periodStart.ToString("yyyy-MM-dd'T'00:00:00'Z'")
                    to   = $periodEnd.ToString("yyyy-MM-dd'T'23:59:59'Z'")
                }
                dataset    = @{
                    granularity = 'None'
                    aggregation = @{
                        totalCost = @{ name = 'PreTaxCost'; function = 'Sum' }
                    }
                    grouping    = @(
                        @{ type = 'Dimension'; name = 'ResourceId' }
                        @{ type = 'Dimension'; name = 'ResourceType' }
                        @{ type = 'Dimension'; name = 'ResourceGroupName' }
                        @{ type = 'Dimension'; name = 'ResourceLocation' }
                    )
                }
            } | ConvertTo-Json -Depth 10 -Compress

            Write-Verbose 'Submitting Cost Management query via az rest...'

            $rawResponse = az rest --method POST --uri $uri --body $body --headers "Content-Type=application/json" 2>&1

            if ($LASTEXITCODE -ne 0) {
                throw "az rest failed: $rawResponse"
            }

            $response = $rawResponse | ConvertFrom-Json

            if (-not $response.properties -or -not $response.properties.rows -or $response.properties.rows.Count -eq 0) {
                Write-Warning 'No cost data returned for the selected subscription and billing period. The subscription may have zero spend this month.'
                return
            }

            # Column names are in the response columns array; map positionally to each row
            $columns = $response.properties.columns.name
            Write-Verbose "Response columns: $($columns -join ', ')"

            $results = foreach ($row in $response.properties.rows | Select-Object -First $Top) {
                $map = @{}
                for ($i = 0; $i -lt $columns.Count; $i++) {
                    $map[$columns[$i]] = $row[$i]
                }

                # Parse short resource name from the full ARM resource ID
                $rawResourceId = [string]$map['ResourceId']
                $resourceName  = if ($rawResourceId -match '/([^/]+)$') { $Matches[1] } else { $rawResourceId }

                [pscustomobject]@{
                    ResourceName     = $resourceName
                    ResourceType     = [string]$map['ResourceType']
                    ResourceGroup    = [string]$map['ResourceGroupName']
                    Location         = [string]$map['ResourceLocation']
                    CostUSD          = [math]::Round([decimal]$map['PreTaxCost'], 4)
                    Currency         = 'USD'
                    BillingMonth     = $periodStart.ToString('yyyy-MM')
                    SubscriptionId   = $resolvedSubscriptionId
                    SubscriptionName = $subscriptionName
                }
            }

            Write-Verbose "Retrieved $(@($results).Count) resource cost rows."

            if ($PSBoundParameters.ContainsKey('ExportCsvPath')) {
                $results | Export-Csv -Path $ExportCsvPath -NoTypeInformation -Encoding UTF8 -Force
                Write-Verbose "Results exported to: $ExportCsvPath"
            }

            Write-Output $results
        }
        catch {
            $PSCmdlet.ThrowTerminatingError($_)
        }
    }

    end {
        Write-Verbose 'Get-AzureSubscriptionCostReport completed.'
    }
}


function Test-Function {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Name
    )

    Write-Host "Hello, $Name"
}

# create a new Active Directory domain global group
function New-ADGroup {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Name,
    # parameter
    )

    Write-Host "Creating group $Name"
}


[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$Prompt,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$Model = 'claude-3-5-sonnet-latest',

    [Parameter()]
    [ValidateRange(1, 4096)]
    [int]$MaxTokens = 256,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$SystemPrompt = 'You are a concise, helpful assistant for teaching demos.'
)

<#!
.SYNOPSIS
Sends a single-turn chat request to the Anthropic Messages API.

.DESCRIPTION
This teaching/demo script submits one user prompt to the Anthropic Messages API
and prints the text response to the console.

Set ANTHROPIC_API_KEY in your environment before running.

.EXAMPLE
$env:ANTHROPIC_API_KEY = 'your-key-here'
.\call_anthropic_messages.ps1 -Prompt 'Explain idempotency in one paragraph.'

.EXAMPLE
.\call_anthropic_messages.ps1 -Prompt 'List three uses for PowerShell in Azure ops.' -Model 'claude-3-5-haiku-latest' -MaxTokens 180
#>

begin {
    Set-StrictMode -Version Latest
    $ErrorActionPreference = 'Stop'

    if (-not $env:ANTHROPIC_API_KEY) {
        throw 'ANTHROPIC_API_KEY is not set. In PowerShell, set it with: $env:ANTHROPIC_API_KEY = "your-key"'
    }

    $headers = @{
        'x-api-key'         = $env:ANTHROPIC_API_KEY
        'anthropic-version' = '2023-06-01'
        'content-type'      = 'application/json'
    }
}

process {
    try {
        $body = @{
            model       = $Model
            max_tokens  = $MaxTokens
            system      = $SystemPrompt
            messages    = @(
                @{
                    role    = 'user'
                    content = $Prompt
                }
            )
        } | ConvertTo-Json -Depth 10

        $response = Invoke-RestMethod -Method Post -Uri 'https://api.anthropic.com/v1/messages' -Headers $headers -Body $body

        $textBlocks = @($response.content | Where-Object { $_.type -eq 'text' })
        if ($textBlocks.Count -eq 0) {
            throw 'No text response returned by Anthropic API.'
        }

        $answer = ($textBlocks | ForEach-Object { $_.text }) -join [Environment]::NewLine

        Write-Output ''
        Write-Output 'Anthropic reply:'
        Write-Output $answer
    }
    catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}

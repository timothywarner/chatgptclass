---
applyTo: '**/*.ps1'
---

Provide project context and coding guidelines that AI should follow when generating code, answering questions, or reviewing changes.

# PowerShell Coding Best Practices

- Use clear, descriptive function and variable names in `PascalCase` for functions and `camelCase` for variables.
- Always include comment-based help for functions and scripts.
- Prefer `Write-Output` for standard output and `Write-Error` for error messages.
- Validate all user inputs using `ValidateSet`, `ValidatePattern`, or custom logic.
- Avoid hardcoding secrets; use environment variables or secure vaults.
- Use `Try/Catch/Finally` blocks for error handling.
- Follow indentation of 4 spaces per level.
- Use pipeline-friendly functions (`[CmdletBinding()]` and `Process` block).
- Include examples in help comments.
- Use `Set-StrictMode -Version Latest` at the top of scripts.
- Prefer `Get-Help` compatible documentation.
- Avoid aliases in scripts; use full cmdlet names for clarity.
- Test scripts with `Pester` where possible.

# Define repository structure
$repoStructure = @{
  "src"                = @{} # Source code directory
  ".github"            = @{
    "workflows"  = @{
      "dependabot.yml"      = "version: 2\nupdates:\n  - package-ecosystem: ""npm""\n    directory: ""/""\n    schedule:\n      interval: ""weekly"""
      "codeql-analysis.yml" = "# For more information, visit: https://docs.github.com/en/code-security/secure-coding/automatically-scanning-your-code-for-vulnerabilities-and-errors\nname: 'CodeQL'\non:\n  push:\n    branches: [ main ]\n  pull_request:\n    branches: [ main ]\n  schedule:\n    - cron: '0 14 * * 3'"
    }
    "CODEOWNERS" = "" # Example for code owners file
    "security"   = @{
      "SECURITY.md" = "## Security Policy\n\nPlease report any security vulnerabilities through the project's issues."
    }
  }
  "docs"               = @{} # Documentation directory
  "tests"              = @{} # Tests directory
  ".gitignore"         = "/node_modules\n.DS_Store" # .gitignore file
  "README.md"          = "# Project Title\n\nA brief description of what this project does and who it's for."
  "CONTRIBUTING.md"    = "## Contributing Guidelines\n\nThank you for your interest in contributing to our project!"
  "LICENSE"            = "MIT License\n\nCopyright (c) [year] [fullname]\n\nPermission is hereby granted..."
  "CODE_OF_CONDUCT.md" = "## Code of Conduct\n\nOur pledge to create a welcoming and safe environment."
}

# Helper function to create files and directories
function Create-ItemFromStructure {
  param (
    [string]$basePath,
    [hashtable]$structure
  )

  foreach ($key in $structure.Keys) {
    $path = Join-Path -Path $basePath -ChildPath $key

    if ($structure[$key].GetType().Name -eq "String") {
      # It's a file, create with content
      New-Item -Path $path -ItemType File -Force -Value $structure[$key]
      Write-Host "Created file: $path"
    }
    else {
      # It's a directory, create it, then recurse into its structure
      New-Item -Path $path -ItemType Directory -Force | Out-Null
      Write-Host "Created directory: $path"
      Create-ItemFromStructure -basePath $path -structure $structure[$key]
    }
  }
}

# Create repository structure
Create-ItemFromStructure -basePath (Get-Location) -structure $repoStructure

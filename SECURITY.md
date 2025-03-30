# Security Guidelines

## Secret Scanning

This repository is configured with both local and GitHub-based secret scanning to prevent credentials and other sensitive information from being committed and pushed to the repository.

### Local Pre-commit Hook

A pre-commit hook is installed that scans all staged changes for potential secrets before allowing a commit. This provides immediate feedback during development.

To ensure you have the hook enabled:

1. Make sure Python is installed on your system
2. Install the detect-secrets package:
   ```
   pip install detect-secrets
   ```
3. The pre-commit hook should be automatically enabled. If not, you can manually copy it:
   ```
   cp .git/hooks/pre-commit.sample .git/hooks/pre-commit
   chmod +x .git/hooks/pre-commit
   ```

### GitHub Actions Workflow

A GitHub Actions workflow (.github/workflows/secret-scanning.yml) runs on all pull requests and pushes to main/master branches. This provides an additional layer of protection using:

1. detect-secrets - For detecting a broad range of secret patterns
2. Gitleaks - For comprehensive secret scanning with an extensive ruleset

### Managing False Positives

If you're getting false positives with detect-secrets:

1. Review the baseline file:
   ```
   python -m detect_secrets audit .secrets.baseline
   ```
2. Update the baseline after verifying false positives:
   ```
   python -m detect_secrets scan --baseline .secrets.baseline
   ```

### Common Secret Patterns

See `.gitignore-patterns.txt` for a list of common patterns that may indicate secrets in your code.

### Best Practices

1. **Never** commit credentials, API keys, or other secrets to the repository
2. Use environment variables or a secure secrets manager for all sensitive values
3. Consider using template files (e.g., `.env.example`) to document required environment variables without values
4. Rotate any credentials that have been accidentally committed, even if removed later (Git history preserves them) 
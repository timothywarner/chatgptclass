# Command to set the default repository for GitHub CLI operations
gh repo set-default timothywarner-org/matrix

# For working with code scanning alerts or downloading SARIF files, use the GitHub API via the gh api command
# Example to list code scanning alerts using GitHub API (Note: Adjust according to actual API endpoints and requirements)
gh api repos/timothywarner-org/matrix/code-scanning/alerts

# Example to get details of a specific code scanning alert by its number using GitHub API
gh api repos/timothywarner-org/matrix/code-scanning/alerts/641

# Upload a SARIF file to a repository using the GitHub API
gh api -X POST /repos/ { owner }/ { repo }/code-scanning/sarifs \
-H "Accept: application/vnd.github.v3+json" \
-F "commit_sha=$(git rev-parse HEAD)" \
-F "ref=refs/heads/main" \
-F "sarif=@analysis.sarif" \
-F "checkout_uri=https://github.com/{owner}/{repo}" \
-F "started_at=$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
-F "tool_name=YourStaticAnalysisTool"









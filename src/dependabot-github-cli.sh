##############
# GITHUB CLI #
##############

# Set up Dependabot CLI (https://github.com/dependabot/cli)
gh gist view --raw e09e1ecd76d5573e0517a7622009f06f | bash

# Set variables for personalization:
owner="timothywarner-org"
repo="openai-chat"
teams_channel="GHAS_Alerts"
teams_webhook_url=""

# List all Dependabot alerts for the specified repository:
gh api /repos/timothywarner-org/openai-chat/dependabot/alerts | Out-File -FilePath .\dependabot-alerts.json | code .\dependabot-alerts.json

# Get details of a specific alert (replace :alert_id with the actual ID):
gh api /repos/timothywarner-org/openai-chat/dependabot/alerts/1

# List vulnerable dependencies in a repository
gh api /repos/timothywarner-org/openai-chat/vulnerability-alerts

# Disable Dependabot alerts for a repository
gh api -X DELETE /repos/timothywarner-org/openai-chat/vulnerability-alerts


##################
# DEPENDABOT CLI #
##################

# Dependabot CLI Examples for Python Project (Flask)
# Project: github.com/timothywarner-org/openai-chat
# Dependency File: ./requirements.txt
# Source: https://github.com/dependabot/cli
# Ensure Dependabot CLI is installed and configured according to the GitHub repository instructions.

# 1. Update Flask dependency in the project
dependabot update /path/to/openai-chat --ecosystem=pip --dep=Flask

# 2. Dry run to simulate updates for Flask without applying them
# Useful for testing what changes Dependabot would make
dependabot update /path/to/openai-chat --ecosystem=pip --dep=Flask --dry-run

# 3. Configure Dependabot to ignore a specific version of Flask
# Replace 'VERSION' with the version to ignore (e.g., '1.1.0')
dependabot config set ignore-condition --ecosystem=pip --dep=Flask --version='VERSION' /path/to/openai-chat

# 4. Set custom configuration for Dependabot updates
# This example sets a custom schedule for Dependabot updates
dependabot config set update-schedule "daily" /path/to/openai-chat --ecosystem=pip

# 5. Print debug logs for Dependabot operations on the Flask dependency
dependabot update /path/to/openai-chat --ecosystem=pip --dep=Flask --debug

# Note: Replace /path/to/openai-chat with the actual local path to your repository.
# Replace 'VERSION' with the specific version of Flask you want to ignore.



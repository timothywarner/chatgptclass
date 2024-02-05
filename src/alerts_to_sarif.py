import requests
import json
import os

# Fetch GitHub Personal Access Token from environment variable
TOKEN = os.getenv("TIM_GITHUB_PAT")
REPO_OWNER = "timothywarner-org"
REPO_NAME = "matrix"
ALERT_ID = 641  # Example alert ID

if not TOKEN:
    print("TIM_GITHUB_PAT is not set.")
    exit(1)


def fetch_alert(owner, repo, alert_id, token):
    """Fetch a specific alert from GitHub repository."""
    print("Fetching alert data...")
    headers = {
        "Authorization": f"token {token}",
        "Accept": "application/vnd.github.v3+json",
    }
    url = f"https://api.github.com/repos/{owner}/{repo}/code-scanning/alerts/{alert_id}"
    try:
        response = requests.get(url, headers=headers)
        if response.status_code == 200:
            print("Alert data fetched successfully.")
            return response.json()
        else:
            print(
                f"Failed to fetch alert: HTTP {response.status_code} - {response.text}"
            )
    except Exception as e:
        print(f"Error during API call: {e}")
    return None


def create_sarif_report(alert):
    """Convert the alert details into SARIF format."""
    print("Creating SARIF report...")
    if alert is None:
        print("No alert data provided.")
        return None

    # Basic SARIF template structure
    sarif_template = {
        "$schema": "https://json.schemastore.org/sarif-2.1.0.json",
        "version": "2.1.0",
        "runs": [
            {
                "tool": {
                    "driver": {
                        "name": "GitHub Code Scanning Alert",
                        "organization": "GitHub",
                        "semanticVersion": "1.0.0",
                        "rules": [
                            {
                                "id": alert.get("rule", {}).get("id", "unknown_rule"),
                                "shortDescription": {
                                    "text": alert.get("rule", {}).get(
                                        "description", "No description available"
                                    )
                                },
                                "helpUri": alert.get("html_url", "No URL available"),
                            }
                        ],
                    }
                },
                "results": [
                    {
                        "ruleId": alert.get("rule", {}).get("id", "unknown_rule"),
                        "message": {
                            "text": alert.get("rule", {}).get(
                                "description", "No description available"
                            )
                        },
                        "locations": [
                            {
                                "physicalLocation": {
                                    "artifactLocation": {
                                        "uri": alert.get("html_url", "No URL available")
                                    }
                                }
                            }
                        ],
                    }
                ],
            }
        ],
    }
    print("SARIF report created successfully.")
    return sarif_template


def main():
    alert_data = fetch_alert(REPO_OWNER, REPO_NAME, ALERT_ID, TOKEN)
    if alert_data:
        sarif_report = create_sarif_report(alert_data)
        if sarif_report:
            output_filename = f"alert_{ALERT_ID}.sarif"
            with open(output_filename, "w") as file:
                json.dump(sarif_report, file, indent=4)
            print(f"SARIF report generated and saved as {output_filename}")
        else:
            print("Failed to create SARIF report.")
    else:
        print("Failed to fetch alert data or alert data is None.")


if __name__ == "__main__":
    main()

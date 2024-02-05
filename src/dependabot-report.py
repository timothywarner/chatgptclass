import subprocess
import csv
import json

# Repository details
repo = "timothywarner-org/openai-chat"

# GitHub CLI command to get Dependabot alerts in JSON format
gh_cli_command = "gh api  /repos/timothywarner-org/openai-chat/dependabot/alerts"


def run_gh_cli_command(command):
    """Run GitHub CLI command and return the output"""
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    if result.returncode != 0:
        raise Exception(f"Error in GitHub CLI command: {result.stderr}")
    return result.stdout


def get_dependabot_alerts():
    """Get Dependabot alerts from GitHub repository"""
    output = run_gh_cli_command(gh_cli_command)
    return json.loads(output)


def write_csv(data, filename="dependabot_alerts.csv"):
    """Write Dependabot alerts data to a CSV file"""
    keys = data[0].keys() if data else []
    with open(filename, "w", newline="") as file:
        writer = csv.DictWriter(file, fieldnames=keys)
        writer.writeheader()
        for row in data:
            writer.writerow(row)


def main():
    try:
        alerts = get_dependabot_alerts()
        write_csv(alerts)
        print(f"Dependabot alerts report generated: dependabot_alerts.csv")
    except Exception as e:
        print(f"An error occurred: {e}")


if __name__ == "__main__":
    main()

import openai

openai.api_key = ""

# Retrieve fine-tuning job list
openai.FineTuningJob.list(limit=10)

# Retrieve the fine-tuning job details
job_details = openai.FineTuningJob.retrieve("job-id")
print(job_details)

"""
OUTPUT
{
  "object": "fine_tuning.job",
  "id": "job-id",
  "model": "gpt-3.5-turbo-0613",
  "created_at": 1697812068,
  "finished_at": null,
  "fine_tuned_model": null,
  "organization_id": "org-3ZZndK1ciLfJ79fmFEaDGTzz",
  "result_files": [],
  "status": "validating_files",
  "validation_file": null,
  "training_file": "file-eeyhE6C0I84pkuu3kr9ZFgCU",
  "hyperparameters": {
    "n_epochs": "auto"
  },
  "trained_tokens": null,
  "error": null
}
"""

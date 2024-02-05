import openai
import time

openai.api_key = 'your-api-key'

# Create a fine-tuning job
fine_tuning = openai.FineTuning.create(
  model="your-model-id",
  dataset="file://fine_tune.jsonl",
  description="Fine-tuning on my dataset",
)

# Get the ID of the fine-tuning job
job_id = fine_tuning['id']

# Monitor the status of the fine-tuning job
while True:
    fine_tuning = openai.FineTuning.retrieve(job_id)
    print(f"Job status: {fine_tuning['status']}")

    if fine_tuning['status'] in ['succeeded', 'failed']:
        break

    time.sleep(60)

# Validate the fine-tuned model
validation = openai.Validation.create(
  model=fine_tuning['model'],
  dataset="file://validation.jsonl",
)

print(f"Validation result: {validation['result']}")
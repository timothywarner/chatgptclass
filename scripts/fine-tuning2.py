import openai

openai.api_key = ""

# Upload training data file
openai.File.create(
  file=open(r"source_data.jsonl", "rb"),
  purpose='fine-tune'
)

"""
OUTPUT

<File file id=file-id at 0x24da94cdcc0> JSON: {
  "object": "file",
  "id": "file-id",
  "purpose": "fine-tune",
  "filename": "file",
  "bytes": 12528,
  "created_at": 1697811492,
  "status": "uploaded",
  "status_details": null
}
"""
# Create a fine-tuned model
openai.FineTuningJob.create(training_file="file-id", model="gpt-3.5-turbo")
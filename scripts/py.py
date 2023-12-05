import openai
import json

# Set up OpenAI API credentials
openai.api_key = ""

# Set up the API endpoint
endpoint = "https://api.openai.com/v1/chat/completions"

# Send the request to the API endpoint
response = openai.ChatCompletion.create(
  model="gpt-3.5-turbo",
  temperature = 0.5,
  messages=[
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "Who won the world series in 2020?"},
    {"role": "assistant", "content": "The Los Angeles Dodgers won the World Series in 2020."},
    {"role": "user", "content": "Where was it played?"}
  ]
)

# Print the response
print(json.dumps(response, indent=4))
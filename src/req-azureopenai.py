
sum = 42 +
print(sum)

pip install --upgrade openai

import os
from openai import AzureOpenAI

client = AzureOpenAI(
    api_key=os.getenv("AZURE_OPENAI_KEY"),
    api_version="2023-10-01-preview",
    azure_endpoint = os.getenv("AZURE_OPENAI_ENDPOINT")
    )

deployment_name='REPLACE_WITH_YOUR_DEPLOYMENT_NAME' #This will correspond to the custom name you chose for your deployment when you deployed a model.

# Send a completion call to generate an answer
print('Sending a test completion job')
start_phrase = 'Write a tagline for an ice cream shop. '
response = client.completions.create(model=deployment_name, prompt=start_phrase, max_tokens=10)
print(response.choices[0].text)



# Old approaches
import openai

# Set your API key from Azure
openai.api_key = "your-api-key"

# Define the chat completion request
response = openai.ChatCompletion.create(
    model="gpt-35-turbo",  # Specify your deployment model name
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "Hello world!"},
    ],
)

# Print the response
print(response)


import openai

# Initialize the OpenAI object with your API key
openai_obj = openai.OpenAI(api_key="your-api-key")

# Define the chat completion request
response = openai_obj.ChatCompletion.create(
    model="gpt-35-turbo",  # Specify your deployment model name
    messages=[
        {"role": "system", "content": "You are a helpful assistant."},
        {"role": "user", "content": "Hello world!"},
    ],
)

# Print the response
print(response)

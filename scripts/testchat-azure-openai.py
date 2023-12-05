import os
import requests
import json
import openai

openai.api_key = ""
# os.getenv("AZURE_OPENAI_KEY")
openai.api_base = ""
# os.getenv("AZURE_OPENAI_ENDPOINT")
openai.api_type = 'azure'
openai.api_version = '2023-05-15' # this may change in the future

deployment_name='gpt-35-turbo' # Azure OpenAI Studio > Management > Deployments

# Send a completion call to generate an answer
print('Sending a test completion job to Azure...')
start_phrase = 'Who won the Kentucky Derby in 1966 ? '
response = openai.Completion.create(engine=deployment_name, prompt=start_phrase, max_tokens=50, temperature=0.7)
text = response['choices'][0]['text'].replace('\n', '').replace(' .', '.').strip()
# text = response['choices'][0]['text'].strip()
print(start_phrase+text)
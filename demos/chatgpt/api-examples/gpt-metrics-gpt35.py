import openai
import time

openai.api_key = ""

messages = [
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "Translate the following English text to French: 'Hello, world'"},
]

start_time = time.time()

response = openai.ChatCompletion.create(
  model="gpt-3.5-turbo",
  messages=messages,
)

end_time = time.time()

print(f"Prompt: {messages}")
print(f"Completion: {response['choices'][0]['message']['content']}")

prompt_tokens = response['usage']['prompt_tokens']
completion_tokens = response['usage']['total_tokens'] - prompt_tokens

print(f"Prompt token length: {prompt_tokens}")
print(f"Completion token length: {completion_tokens}")
print(f"Overall token length: {prompt_tokens + completion_tokens}")
print(f"Time taken to generate the completion: {end_time - start_time} seconds")
print(f"Cost: {response['usage']['total_tokens'] * 0.0002} USD")

import openai

openai.api_key = "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"

response = openai.ChatCompletion.create(
  model="gpt-3.5-turbo",
  messages=[
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "What's the weather like today?"},
    {"role": "assistant", "content": "I'm an AI and I don't have access to real-time data. However, you can check the weather on a weather website or app."},
    {"role": "user", "content": "Translate the following English text to French: 'Hello, how are you?'"},
  ]
)

print(response['choices'][0]['message']['content'])
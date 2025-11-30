import openai

openai.api_key = ""

completion = openai.ChatCompletion.create(
  model="fine-tuned-model-name",
  messages=[
    {"role": "system", "content": "You are a helpful customer service chatbot."},
    {"role": "user", "content": "What are some things I can do with the WonderWidget?"}
  ]
)

print(completion.choices[0].message)
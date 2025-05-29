import openai
import time
import os

# Set up OpenAI API credentials
openai.api_key = ""

# Set up the prompt and parameters for the chat completion
prompt = "Hello, how are you?"
model = "text-davinci-002"
temperature = 0.2
max_tokens = 50

# Calculate the prompt length
prompt_length = len(prompt.split())

# Generate the chat completion and time how long it takes
start_time = time.time()
response = openai.Completion.create(
  engine=model,
  prompt=prompt,
  temperature=temperature,
  max_tokens=max_tokens
)
end_time = time.time()

# Calculate the completion length and total token length
completion_length = len(response.choices[0].text.split())
total_token_length = prompt_length + completion_length
cost = total_token_length * 0.00006  # Assume a cost of $0.00006 per token

# Clear the console screen
os.system('cls' if os.name == 'nt' else 'clear')

# Display the response, prompt length, completion length, and total token length
print(response.choices[0].text)
print(f"Prompt length: {prompt_length}")
print(f"Completion length: {completion_length}")
print(f"Total token length: {total_token_length}")
print(f"Time taken: {end_time - start_time:.2f} seconds")
print(f"Estimated cost: ${cost:.4f}")
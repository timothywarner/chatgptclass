# From OpenAI Cookbook: https://timw.info/k71

import tiktoken
import os

def num_tokens_from_string(string: str, encoding_name: str) -> int:
    """Returns the number of tokens in a text string."""
    encoding = tiktoken.get_encoding(encoding_name)
    num_tokens = len(encoding.encode(string))
    return num_tokens

# Clear the console screen
os.system('cls' if os.name == 'nt' else 'clear')

print("Token count: " + str(num_tokens_from_string("The rain in Spain falls mainly on the plain.", "cl100k_base")))
import openai
import os


def get_etymology(name):
    try:
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "system",
                 "content": "You are an etymology specialist. You provide the etymology of a name, the meaning of the name, and it's trend in popularity over time."},
                {
                    "role": "user",
                    "content": f"What is the etymology of the name {name}?",
                },
            ],
        )
        try:
            return response.choices[0].message["content"]
        except Exception as e:
            return f"An error occurred: {e}"


def main():
    openai.api_key = os.environ.get("OPENAI_API_KEY")

    if not openai.api_key:
        print(
            "OpenAI API key not found. Please set the OPENAI_API_KEY environment variable."
        )
        return

    name = input("Enter a first name: ")
    etymology = get_etymology(name)

    print("\nEtymology:")
    print(etymology)


if __name__ == "__main__":
    main()

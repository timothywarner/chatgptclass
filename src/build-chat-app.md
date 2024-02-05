# Build sample Node.js apps

## Set up directory

mkdir gpt-node-app
cd gpt-node-app

## Initialize the project

npm init -y

## Install the OpenAI library

npm install openai

## Add this code to `app.js`

const axios = require('axios');
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Replace with your OpenAI API key
const API_KEY = 'your_openai_api_key_here';

// Configure axios instance for GPT API
const gptAxios = axios.create({
  baseURL: 'https://api.openai.com/v1',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${API_KEY}`
  }
});

// Function to call the GPT API
async function generateText(prompt) {
  try {
    const response = await gptAxios.post('/engines/davinci-codex/completions', {
      prompt: prompt,
      max_tokens: 50,
      n: 1,
      stop: null,
      temperature: 1.0,
    });

    return response.data.choices[0].text;
  } catch (error) {
    console.error('Error calling GPT API:', error);
    return null;
  }
}

// Main function to run the app
async function main() {
  rl.question('Enter your prompt: ', async (prompt) => {
    const generatedText = await generateText(prompt);
    console.log('Generated text:', generatedText);
    rl.close();
  });
}

main();


## Run the app

node app.js


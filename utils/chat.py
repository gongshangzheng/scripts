#!/bin/bash
# ================================================================
#   Copyright (C) 2024 www.361way.com site All rights reserved.
#
#   Filename      ：openai.sh
#   Author        ：yangbk <itybku@139.com>
#   Create Time   ：2024-12-12 21:11
#   Description   ：
# ================================================================
import requests

# Set your OpenAI API key
api_key = "sk-v0FSVTlrTmwOzWbfvPAzYtQYVh8d7wFYQ4mLq0JKkuMHK1Zp"

# Set the base URL to the custom API endpoint
base_url = "https://api.chatanywhere.tech/v1/completions"

# Function to send a message to the custom API endpoint
def chat_with_custom_api(message):
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json"
    }

    data = {
        "model": "gpt-3.5-turbo",  # Or change this to gpt-4 if applicable
        "prompt": message,
        "max_tokens": 150
    }

    # Send the request to the custom endpoint
    response = requests.post(base_url, json=data, headers=headers)

    if response.status_code == 200:
        return response.json()["choices"][0]["text"].strip()
    else:
        return f"Error: {response.status_code} - {response.text}"

# Example conversation
user_input = input("You: ")
gpt_response = chat_with_custom_api(user_input)
print(f"GPT: {gpt_response}")


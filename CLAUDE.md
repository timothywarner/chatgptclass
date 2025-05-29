# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a ChatGPT and GitHub Copilot training course repository designed for a 4-hour hands-on workshop. The course teaches professionals how to use AI tools (ChatGPT and GitHub Copilot) across various roles including developers, IT ops, data scientists, and information workers.

## Common Development Tasks

### Python Development
- Main Python code is in `/src/` directory
- Dependencies: `pip install -r src/requirements.txt`
- Note: The requirements.txt contains intentionally outdated packages with security vulnerabilities for educational purposes
- Flask app entry point: `python src/app.py` or `python chat_app/run.py`

### Running Examples
- OpenAI API examples: `python src/call_openai_api.py`, `python src/sample_openai_chat.py`
- Data analysis: `python src/data_analysis.py`
- Fine-tuning demos: `python src/fine-tuning.py`

### Docker
- Build: `docker build -f src/Dockerfile -t chatgpt-demo .`
- Run: `docker run -p 5000:5000 chatgpt-demo`

## Code Architecture

### Directory Structure
- `/src/` - Python examples, API integrations, and demos (intentionally vulnerable for security education)
- `/chat_app/` - Flask-based chat application template
- `/exercises/` - Structured course exercises by tool (ChatGPT/Copilot) and role
- `/Datasets/` - CSV datasets for hands-on data analysis exercises
- `/knowledge/` - YAML-based learning modules
- `/tim-dev/` - Instructor materials and utilities

### Key Components
1. **API Integration Scripts** - Multiple OpenAI API examples demonstrating various features
2. **Security Demos** - Intentionally vulnerable code for teaching security best practices
3. **Data Processing** - Scripts using pandas for data analysis exercises
4. **Web Applications** - Flask-based chat app demonstrating API integration
5. **Automation Scripts** - PowerShell scripts for Windows/Surface optimization and GitHub automation

### Important Notes
- This is primarily an educational repository with example code
- Many dependencies are intentionally outdated for security demonstration purposes
- No formal test suite or linting configuration exists
- Code examples are designed for learning, not production use
- The repository contains both working examples and incomplete templates for exercises

## API Keys and Configuration
When working with OpenAI API examples:
- Set environment variable `OPENAI_API_KEY` for OpenAI examples
- Azure OpenAI examples may require additional configuration
- Never commit API keys or sensitive information to the repository
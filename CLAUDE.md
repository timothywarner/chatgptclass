# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a ChatGPT and GitHub Copilot training course repository designed for a 4-hour hands-on workshop. The course teaches professionals how to use AI tools (ChatGPT and GitHub Copilot) across various roles including developers, IT ops, data scientists, and information workers.

## Directory Structure

```
/
├── labs/                    # Hands-on exercises organized by teaching hour
│   ├── hour-1-chatgpt/     # ChatGPT foundations + Projects
│   ├── hour-2-chatgpt/     # Advanced ChatGPT + Agents
│   ├── hour-3-copilot/     # Copilot core + Chat modes
│   └── hour-4-copilot/     # Enterprise + Agentic coding
│
├── demos/                   # Live demonstration code
│   ├── chatgpt/            # ChatGPT-related demos
│   │   ├── api-examples/   # OpenAI/Azure API integration
│   │   ├── fine-tuning/    # Model customization
│   │   └── data-analysis/  # Data analysis examples
│   ├── copilot/            # GitHub Copilot demos
│   ├── mcp/                # Model Context Protocol server
│   ├── security-scanning/  # Secret detection demos
│   └── vulnerable-code/    # INTENTIONALLY VULNERABLE (security education)
│
├── datasets/               # CSV/JSON datasets for exercises
├── apps/                   # Sample applications
│   ├── flask-chat/        # Flask chat app template
│   └── custom-gpt/        # Custom GPT examples
│
├── scripts/                # Utility scripts
│   ├── devops/            # CI/CD, Dependabot, deployment
│   ├── utilities/         # Helper scripts
│   └── windows/           # Windows/Surface optimization
│
├── docs/                   # Documentation
│   ├── instructor/        # Instructor materials
│   └── archive/           # Previous course plans
│
└── assets/images/          # Course images
```

## Common Development Tasks

### Python Development
- Vulnerable demo code: `demos/vulnerable-code/` (INTENTIONALLY VULNERABLE)
- Dependencies: `pip install -r demos/vulnerable-code/requirements.txt`
- Note: requirements.txt contains intentionally outdated packages with security vulnerabilities for educational purposes

### Running Examples
- OpenAI API examples: `python demos/chatgpt/api-examples/call_openai_api.py`
- Data analysis: `python demos/chatgpt/data-analysis/data_analysis.py`
- Fine-tuning demos: `python demos/chatgpt/fine-tuning/fine-tuning.py`

### Docker (Vulnerable Demo)
- Build: `docker build -f demos/vulnerable-code/Dockerfile -t chatgpt-demo .`
- Run: `docker run -p 5000:5000 chatgpt-demo`

### MCP Demo Server
- Location: `demos/mcp/weather-server/`
- Install: `cd demos/mcp/weather-server && npm install`
- Run: `node server.js`

## Key Components

1. **API Integration Scripts** (`demos/chatgpt/api-examples/`) - OpenAI and Azure OpenAI examples
2. **Security Demos** (`demos/vulnerable-code/`) - Intentionally vulnerable code for teaching
3. **Copilot Demos** (`demos/copilot/`) - Test generation, refactoring examples
4. **MCP Server** (`demos/mcp/`) - Model Context Protocol weather server demo
5. **Data Processing** - Scripts using pandas for data analysis exercises
6. **Datasets** (`datasets/`) - CSV files organized by domain (HR, Finance, Marketing, etc.)

## Important Notes

- This is primarily an educational repository with example code
- `demos/vulnerable-code/` contains INTENTIONALLY vulnerable code for security demonstration
- Many dependencies are intentionally outdated for security demonstration purposes
- No formal test suite or linting configuration exists
- Code examples are designed for learning, not production use

## API Keys and Configuration

When working with OpenAI API examples:
- Set environment variable `OPENAI_API_KEY` for OpenAI examples
- Azure OpenAI examples may require additional configuration
- Never commit API keys or sensitive information to the repository

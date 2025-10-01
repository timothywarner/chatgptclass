# Contributing to ChatGPT and GitHub Copilot Course

Thank you for your interest in contributing to this educational repository! 🎉

## 📋 Table of Contents

- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Contributing Guidelines](#contributing-guidelines)
- [Submitting Changes](#submitting-changes)
- [Code of Conduct](#code-of-conduct)

## 🚀 Getting Started

This repository contains educational materials for a 4-hour course on ChatGPT and GitHub Copilot. We welcome contributions that help improve the learning experience for students.

### Types of Contributions

- 📚 **Documentation improvements**
- 🐛 **Bug fixes in demo code**
- ✨ **New exercises and examples**
- 🔧 **Tool improvements and automation**
- 🎯 **Course content enhancements**

## 💻 Development Setup

### Prerequisites

- Python 3.8+ with virtual environment support
- Node.js 18+ (for MCP demos)
- Git
- A text editor or IDE with markdown support

### Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/timothywarner/chatgptclass.git
   cd chatgptclass
   ```

2. **Set up Python environment**
   ```bash
   python -m venv .venv
   
   # On Unix/macOS:
   source .venv/bin/activate
   
   # On Windows:
   .venv\Scripts\Activate.ps1
   ```

3. **Install Python dependencies**
   ```bash
   pip install -r src/requirements.txt
   ```

4. **Set up Node.js dependencies (for MCP demos)**
   ```bash
   cd mcp-demos/weather-server
   npm install
   cd ../..
   ```

5. **Configure environment variables**
   ```bash
   # Copy example environment file
   cp .env.example .env
   # Edit .env with your API keys
   ```

## 📝 Contributing Guidelines

### Branch Naming Convention

Use descriptive branch names with the following prefixes:

- `feature/` - New features or enhancements
- `fix/` - Bug fixes
- `docs/` - Documentation updates
- `refactor/` - Code refactoring
- `test/` - Adding or updating tests

Examples:
- `feature/add-new-chatgpt-exercise`
- `fix/broken-api-demo`
- `docs/update-installation-guide`

### Commit Message Format

Follow the imperative, sentence-case format as shown in the repository history:

- ✅ `Add new ChatGPT prompting exercise`
- ✅ `Fix authentication bug in API demo`
- ✅ `Update installation instructions`
- ❌ `added new exercise`
- ❌ `fixing bugs`

### Code Style

#### Python Code
- Use 4-space indentation
- Follow `snake_case` for variables and functions
- Include docstrings for functions
- Use environment variables for API keys (never hardcode)

#### Markdown Documentation
- Use consistent heading levels
- Include code language specifiers in fenced blocks
- Keep line lengths reasonable (no strict limit)
- Use relative links for internal references

### Testing Guidelines

- Add `pytest` tests for Python code under `tests/`
- Mirror the package structure (`tests/test_app.py` for `src/app.py`)
- Run `pytest -q` locally before submitting
- Include fixtures for sample datasets
- Document manual validation steps in PR description

## 🔄 Submitting Changes

### Pull Request Process

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-descriptive-name
   ```

2. **Make your changes**
   - Follow the coding standards above
   - Test your changes thoroughly
   - Update documentation as needed

3. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add descriptive commit message"
   ```

4. **Push to your fork or branch**
   ```bash
   git push origin feature/your-descriptive-name
   ```

5. **Create a Pull Request**
   - Use the PR template if available
   - Link relevant issues
   - Provide clear description of changes
   - Include screenshots for UI changes
   - Note any new configuration requirements

### PR Requirements

- [ ] Changes are tested and working
- [ ] Documentation updated if needed
- [ ] Commit messages follow the format
- [ ] No sensitive data (API keys, etc.) committed
- [ ] Screenshots included for learner-facing changes

## 🛡️ Security Considerations

- **Never commit API keys or secrets**
- Use environment variables for configuration
- Follow the security guidelines in `SECURITY.md`
- Report security issues privately (see `SECURITY.md`)

## 🎯 Content Guidelines

### For Educational Materials

- Keep explanations clear and beginner-friendly
- Include practical examples
- Provide context for why something is important
- Test all code examples before submitting
- Include common troubleshooting tips

### For Exercises

- Clearly state learning objectives
- Provide step-by-step instructions
- Include expected outcomes
- Add difficulty level indicators
- Consider different skill levels

## 🤝 Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help create a welcoming learning environment
- Follow GitHub's community guidelines

## 📞 Getting Help

- Create an issue for bugs or feature requests
- Use discussions for questions about content
- Tag @timothywarner for urgent matters
- Check existing issues before creating new ones

## 🙏 Recognition

Contributors will be acknowledged in:
- Repository contributors list
- Course materials (where appropriate)
- Release notes for significant contributions

Thank you for helping make this course better for everyone! 🌟
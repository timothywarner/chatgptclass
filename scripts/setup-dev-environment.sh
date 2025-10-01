#!/bin/bash

# Development Environment Setup Script for ChatGPT Class Repository
# This script automates the setup of the development environment

set -e  # Exit on any error

echo "🚀 Setting up ChatGPT Class development environment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "README.md" ] || [ ! -d "src" ]; then
    print_error "Please run this script from the root of the chatgptclass repository"
    exit 1
fi

print_status "Checking prerequisites..."

# Check Python version
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version | cut -d' ' -f2 | cut -d'.' -f1,2)
    print_success "Python 3 found: $(python3 --version)"
    
    # Check if version is 3.8 or higher
    if python3 -c "import sys; exit(0 if sys.version_info >= (3, 8) else 1)"; then
        print_success "Python version is 3.8 or higher"
    else
        print_warning "Python 3.8+ recommended. Current version: $PYTHON_VERSION"
    fi
else
    print_error "Python 3 is required but not found. Please install Python 3.8 or higher."
    exit 1
fi

# Check Node.js version
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    print_success "Node.js found: $NODE_VERSION"
    
    # Check if version is 18 or higher
    NODE_MAJOR=$(echo $NODE_VERSION | cut -d'.' -f1 | cut -d'v' -f2)
    if [ "$NODE_MAJOR" -ge 18 ]; then
        print_success "Node.js version is 18 or higher"
    else
        print_warning "Node.js 18+ recommended. Current version: $NODE_VERSION"
    fi
else
    print_warning "Node.js not found. Install Node.js 18+ for MCP demos."
fi

# Check Git
if command -v git &> /dev/null; then
    print_success "Git found: $(git --version)"
else
    print_error "Git is required but not found."
    exit 1
fi

print_status "Setting up Python virtual environment..."

# Create virtual environment if it doesn't exist
if [ ! -d ".venv" ]; then
    python3 -m venv .venv
    print_success "Created Python virtual environment"
else
    print_status "Virtual environment already exists"
fi

# Activate virtual environment
print_status "Activating virtual environment..."
source .venv/bin/activate

# Upgrade pip
print_status "Upgrading pip..."
pip install --upgrade pip

# Install Python dependencies
print_status "Installing Python dependencies..."
if [ -f "src/requirements.txt" ]; then
    pip install -r src/requirements.txt
    print_success "Python dependencies installed"
else
    print_warning "src/requirements.txt not found, skipping Python dependencies"
fi

# Set up Node.js dependencies for MCP demos
if command -v npm &> /dev/null && [ -d "mcp-demos/weather-server" ]; then
    print_status "Setting up MCP demo dependencies..."
    cd mcp-demos/weather-server
    npm install
    cd ../..
    print_success "MCP demo dependencies installed"
else
    print_warning "npm not found or mcp-demos directory missing, skipping Node.js setup"
fi

# Create .env file from template if it doesn't exist
print_status "Setting up environment configuration..."
if [ ! -f ".env" ]; then
    if [ -f ".env.example" ]; then
        cp .env.example .env
        print_success "Created .env file from template"
        print_warning "Please edit .env file with your API keys"
    else
        cat > .env << EOF
# API Keys - Replace with your actual keys
OPENAI_API_KEY=your_openai_api_key_here
GITHUB_TOKEN=your_github_token_here

# Optional: Azure OpenAI (if using Azure instead of OpenAI)
AZURE_OPENAI_ENDPOINT=https://your-resource.openai.azure.com/
AZURE_OPENAI_API_KEY=your_azure_openai_key_here
AZURE_OPENAI_API_VERSION=2024-02-15-preview

# Development settings
FLASK_ENV=development
FLASK_DEBUG=1
EOF
        print_success "Created .env file with template"
        print_warning "Please edit .env file with your actual API keys"
    fi
else
    print_status ".env file already exists"
fi

# Set up pre-commit hooks if available
if [ -f ".pre-commit-config.yaml" ]; then
    print_status "Setting up pre-commit hooks..."
    if command -v pre-commit &> /dev/null; then
        pre-commit install
        print_success "Pre-commit hooks installed"
    else
        print_warning "pre-commit not found. Install with: pip install pre-commit"
    fi
fi

# Check if we can run tests
print_status "Checking test setup..."
if command -v pytest &> /dev/null; then
    print_success "pytest available for testing"
    if [ -d "tests" ]; then
        print_status "tests directory found"
    else
        print_warning "tests directory not found"
    fi
else
    print_warning "pytest not found. Install with: pip install pytest"
fi

print_success "🎉 Development environment setup complete!"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. Edit .env file with your API keys"
echo "2. Run 'source .venv/bin/activate' to activate the Python environment"
echo "3. Test the setup with: python src/test_setup.py (if available)"
echo "4. Start developing! 🚀"
echo ""
echo -e "${YELLOW}Useful commands:${NC}"
echo "  pytest -q                    # Run tests"
echo "  python src/app.py            # Run main demo"
echo "  python chat_app/run.py       # Run chat application"
echo "  cd mcp-demos/weather-server && npm start  # Run MCP demo"
echo ""
echo -e "${BLUE}Documentation:${NC}"
echo "  README.md         # Course overview and resources"
echo "  CONTRIBUTORS.md   # How to contribute"
echo "  AGENTS.md         # Development guidelines"
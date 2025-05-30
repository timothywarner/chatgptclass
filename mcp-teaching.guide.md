# MCP Teaching Guide - GitHub Copilot in 4 Hours

**Model Context Protocol (MCP)** is the "USB-C of AI" - a standardized way to connect AI models to different data sources and tools.

## **Quick Setup for VS Code Demo**

### **1. Enable MCP in VS Code**
```json
{
  "chat.mcp.enabled": true
}
```

### **2. Install Essential MCP Servers**

**GitHub Server (30 seconds setup):**
```bash
# Your token is already set as TIM_GITHUB_TOKEN
# VS Code will automatically use: ${env:TIM_GITHUB_TOKEN}

# Add to VS Code settings or .vscode/mcp.json
{
  "mcp": {
    "servers": {
      "github": {
        "command": "npx",
        "args": ["-y", "@modelcontextprotocol/server-github"],
        "env": {
          "GITHUB_PERSONAL_ACCESS_TOKEN": "${env:TIM_GITHUB_TOKEN}"
        }
      }
    }
  }
}
```

**Filesystem Server (no setup required):**
```json
{
  "mcp-filesystem": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-filesystem", "--allowed-dirs", "."]
  }
}
```

## **Teaching Demo Servers**

### **Demo 1: Simple Calculator MCP Server**

Create `calculator-mcp.py`:
```python
#!/usr/bin/env python3
"""Simple calculator MCP server for teaching."""

import asyncio
from mcp.server.fastmcp import FastMCP

# Initialize server
mcp = FastMCP("calculator")

@mcp.tool()
def add(a: float, b: float) -> float:
    """Add two numbers together."""
    return a + b

@mcp.tool()
def multiply(a: float, b: float) -> float:
    """Multiply two numbers."""
    return a * b

@mcp.tool()
def calculate_compound_interest(
    principal: float,
    rate: float,
    time: float,
    compounds_per_year: int = 12
) -> dict:
    """Calculate compound interest for financial planning."""
    amount = principal * (1 + rate/compounds_per_year)**(compounds_per_year * time)
    interest = amount - principal

    return {
        "principal": principal,
        "final_amount": round(amount, 2),
        "interest_earned": round(interest, 2),
        "rate": f"{rate*100}%",
        "time_years": time
    }

if __name__ == "__main__":
    mcp.run()
```

**Setup:**
```bash
# Install dependencies
pip install "mcp[cli]"

# Test the server
python calculator-mcp.py

# Add to VS Code
{
  "calculator": {
    "command": "python",
    "args": ["./calculator-mcp.py"]
  }
}
```

### **Demo 2: Weather Teaching Server**

Create `weather-mcp.py`:
```python
#!/usr/bin/env python3
"""Weather MCP server - demonstrates API integration."""

import asyncio
import httpx
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("weather")

# Constants
NWS_API_BASE = "https://api.weather.gov"
USER_AGENT = "education-demo/1.0"

@mcp.tool()
async def get_forecast(latitude: float, longitude: float) -> dict:
    """Get weather forecast for given coordinates."""
    async with httpx.AsyncClient() as client:
        # Get grid point
        response = await client.get(
            f"{NWS_API_BASE}/points/{latitude},{longitude}",
            headers={"User-Agent": USER_AGENT}
        )
        data = response.json()

        # Get forecast
        forecast_url = data["properties"]["forecast"]
        forecast_response = await client.get(
            forecast_url,
            headers={"User-Agent": USER_AGENT}
        )

        return forecast_response.json()

@mcp.tool()
async def get_weather_alerts(state: str) -> dict:
    """Get weather alerts for a US state (e.g., 'TX', 'CA')."""
    async with httpx.AsyncClient() as client:
        response = await client.get(
            f"{NWS_API_BASE}/alerts?area={state}",
            headers={"User-Agent": USER_AGENT}
        )
        return response.json()

if __name__ == "__main__":
    mcp.run()
```

**Dependencies:**
```bash
pip install "mcp[cli]" httpx
```

### **Demo 3: Code Documentation Generator**

Create `docs-mcp.py`:
```python
#!/usr/bin/env python3
"""Documentation generator MCP server."""

import os
import ast
from mcp.server.fastmcp import FastMCP

mcp = FastMCP("docs-generator")

@mcp.tool()
def analyze_python_file(file_path: str) -> dict:
    """Analyze a Python file and extract documentation info."""
    if not os.path.exists(file_path):
        return {"error": "File not found"}

    with open(file_path, 'r') as f:
        content = f.read()

    try:
        tree = ast.parse(content)

        functions = []
        classes = []

        for node in ast.walk(tree):
            if isinstance(node, ast.FunctionDef):
                functions.append({
                    "name": node.name,
                    "docstring": ast.get_docstring(node),
                    "args": [arg.arg for arg in node.args.args],
                    "line": node.lineno
                })
            elif isinstance(node, ast.ClassDef):
                classes.append({
                    "name": node.name,
                    "docstring": ast.get_docstring(node),
                    "line": node.lineno
                })

        return {
            "file": file_path,
            "functions": functions,
            "classes": classes,
            "total_lines": len(content.splitlines())
        }

    except SyntaxError as e:
        return {"error": f"Syntax error: {e}"}

@mcp.resource()
def list_project_files() -> str:
    """List all Python files in current project."""
    python_files = []
    for root, dirs, files in os.walk("."):
        for file in files:
            if file.endswith(".py"):
                python_files.append(os.path.join(root, file))

    return "\\n".join(python_files)

if __name__ == "__main__":
    mcp.run()
```

## **VS Code Integration Steps**

### **Method 1: Workspace Configuration**
Create `.vscode/mcp.json`:
```json
{
  "mcpServers": {
    "calculator": {
      "command": "python",
      "args": ["./mcp-demos/calculator-mcp.py"]
    },
    "weather": {
      "command": "python",
      "args": ["./mcp-demos/weather-mcp.py"]
    },
    "docs": {
      "command": "python",
      "args": ["./mcp-demos/docs-mcp.py"]
    }
  }
}
```

### **Method 2: User Settings**
Add to `settings.json`:
```json
{
  "mcp": {
    "servers": {
      // Your servers here
    }
  }
}
```

## **Teaching Flow - 4 Hour Schedule**

### **Hour 1: MCP Fundamentals (45 min + 15 min hands-on)**
- What is MCP and why it matters
- Architecture: Client ↔ Server ↔ Data Sources
- Live demo: GitHub server in VS Code
- **Hands-on**: Install GitHub MCP server

### **Hour 2: Building Simple Servers (30 min theory + 30 min coding)**
- MCP server anatomy
- Tools vs Resources vs Prompts
- **Live coding**: Calculator server
- **Student exercise**: Add division function

### **Hour 3: Real-World Integration (45 min + 15 min demo)**
- API integration with Weather server
- Error handling and security
- **Advanced demo**: Documentation generator
- **Discussion**: Enterprise use cases

### **Hour 4: Production & Ecosystem (30 min + 30 min workshop)**
- Deployment strategies
- Available MCP servers ecosystem
- Testing with MCP Inspector
- **Workshop**: Students deploy their own server

## **Quick Commands for Teaching**

**Test MCP Server:**
```bash
# Install MCP CLI
pip install "mcp[cli]"

# Test server manually
python your-server.py

# Use MCP Inspector (web-based testing)
npx @modelcontextprotocol/inspector
```

**One-Click GitHub Server:**
```bash
npx @modelcontextprotocol/server-github
```

**Common Issues & Fixes:**
- **"Server not found"**: Check file paths are absolute
- **"Permission denied"**: Ensure Python executable is in PATH
- **"Connection failed"**: Restart VS Code after config changes

## **Student Takeaways**

1. **MCP is the future** - Standardized AI integration layer
2. **Simple to build** - FastMCP makes servers easy
3. **Enterprise ready** - Security, scalability built-in
4. **Ecosystem growing** - 1000+ community servers available
5. **Career relevant** - OpenAI, Google adopting MCP standard

## **Resources for Students**

- **MCP Documentation**: https://modelcontextprotocol.io
- **GitHub Repository**: https://github.com/modelcontextprotocol
- **Server Examples**: https://github.com/modelcontextprotocol/servers
- **VS Code Integration**: Enable `chat.mcp.enabled` setting

---

**Pro tip**: MCP transforms the "M×N problem" of integrating M AI applications with N tools into an "M+N problem" - build once, use everywhere!

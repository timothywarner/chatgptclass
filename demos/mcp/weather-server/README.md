# Weather MCP Server Demo

A simple Model Context Protocol (MCP) server that provides weather information for teaching and demonstration purposes.

## What is MCP?

MCP (Model Context Protocol) allows AI assistants like Claude to interact with external tools and services through a standardized protocol. This weather server demonstrates how to build a simple MCP server.

## Available Tools

1. **get_weather** - Get current weather for a specific city
   - Input: `city` (string) - The city name
   - Returns: Temperature, conditions, humidity, wind, and forecast

2. **list_cities** - List all available cities
   - No input required
   - Returns: List of cities with available weather data

## Setup Instructions

1. Install dependencies:
   ```bash
   cd mcp-demos/weather-server
   npm install
   ```

2. The server is configured in `.vscode/mcp.json` and will be available in VS Code with Claude

## How It Works

The server:
- Uses the MCP SDK to create a server that communicates via stdio
- Defines two tools that Claude can call
- Returns mock weather data for demonstration (no API key needed!)

## Teaching Points

1. **Simple Implementation** - Shows basic MCP server structure
2. **No External Dependencies** - Uses hardcoded data for reliability in demos
3. **Clear Tool Design** - Demonstrates good tool naming and descriptions
4. **Error Handling** - Shows how to handle missing cities gracefully

## Example Usage in Claude

Once configured, you can ask Claude:
- "What's the weather in Seattle?"
- "Show me all available cities"
- "Compare weather between New York and Miami"
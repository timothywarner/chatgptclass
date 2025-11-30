# MCP Server Demo Guide

## Quick Setup

1. **Install the weather server dependencies:**
   ```bash
   cd mcp-demos/weather-server
   npm install
   ```

2. **Restart VS Code** to load the MCP configuration

3. **In Claude (VS Code)**, you can now use weather commands!

## Demo Script

### Basic Weather Query
"What's the weather in Seattle?"

### List Available Cities
"What cities do you have weather data for?"

### Compare Weather
"Compare the weather between Miami and Chicago"

### Error Handling Demo
"What's the weather in Paris?" (Shows graceful error handling)

## How MCP Works

1. **Configuration**: `.vscode/mcp.json` tells VS Code which MCP servers to run
2. **Server**: The Node.js server implements the MCP protocol
3. **Tools**: The server exposes tools that Claude can call
4. **Integration**: Claude automatically discovers and uses these tools

## Teaching Points

- **Extensibility**: Show how easy it is to add new cities or weather properties
- **Protocol**: Explain the request/response pattern
- **Real-world Use**: Discuss how this could connect to real weather APIs
- **Error Handling**: Demonstrate robustness with invalid inputs

## Troubleshooting

- If tools don't appear, restart VS Code
- Check the Output panel (View > Output > "MCP") for server logs
- Ensure Node.js is installed (`node --version`)

## Next Steps

1. Try enabling the filesystem MCP server (set `"disabled": false`)
2. Add more weather properties (UV index, precipitation, etc.)
3. Create your own MCP server for a different domain!
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a ChatGPT and GitHub Copilot training course repository for a 4-hour O'Reilly hands-on workshop (March 2026 delivery). The course teaches professionals how to use AI tools across developer, IT ops, data science, and information worker roles.

## Course Architecture

The repository follows a **4-hour teaching cadence**:
- **Hour 1**: ChatGPT fundamentals (tiers, Projects, Tasks, Custom GPTs)
- **Hour 2**: Advanced ChatGPT + agentic AI (Codex, Sora 2, data analysis)
- **Hour 3**: GitHub Copilot core (tiers, models, chat modes, custom instructions)
- **Hour 4**: Enterprise + agentic coding (MCP, Copilot CLI, coding agent, governance)

The current course plan lives at `course-plan-march-2026.md`. A detailed news timeline is at `whats-new-march-2026.md`. Previous plans are archived in `docs/archive/`.

## Key File Relationships

- `course-plan-march-2026.md` - Master course plan with detailed timings and content
- `warner-chatgpt-github-copilot-march-2026.pptx` - Presentation deck (binary, matches course plan)
- `.github/copilot-instructions.md` - Teaching example for Copilot custom instructions
- `.github/agents/` - Custom agent definitions (teaching examples)
- `.github/instructions/` - Path-specific instruction files (teaching examples)
- `docs/instructor/mcp-teaching.guide.md` - MCP demo setup with 3 Python servers (calculator, weather, docs-generator)

## Running Demo Code

**OpenAI API examples:**
```bash
export OPENAI_API_KEY="your-key"
python demos/chatgpt/api-examples/call_openai_api.py
```

**MCP demo servers** (require `pip install "mcp[cli]" httpx`):
```bash
# Calculator server
python demos/mcp/calculator-mcp.py

# Weather server (from teaching guide)
python demos/mcp/weather-mcp.py

# MCP Inspector for testing
npx @modelcontextprotocol/inspector
```

**Weather MCP server** (Node.js):
```bash
cd demos/mcp/weather-server && npm install && node server.js
```

**Vulnerable demo** (Docker):
```bash
docker build -f demos/vulnerable-code/Dockerfile -t chatgpt-demo .
docker run -p 5000:5000 chatgpt-demo
```

## Intentionally Vulnerable Code

`demos/vulnerable-code/` and `demos/security-scanning/` contain **intentionally insecure** code and outdated dependencies for security education demos. Do not "fix" these unless explicitly asked. The `requirements.txt` in `demos/vulnerable-code/` has known CVEs by design.

## Technology Landscape (March 2026)

When updating course content, these are the current-gen references:

**ChatGPT / OpenAI**: GPT-5.3 Instant (default chat), GPT-5.2 Pro (flagship), GPT-5.3-Codex + Codex-Spark (coding), ChatGPT Go ($8/mo), Tasks (Plus 40/mo, Pro unlimited), ChatGPT Agent (browser automation via /agent), Deep Research (GPT-5.2 powered), Canvas (out of beta), Sora 2 (still no EU/UK), gpt-oss open-weight models. GPT-4o/4.1/o4-mini retired Feb 13, 2026.

**GitHub Copilot**: Copilot CLI (GA Feb 25, 2026) with plan/autopilot modes; coding agent with Claude Sonnet 4.6; models include Claude Opus 4.6 (1M context), GPT-5.3-Codex, Gemini 3 Pro/Flash, Grok Code Fast 1; Enterprise AI Controls GA (Feb 26); Copilot SDK (tech preview); Copilot Memory (preview); Visual Studio 2026 GA as "AI-native IDE"; IntelliCode killed Dec 2025.

**MCP**: Donated to Agentic AI Foundation (Linux Foundation) Dec 2025; 1,860+ servers; Nov 2025 spec with async Tasks, OAuth 2.1, statelessness; Azure MCP Server preview; MCP Dev Summit Apr 2-3, 2026 NYC.

**Claude / Anthropic**: Opus 4.6 (Feb 5, 2026; 1M context, agent teams, adaptive thinking), Sonnet 4.6 (Feb 17, 2026; new default), Claude Code 2.1.x (skills, auto-memory, /teleport).

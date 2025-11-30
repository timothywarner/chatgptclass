# Course Plan: ChatGPT + GitHub Copilot (4h) - November 2025

## Session Schedule

| Hour       | Focus                              | Key Topics / Demos                                                                                      | Labs / Exercises                                           |
| ---------- | ---------------------------------- | ------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------- |
| **HOUR 1** | ChatGPT Foundations + Projects     | Subscription tiers (Free/Go/Plus/Pro), GPT-5 models, Canvas, Projects, Custom GPTs, GPT Store           | Lab: Create Project workspace, build "HR Assistant" GPT    |
| **HOUR 2** | Advanced ChatGPT + Agentic AI      | Codex cloud agent, Sora 2 video, Analysis Engine, Codex CLI, Deep Research                              | Lab: Assign GitHub issue to Codex, data analysis workflow  |
| **HOUR 3** | Copilot Core + Chat Mastery        | Tiers (Free/Pro/Pro+/Business/Enterprise), Model selection, Inline suggestions, Chat modes, Prompts    | Lab: Mode comparison exercise, custom instructions setup   |
| **HOUR 4** | Enterprise + Agentic Coding        | MCP integration, Copilot CLI, Coding Agent (@copilot), Governance & Content Exclusion                   | Lab: Assign issue to @copilot, configure enterprise policy |

---

## Detailed Run-through

### Hour 1: ChatGPT Foundations + Projects

#### Setup & Tiers (10m)
**Subscription Landscape (2025)**
| Tier | Price | Key Features |
|------|-------|--------------|
| Free | $0 | GPT-4o mini, limited GPT-4o, 2 images/day, basic memory |
| Go | Low-cost | Extended GPT-5 access, Projects, Tasks, custom GPTs |
| Plus | $20/mo | GPT-5, o3, Deep Research (25/mo), Sora, 50 images/3hr, Advanced Voice |
| Pro | $200/mo | Unlimited GPT-5, o3-pro reasoning, 1080p Sora, 250 Deep Research/mo |
| Business | $25-30/user | Team collaboration, admin controls, shared workspace |
| Enterprise | Custom | SSO/SCIM, data controls, white glove support |

**Available Models**
- GPT-5 / GPT-5.1 (flagship, 400K context in API)
- GPT-5 Instant (fast default with adaptive reasoning)
- o3 / o3-pro (advanced reasoning, agentic tool use)
- o4-mini (fast, cost-efficient reasoning)
- GPT-4o (multimodal fallback, Advanced Voice)

#### Canvas Workspace (5m)
- Two-pane editing: conversation + document/code
- Writing: suggest edits, adjust length, reading level, polish
- Coding: review code, add logs/comments, fix bugs, port languages
- Export: PDF, Word (.docx), Markdown, code files (.py, .js, .sql)
- Full parity on mobile (June 2025 update)

#### Projects Feature (15m)
**What Are Projects?**
- Smart workspaces organizing chats, files, and custom instructions
- Available to ALL users (Free, Go, Plus, Pro, Business) as of October 2025
- Project-level memory: ChatGPT references previous chats within project

**Key Capabilities**
- File uploads: PDF, DOCX, PPTX, XLSX, TXT, ZIP, images (100MB each, 1GB total)
- Connect to Google Drive / OneDrive
- Custom instructions act as "role" or "style guide" per project
- "Branch in new chat" feature for splitting conversations

**Demo**: Create "Product Launch" project with marketing brief, budget spreadsheet, competitor analysis

#### Custom GPTs (15m)
**Building Custom GPTs** (Plus/Pro/Business required)
1. Go to chatgpt.com/create
2. Chat with GPT Builder to define persona
3. Configure: name, icon, knowledge files, capabilities
4. Enable: Web Search, Canvas, Image Generation, Code Interpreter, Actions
5. Choose model: GPT-4.1, 4.5, o3, o4-mini, or GPT-5 Instant (default)

**GPT Store**
- 3+ million custom GPTs
- Categories: DALL-E, Writing, Research, Programming, Education
- Verify Builder Profile (Twitter/GitHub/LinkedIn) before publishing

**Agent Mode (2025)**: GPTs can now agentically combine ALL ChatGPT tools - search web, analyze files, reason visually, generate images, execute multi-step workflows

#### Lab 1 (15m)
1. **Create Project**: Upload `employee.csv`, add custom instructions for HR context
2. **Build GPT**: Create "HR Assistant" GPT with knowledge file and Code Interpreter enabled
3. **Test**: Query the GPT about employee data, compare to base ChatGPT

---

### Hour 2: Advanced ChatGPT + Agentic AI

#### OpenAI Codex - Cloud Agent (15m)
**What Is Codex?**
- Autonomous software engineering agent running in cloud sandboxes
- Powered by codex-1 (optimized o3) and GPT-5-Codex models
- 352K PRs merged at 85% success rate

**Access Points**
- Web: chatgpt.com/codex
- CLI: `npm i -g @openai/codex` or `brew install --cask codex`
- IDE: VS Code, Cursor, Windsurf extensions
- GitHub: @codex tagging in comments

**Capabilities**
- Assign GitHub issues, returns complete PRs with tests
- Multi-file feature implementation
- Code review via @codex mention
- Operates asynchronously in isolated containers

**Availability**: ChatGPT Plus, Pro, Business, Enterprise (since June 2025)

#### Sora 2 - Video Generation (10m)
**Current Status** (September 2025 release)
- Available: US and Canada only, ChatGPT Plus/Pro
- Access: sora.com or iOS app
- NOT available: UK, EU, EEA countries

**Capabilities**
| Feature | Plus ($20/mo) | Pro ($200/mo) |
|---------|---------------|---------------|
| Videos/month | 50 priority | 500 priority + unlimited |
| Resolution | 480p (720p fewer) | 1080p |
| Duration | Up to 20 seconds | Up to 20 seconds |
| Watermark | Yes | No |
| Storyboard | No | Yes |

**Sora 2 Features**
- Audio integration: synchronized dialogue and sound effects
- Storyboard: sketch video second-by-second (Pro only)
- Remix: modify existing videos with new prompts
- Cameos: insert yourself into AI-generated scenes
- Styles: Thankful, Vintage, Comic, News, Musical, Selfie

**Limitations**: Physics not always accurate, 10-20s practical limit, ~33% error-free rate in testing

#### Analysis Engine / Data Analysis (10m)
**Technical Capabilities**
- Runs Python (pandas, matplotlib, seaborn, plotly) in secure sandbox
- File support: CSV, XLS, XLSX, JSON, PDF, DOCX (up to 512MB)
- Optimal: <50MB files, <800K rows, <300 columns
- Connect: Google Sheets, Docs, OneDrive integration

**Chart Types**
- Non-interactive: Histograms, scatter, box plots, heat maps, treemaps, waterfall
- Interactive: Bar, pie, scatter, line charts

**ChatGPT Agents for Data (July 2025)**
- Automated multi-step analysis: upload spreadsheet, get pivot tables + charts + PowerPoint
- Export to PowerPoint, PDF reports, processed data files

**Requires**: ChatGPT Plus minimum

#### Codex CLI (5m)
**Overview**
- Open-source, local terminal coding agent
- Install: `npm i -g @openai/codex` or `brew install --cask codex`
- Auto-configures API keys when signing in with ChatGPT account

**Approval Modes** (use `/approvals` to switch)
| Mode | Behavior |
|------|----------|
| Auto (default) | Read/edit/run in working directory; asks for outside scope or network |
| Read Only | Browse files only, no changes without approval |
| Full Access | Works across entire machine including network |

**Features**
- Multimodal: accepts screenshots, wireframes, diagrams
- MCP support for external system connections
- To-do tracking for complex work

**Difference from GitHub Copilot CLI**: Codex CLI is autonomous task completion (minutes/hours); Copilot CLI is real-time assistance

#### Lab 2 (10m)
1. **Codex Demo**: Assign a GitHub issue to Codex, observe autonomous PR creation
2. **Data Analysis**: Upload sales CSV, request: "Create 3 charts showing trends, then export to PowerPoint"
3. **Codex CLI** (if time): Run `codex "explain this codebase structure"`

---

### Hour 3: Copilot Core + Chat Mastery

#### Setup & Tiers (5m)
**Subscription Tiers (2025)**
| Tier | Price | Premium Requests | Key Features |
|------|-------|------------------|--------------|
| Free | $0 | 50/month | Students, teachers, OSS maintainers |
| Pro | $10/mo | 300/month | Inline, Chat, PR assist |
| Pro+ | $39/mo | 1,500/month | Full model selection, highest access |
| Business | $19/user/mo | Included | Centralized mgmt, IP indemnity, audit logs |
| Enterprise | $39/user/mo | Included | Knowledge bases, custom models, SSO/SCIM |

**Model Selection** (default: GPT-4.1)
- OpenAI: GPT-4.1, GPT-4.5, GPT-5 (preview), o3, o4-mini
- Anthropic: Claude Sonnet 3.5/3.7/4, Claude Opus 4/4.1 (preview)
- Google: Gemini 2.0 Flash, Gemini 2.5 Pro

**Model Selection Guide**
| Use Case | Recommended Model |
|----------|-------------------|
| General coding | GPT-4.1, GPT-4o |
| Complex reasoning | Gemini 2.5 Pro |
| Large codebases | Claude 3.7 Sonnet |
| Visual/UI work | Gemini 2.0 Flash, GPT-4o |
| Budget-conscious | Claude 3.5 Sonnet |

#### Inline Suggestions (10m)
**How It Works**
- Ghost text suggestions as you type (single or multi-line)
- Context-aware: surrounding code, comments, file type
- Next Edit Suggestions (NES): toggle from chat status bar

**Keyboard Shortcuts**
| Action | Windows/Linux | Mac |
|--------|---------------|-----|
| Accept all | `Tab` | `Tab` |
| Accept next word | `Ctrl+Right` | `Cmd+→` |
| Cycle suggestions | `Alt+]` / `Alt+[` | `Option+]` / `Option+[` |
| Trigger on demand | `Alt+\` | `Alt+\` |
| Open Chat panel | `Ctrl+Alt+I` | `Ctrl+Cmd+I` |
| Inline chat | `Ctrl+I` | `Cmd+I` |

**Demo**: Live coding showing Tab, partial acceptance (Ctrl+Right), cycling through alternatives

#### Chat Modes (15m)
**Four Modes Available**
| Mode | Purpose | Modifies Files? |
|------|---------|-----------------|
| Ask | Q&A, explanations, advice | No |
| Edit | Controlled multi-file edits | Yes (with review) |
| Agent | Autonomous multi-step tasks | Yes (autonomous) |
| Plan | Create implementation plans before coding | No (then yes) |

**Ask Mode**
- Fast, focused, non-destructive
- Example: "Explain this function", "How do I handle auth in Express?"

**Edit Mode** (VS Code, JetBrains)
- Choose files Copilot can modify
- Iterate with natural language
- Review/accept/reject each change

**Agent Mode** (VS Code 1.99+)
- Multi-step autonomous planning
- Self-healing error correction
- Terminal command execution
- ALWAYS consumes premium requests

**Plan Mode** (October 2025)
- Analyzes codebase, generates step-by-step plan
- Validates requirements coverage
- Executes upon approval

**Chat Participants & Variables**
| Participant | Purpose | Example |
|-------------|---------|---------|
| @workspace | Full codebase context | `@workspace find all API endpoints` |
| @terminal | Shell and terminal context | `@terminal #terminalLastCommand explain error` |
| @vscode | IDE commands and settings | `@vscode how to enable auto-save?` |

| Variable | Purpose |
|----------|---------|
| #codebase | All workspace content |
| #editor | Visible code in viewport |
| #selection | Currently selected code |
| #file | Reference specific file |
| #git | Current git repo info |

**Slash Commands**: `/explain`, `/fix`, `/tests`, `/doc`, `/generate`, `/new`

#### Prompts & Custom Instructions (15m)
**Prompt Engineering Best Practices**
1. Broad description first, then specific requirements
2. Break complex tasks into smaller prompts
3. Include technologies, frameworks, patterns
4. Provide input/output examples
5. Iterate and refine

**Repository-Level Instructions**
`.github/copilot-instructions.md`
```markdown
# Project Context
React + TypeScript e-commerce application.

## Architecture
- `/src/components` - React components
- `/src/services` - API clients

## Coding Standards
- Functional components with hooks
- TypeScript strict mode
- Airbnb style guide
- JSDoc comments required
```

**Path-Specific Instructions**
`.github/instructions/*.instructions.md`
```yaml
---
applyTo: "src/components/**/*.tsx"
excludeAgent: ["code-review"]
---
Component-specific patterns here...
```

**Organization Custom Instructions** (Enterprise, November 2025)
- Default instructions for all coding agent usage
- Set in organization settings

**Reusable Prompts**: `.github/prompts/*.prompt.md` for task-specific templates

#### Lab 3 (5m)
1. **Mode Comparison**: Same task ("add input validation") in Ask, Edit, Agent modes
2. **Custom Instructions**: Create `.github/copilot-instructions.md` for sample project
3. **Context Exercise**: Use @workspace + #selection for targeted help

---

### Hour 4: Enterprise + Agentic Coding

#### MCP Integration (10m)
**Model Context Protocol**
- Open standard for AI-to-external-data connections
- GitHub deprecated Copilot Extensions (Nov 10, 2025) in favor of MCP
- Build once, use with Copilot, Claude Code, and any MCP-compatible host

**Availability**
- GA: VS Code 1.102+, JetBrains, Eclipse, Xcode
- GitHub MCP Registry: one-click server installation

**Popular MCP Servers**
| Server | Purpose |
|--------|---------|
| GitHub MCP | Repo management, issue/PR automation |
| Figma Dev Mode | Design-to-code workflows |
| Postman MCP | API platform access |
| HashiCorp Terraform | Infrastructure as code |
| Dynatrace MCP | Observability insights |

**Enterprise Controls**
- Organization-level policies: Enable/Disable/Allowlist (Oct 28, 2025)
- Registry-only mode: developers can only use allowlisted servers
- 30-minute propagation for policy changes

#### GitHub Copilot CLI (10m)
**Overview**
- Terminal-based AI assistant competing with Claude Code
- Brings Copilot coding agent power to terminal

**Installation & Usage**
```bash
npm install -g @github/copilot
copilot
/login

# Suggest commands
gh copilot suggest -t shell "Install git"

# Explain commands
gh copilot explain "traceroute github.com"

# Aliases
gh copilot alias  # Creates ghcs and ghce
```

**Key Features**
- Interactive mode: `copilot` starts session
- Programmatic mode: `-p` or `--prompt` for single command
- Model selection: `/model` to switch (Claude Sonnet 4.5 default)
- Tool permissions: `--allow-tool`, `--deny-tool` flags
- Delegation: `/delegate` to hand off to coding agent

**Use Cases**
- Explain project layout
- Setup environment (verify deps, install missing)
- Find and rank GitHub issues
- Execute shell commands: prepend with `!`

#### Copilot Coding Agent (10m)
**What Is It?**
- GitHub-hosted autonomous AI developer (GA September 25, 2025)
- Powered by Claude Sonnet 4.5
- Assign issues to @copilot, receive draft PRs

**How It Works**
1. Assign GitHub issue to Copilot (github.com, Mobile, CLI)
2. Agent boots secure VM, clones repo, configures environment
3. Analyzes codebase with advanced RAG (GitHub code search)
4. Creates branch (`copilot/*` prefix required)
5. Writes code, runs tests, validates
6. Opens draft PR with commits
7. Responds to review comments, iterates
8. Human approval required for merge

**Availability**: Pro, Pro+, Business, Enterprise plans

**Security Safeguards**
- Only users with write access can trigger
- Cannot push to protected branches (main/master)
- GitHub Actions require approval before running
- Automatic security validation: CodeQL, dependency checking, secret scanning
- Co-authored commits: `Claude <noreply@anthropic.com>`

**Best For**: Low-to-medium complexity tasks in well-tested codebases

#### Governance & Enterprise Controls (10m)
**Agent Control Plane** (October 2025)
- Enterprise-level AI governance suite
- Fine-grained permissions for AI controls
- Enterprise custom roles and teams
- MCP governance and allowlists

**Policy Management**
| Policy Type | Purpose |
|-------------|---------|
| Feature | Availability of Copilot features |
| Privacy | Sensitive action permissions |
| Models | Beyond-basic model availability |

**Content Exclusion** (GA November 2024)
- Pattern-based: exclude by name, extension, directory
- Wildcards: `*`, `**`, `*.cfg`
- Configure at enterprise, org, or repo level
- 30-minute propagation time
- NOT supported: Copilot CLI, coding agent, Agent mode

**Usage Analytics** (Public Preview October 2025)
- Dashboard under Insights tab
- Metrics: DAU, WAU, acceptance rate, LoC, model/language usage
- NDJSON download or API for user-level detail
- Data refreshes every 30 minutes (vs. daily before)

**IP Indemnity** (Business & Enterprise only)
- Microsoft defends against copyright claims
- Covers use and distribution of Copilot output
- Requires using built-in filters and safety systems
- NOT for Individual plan users

#### Lab 4 (10m)
1. **Coding Agent**: Assign simple issue to @copilot, observe PR creation
2. **Review Iteration**: Leave PR comment, see agent respond
3. **Policy Demo**: Show content exclusion configuration, audit log events

---

## Teaching Anchors & Themes

### Evolution of AI Assistants
- **2023**: Autocomplete and chat assistance
- **2024**: Multi-modal, custom agents, enterprise controls
- **2025**: Autonomous agents (Codex, Copilot coding agent) that complete full tasks

### CLI Parity
| ChatGPT Side | GitHub Copilot Side |
|--------------|---------------------|
| Codex CLI | Copilot CLI |
| chatgpt.com/codex | github.com + @copilot |
| Autonomous cloud agent | Autonomous coding agent |

### Control & Safety
- Always preview AI changes before applying
- Human review required for all agent PRs
- Enterprise policies default to disabled for security
- Content exclusion for sensitive files

### Key Differences to Highlight
| Feature | ChatGPT/Codex | GitHub Copilot |
|---------|---------------|----------------|
| Primary focus | General AI + coding | Developer workflow |
| Autonomous agent | Codex (cloud sandbox) | Coding agent (GitHub Actions VM) |
| CLI tool | Codex CLI | Copilot CLI |
| Integration | GitHub via API | Native GitHub |
| Enterprise | OpenAI Enterprise | GHEC + Copilot Enterprise |

### Instructor Notes
- GPT-5 is current flagship (August 2025 release)
- Sora 2 is latest video model (September 2025)
- Copilot coding agent uses Claude Sonnet 4.5, not OpenAI
- MCP is the future of AI extensibility (Extensions deprecated)
- Always verify AI-generated code for security vulnerabilities
- Premium requests are the new cost consideration for Copilot

---

## Quick Reference: What's New Since September 2025

### ChatGPT
- GPT-5.1 (improved conversational style)
- Voice mode integrated into chat (November 2025)
- Projects available to Free users (October 2025)
- Sora 2 with audio and cameos (September 2025)

### GitHub Copilot
- Coding agent GA (September 2025)
- Agent control plane (October 2025)
- Usage metrics dashboard (October 2025)
- MCP Registry launched
- Extensions deprecated (November 2025)
- Agent mode policy controls (November 2025)

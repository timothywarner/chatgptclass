# 🚀 Course Plan: ChatGPT + GitHub Copilot (4h)

## 🕒 Session Schedule

| Hour       | Focus                           | Key Topics / Demos                                                                | Labs / Exercises                                      |
| ---------- | ------------------------------- | --------------------------------------------------------------------------------- | ----------------------------------------------------- |
| **HOUR 1** | ChatGPT Foundations + Visual AI | DALL-E 3 (generate/edit), screenshot → HTML/CSS, Custom GPTs                      | Lab: mockup → code, CSV → “HR Assistant” GPT          |
| **HOUR 2** | Advanced ChatGPT + Agents / CLI | Sora (video), Operator agent, Connectors & MCP, ChatGPT CLI                       | Lab: video demo, autonomous task, Codex CLI prompt    |
| **HOUR 3** | Copilot Core + CLI              | Inline suggestions, Copilot Chat, Copilot Spaces/context, Copilot CLI             | Lab: scaffold API in IDE, shell tasks via CLI         |
| **HOUR 4** | Enterprise + Agentic Coding     | GHAS (scanning & Autofix), Enterprise settings, Copilot Coding Agent / Agent Mode | Lab: enable scanning/fix, assign issue → PR via agent |

---

## 📋 Detailed Run-through

### Hour 1: ChatGPT Foundations + Visual AI
- **Setup (5m)**
  Free → Plus → Pro; model tiers (GPT-4o, o1, o1-pro); introduce Canvas workspace
- **Image Projects (15m)**
  DALL-E 3: image generation, edits (shadow, variant), consistent characters
  Upload mockup screenshot → “extract HTML / CSS / design code”
- **Custom GPTs (20m)**
  GPT Store walkthrough
  Build pipeline: persona, knowledge upload, tool capability, test & publish
  Show example GPTs (Grimoire, Consensus, Canva)
- **Lab 1 (20m)**
  1. Image → UI code
  2. Upload `employee.csv`, build “HR Assistant” GPT, test queries

---

### Hour 2: Advanced ChatGPT + Agents / CLI
- **Sora (15m)**
  Text → short video generation
  Animate images, extend into clips
  Licensing & limitations
- **Operator Agent (15m)**
  Browser automation (form filling, search workflows)
  Multi-step chain-of-actions
- **Connectors & MCP (15m)**
  Integrations: Drive, GitHub, Notion, etc.
  *Read mode*: deep research + citations
  *Write mode (beta)*: create tickets, send email, update docs
  Admin & security controls
- **ChatGPT / Codex CLI (10m)**
  `codex` CLI tool (OpenAI) – natural language terminal agent that reads, edits, runs code locally. :contentReference[oaicite:0]{index=0}
  Modes: auto / read-only / full access (with approval) :contentReference[oaicite:1]{index=1}
  Use image input: `codex -i screenshot.png "Explain this error"` :contentReference[oaicite:2]{index=2}
  Model override: `--model gpt-5-codex` option :contentReference[oaicite:3]{index=3}
- **Lab 2 (10m)**
  - Generate a product video via Sora
  - Automate a form fill via Operator
  - Run `codex` with a code prompt (explain, refactor)

---

### Hour 3: Copilot Core + CLI
- **Setup & Models (5m)**
  Install VS Code + GitHub CLI
  Offer model choice: GPT-4o, Claude Sonnet, o1-preview, Gemini
- **Core Features (10m)**
  Inline code completion (Tab, Alt+\\)
  Copilot Chat side panel
  Context bundling: Spaces / project awareness
- **Copilot CLI (15m)**
  Install: `gh extension install github/gh-copilot`
  Commands: `gh copilot suggest "…"`, `gh copilot explain "…"`
  Aliases: `??`, `!?`
  Agentic flows: multi-step tasks with preview & approval
- **Lab 3 (15m)**
  IDE: scaffold CRUD API → add error handling → unit tests
  CLI:
  - `?? "compress images"`
  - `!? "awk '{print $2}'"`
  - Build deployment script

---

### Hour 4: Enterprise + Agentic Coding
- **GHAS & Security (10m)**
  Code scan, secret detection, dependency review
  **Autofix**: AI-suggested fixes + explanations + one-click remediation
- **Enterprise Controls (5m)**
  SSO / SCIM, IP allow lists, audit logs
  Copilot Enterprise: usage analytics, knowledge bases
- **Copilot Coding Agent / Agent Mode (15m)**
  Explain agent feature: assign issue to `@copilot`, agent works, opens PR :contentReference[oaicite:4]{index=4}
  VS Code Agent Mode (in-editor autonomous edits, refactor, multi-file) :contentReference[oaicite:5]{index=5}
  Show agent logs, iteration via feedback, security mitigations :contentReference[oaicite:6]{index=6}
- **Lab 4 (10m)**
  1. Enable scanning → use Autofix
  2. Show Copilot usage dashboard
  3. Assign an issue → let agent open PR → review in VS Code

---

## 🎯 Teaching Anchors & Themes
- AI evolves from **assistant → agent → autonomous collaborator**
- **CLI parity**: Codex CLI for ChatGPT side, Copilot CLI for development side
- **Control & safety**: always preview/write-only rules, admin policies
- Encourage iteration: require human review of all AI output
- Focus demos on 80% use cases: bug fixes, scaffolding, tests, refactors


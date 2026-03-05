# Lab 3: Copilot in the Editor -- Mode Comparison and Custom Instructions

## Objective
Explore the four Copilot Chat modes (Ask, Edit, Agent, Plan), configure custom instructions for a project, and practice using context variables for targeted assistance.

## Prerequisites
- VS Code with GitHub Copilot and Copilot Chat extensions installed
- A sample project open in VS Code (any Express/Node.js project works; you can scaffold one with `npx express-generator`)

## Part 1 -- Mode Comparison (2 min)

Open any Express route file (e.g., one containing `app.post` or `router.post`) and use the **same prompt** in each mode to observe the differences.

**Prompt to use:** `add input validation to this Express endpoint`

1. **Ask mode** (`Ctrl+Shift+I` or click the chat icon)
   - Type the prompt in the Chat panel.
   - Observe: Copilot returns an explanation and code suggestion you can copy manually.

2. **Edit mode** (highlight the endpoint code, then `Ctrl+I`)
   - Type the same prompt in the inline chat.
   - Observe: Copilot proposes a diff directly in the editor. Accept or discard.

3. **Agent mode** (open Chat panel, switch to **Agent** from the mode dropdown)
   - Type the same prompt.
   - Observe: Copilot plans multi-file changes (e.g., installing a validation library, updating `package.json`, modifying the route file). Review the proposed steps before accepting.

4. **Plan mode** (in Agent mode, click the **Plan** icon or type `/plan` before your prompt)
   - Type: `/plan add input validation to this Express endpoint`
   - Observe: Copilot generates a step-by-step implementation plan without making changes. You can approve the plan to proceed or refine it.

**Key takeaway:** Ask explains, Edit patches in-place, Agent orchestrates multi-file changes, Plan outlines before acting.

## Part 2 -- Custom Instructions (2 min)

Create a `.github/copilot-instructions.md` file in the root of your sample project. This file provides Copilot with project-specific context and coding standards.

1. In VS Code, create the file `.github/copilot-instructions.md`.
2. Paste the template below and customize it for your project.
3. Ask Copilot a question in Chat (e.g., "add a health check endpoint") and confirm it follows your instructions.

### Template: `.github/copilot-instructions.md`

```markdown
# Copilot Custom Instructions

## Project Overview
This is a Node.js/Express REST API using TypeScript.

## Tech Stack
- Runtime: Node.js 20+
- Framework: Express 4.x
- Language: TypeScript (strict mode)
- Validation: zod
- Database: PostgreSQL with Prisma ORM
- Testing: Vitest

## Coding Standards
- Use `const` and arrow functions; avoid `var` and `function` declarations.
- Validate all request inputs with zod schemas before processing.
- Return consistent JSON responses: `{ success: boolean, data?: T, error?: string }`.
- Handle errors with try/catch and return appropriate HTTP status codes.
- No console.log in production code; use a structured logger (pino).
- Write pure functions; avoid mutation.

## File Organization
- Routes: `src/routes/`
- Controllers: `src/controllers/`
- Schemas (zod): `src/schemas/`
- Database models: `prisma/schema.prisma`

## Testing
- Co-locate test files: `src/**/*.test.ts`
- Minimum 80% coverage on new code.
```

**Bonus -- Reusable Agents:** You can also create specialized agent files at `.github/agents/*.agent.md` (e.g., `.github/agents/security-reviewer.agent.md`) that Copilot Chat can invoke by name for domain-specific tasks.

## Part 3 -- Context Exercise (1 min)

Use chat participants and context variables to give Copilot targeted scope.

1. **Workspace context:** In the Chat panel, type `@workspace how is error handling done in this project?` and observe how Copilot searches across your project files.
2. **Selection context:** Highlight a specific code block in the editor, then type in Chat: `@workspace #selection explain this code and suggest improvements`. Copilot scopes its answer to exactly what you selected.
3. **File context:** Drag a file from the Explorer into the Chat panel (or use `#file:path/to/file.ts`) to attach it as context for your next question.

**Key takeaway:** Precise context (`#selection`, `#file`, `@workspace`) produces more relevant answers than broad, unscoped prompts.

## Wrap-Up

| Mode | Best For | Scope |
|------|----------|-------|
| Ask | Explanations, Q&A, learning | Read-only |
| Edit | Quick inline patches | Single file |
| Agent | Multi-step, multi-file changes | Full workspace |
| Plan | Review before committing to changes | Full workspace |

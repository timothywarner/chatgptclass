# Lab 4: Copilot Coding Agent -- Beyond the Editor

## Objective
Use the GitHub Copilot coding agent (GA) to resolve an issue end-to-end from within a GitHub repository, review and iterate on the resulting pull request, and observe enterprise policy controls.

## Prerequisites
- GitHub account on a **Pro, Pro+, Business, or Enterprise** plan with Copilot enabled
- **Write access** to a test repository (public or private) -- do NOT use a production repo
- Repository must contain a running web application (any framework) or use the instructor-provided sample repo

## Part 1 -- Coding Agent (5 min)

1. **Create an issue**
   - In your test repo, go to **Issues > New issue**.
   - Title: `Add a /health endpoint`
   - Body:
     ```
     Add a GET /health endpoint that returns JSON:
     {"status": "ok"}
     Return HTTP 200 with Content-Type application/json.
     ```
2. **Assign to Copilot**
   - In the issue sidebar, set **Assignees** to `@copilot` (type "copilot" in the assignee search).
   - The coding agent spins up a cloud environment, plans the change, and opens a pull request on a `copilot/*` branch.
3. **Watch the PR appear**
   - Navigate to **Pull Requests**. Within 1-3 minutes a new PR will appear.
   - Review the PR description -- the agent explains its plan, files changed, and test coverage.
   - Note: the agent runs **self-review** (it critiques its own diff) and **security scanning** before marking the PR ready. The underlying model is Claude Sonnet 4.6.

## Part 2 -- Review Iteration (3 min)

4. **Request a change via PR review**
   - Open the PR and start a review. Leave a comment on the changed file:
     ```
     Also add a GET /version endpoint that returns:
     {"version": "1.0.0"}
     ```
   - Submit the review with **Request changes**.
5. **Watch the agent respond**
   - Copilot picks up the review comment, updates the `copilot/*` branch, and pushes a new commit.
   - Verify both `/health` and `/version` endpoints are present in the updated diff.
6. **Approve and merge**
   - Once satisfied, approve the PR and merge. The issue auto-closes via the linked PR.

## Part 3 -- Policy Demo (2 min, instructor-led)

7. **Content exclusion**
   - Instructor navigates to **Organization Settings > Copilot > Content exclusion** and demonstrates adding a path pattern (e.g., `**/secrets/**`) that prevents Copilot from reading or suggesting code in matching files.
8. **Audit log**
   - Instructor opens **Organization Settings > Audit log**, filters to `copilot` events, and shows agent invocation entries including the model used, tokens consumed, and repository context.

## Key Takeaways
- The coding agent converts issues into working PRs without leaving GitHub.
- Review comments drive iterative changes -- treat the agent like a junior developer.
- Enterprise admins control what the agent can access and can audit every action.

# Repository Guidelines

## Project Structure & Module Organization
This course repo bundles teaching assets and demos. `src/` hosts Python-based OpenAI, automation, and security examples (several intentionally vulnerable, such as `app.py`, for classroom discussion). `chat_app/` contains the minimal Flask chat wrapper. Hands-on labs live in `exercises/`, grouped by persona, while reusable data inputs sit under `Datasets/`. `mcp-demos/weather-server` is the Node-based MCP reference server. Check `knowledge/` for combined slide decks and `README.md` for learner-facing orientation.

## Build, Test, and Development Commands
Use a virtual environment for Python work: `python -m venv .venv && source .venv/bin/activate` (PowerShell: `.\.venv\Scripts\Activate.ps1`), then `pip install -r src/requirements.txt`. Run targeted demos with `python src/app.py`, `python src/run.py`, or `python chat_app/run.py`. For MCP demos, run `npm install` then `npm start` inside `mcp-demos/weather-server`. Scripts expect API keys via environment variables; never hard-code secrets.

## Coding Style & Naming Conventions
Python modules use 4-space indentation, `snake_case` filenames, and descriptive function names (verbs for actions, nouns for data loaders). Keep demo scripts concise with top-level docstrings outlining purpose and prerequisites. When fixing vulnerable examples, comment the teaching objective so future updates preserve the lesson. Prefer environment-variable lookups (`os.getenv`) and helper functions over inline literals.

## Testing Guidelines
Add or expand `pytest` suites under `tests/`, mirroring the package path (`tests/test_app.py` for `src/app.py`). Use `pytest -q` locally before opening a PR and include fixtures for any sample datasets you add. For Node additions, provide minimal smoke tests or a `npm test` script. Document manual validation steps in the PR if automated coverage is impractical.

## Commit & Pull Request Guidelines
Follow the existing history by writing imperative, sentence-case commit subjects (`Add MCP weather demo`). Group unrelated changes into separate commits and keep body text focused on why the change matters. PRs should link the relevant module or lesson, summarize testing, attach screenshots for learner-facing assets, and note any new secrets or configuration toggles so the automation in `.github/workflows/` stays green.

## Security & Configuration Expectations
Secret scanning runs locally and in CI (see `SECURITY.md` and `.github/workflows/secret-scanning.yml`). Rotate or redact any discovered credentials immediately, regenerate `.secrets.baseline` when the false-positive set changes, and share reproduction notes for labs that intentionally demonstrate unsafe patterns so reviewers can validate without exposing live secrets.

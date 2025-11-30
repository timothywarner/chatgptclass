# Lab 1: Generate UI Code from an Image Prompt

## Objective
Use ChatGPT with DALL·E 3 and Canvas to transform a UI mockup into production-ready HTML/CSS.

## Prerequisites
- ChatGPT Plus or Pro subscription with DALL·E 3 access
- Sample mockup image (use `knowledge/choose-an-agile-approach/Mockup.png` or bring your own)
- Optional: VS Code with the ChatGPT Canvas workspace enabled

## Steps
1. **Seed the prompt**
   - Upload the mockup to ChatGPT and ask: “Generate a responsive HTML/CSS layout for this mockup. Provide CSS variables for theme colors.”
2. **Canvas iteration**
   - Open Canvas mode → `New Workspace` → paste the generated HTML/CSS.
   - Request follow-ups such as “Add tailwind-like utility classes” or “Refactor to CSS grid”.
3. **Component extraction**
   - Ask ChatGPT to split the layout into reusable components (e.g., header, hero, feature cards).
   - Export each component as a separate code block ready for integration into `chat_app/app/templates/`.
4. **Accessibility pass**
   - Prompt: “Review this HTML/CSS for accessibility. Add aria-labels and ensure color contrast meets WCAG AA.”
5. **Local validation**
   - Paste the HTML into `chat_app/app/templates/mockup.html` (create file) and preview using `python chat_app/run.py`.
   - Document adjustments in Canvas and save final code snippets in your notes.

## Demo Tips
- Show how `Canvas → Compare` highlights diffs between iterations.
- Emphasize quick wins: hero sections, CTA buttons, pricing cards.
- Encourage exporting reusable snippets to `knowledge/components/` for future cohorts.

# Lab 1: ChatGPT Power User -- Projects, GPTs, and Tasks

**Time:** 10 minutes

## Objective

Create a ChatGPT Project with HR data, build a custom "HR Assistant" GPT, and test it with real queries. Optionally, schedule a recurring Task for automated summaries.

## Prerequisites

- ChatGPT Plus or Pro subscription (GPT-5.2 access)
- File: `datasets/Human Resources/HRIS.csv` (employee records with department, salary, location, hire date, etc.)

---

## Part 1: Create a Project (3 min)

1. In ChatGPT, click **Projects** in the left sidebar, then **New Project**.
2. Name it `HR Analytics`.
3. Under **Files**, upload `datasets/Human Resources/HRIS.csv`.
4. Under **Custom Instructions**, paste:
   ```
   You are an HR analytics assistant. The uploaded HRIS.csv contains employee
   records including employee_id, name, gender, position, department, location,
   hire_date, termination_date, salary, and email. Always reference this data
   when answering HR questions. Use tables and charts when helpful.
   ```
5. Click **Create**. You now have a persistent project context that carries across conversations.

## Part 2: Build a Custom GPT (4 min)

1. Navigate to **Explore GPTs** > **Create**.
2. Configure:
   - **Name:** `HR Assistant`
   - **Description:** `Answers HR questions using employee data. Generates charts and reports.`
   - **Instructions:** `You help HR professionals analyze workforce data. When asked about employees, use the uploaded HRIS.csv. Produce charts with Code Interpreter when requested. Keep answers concise and data-driven.`
3. Under **Knowledge**, upload `datasets/Human Resources/HRIS.csv`.
4. Under **Capabilities**, enable **Code Interpreter** (required for charts).
5. Click **Create** and choose **Only me** for sharing.

## Part 3: Test the GPT (2 min)

1. Open your new **HR Assistant** GPT.
2. Enter the prompt:
   ```
   Show a bar chart of headcount by department.
   ```
3. Verify the GPT reads the CSV, runs Code Interpreter, and produces a chart.
4. Try a follow-up:
   ```
   What is the average salary by department? Display as a table.
   ```
5. Open a **new base ChatGPT conversation** (no GPT, no project) and ask the same headcount question. Note the difference -- the base model has no access to your data.

## Part 4: Bonus -- Schedule a Task (1 min)

1. In ChatGPT, open **Tasks** (left sidebar or via the `/tasks` command).
2. Create a new task:
   - **Prompt:** `Summarize key HR metrics from the HRIS data: total headcount, open positions (terminated employees not yet replaced), and department distribution. Keep it under 200 words.`
   - **Schedule:** Daily at 8:00 AM
   - **Project:** Link to your `HR Analytics` project
3. Save the task. ChatGPT will deliver a daily HR summary to your inbox.

---

## Key Takeaways

- **Projects** give ChatGPT persistent file context and custom instructions across conversations.
- **Custom GPTs** package instructions, knowledge files, and capabilities into a reusable tool.
- **Code Interpreter** enables data analysis and chart generation from uploaded files.
- **Tasks** automate recurring prompts on a schedule -- no manual intervention needed.

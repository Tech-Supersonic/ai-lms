# Phase 2 — Job Market Scanner
### AI-Driven Learning Management System

---

## Before you start

Phase 1 must be fully complete before starting this phase. Your database should be running, NocoDB should be connected, and you should have at least 10 skills in your `learning_skills` table.

If that is not the case, go back and finish Phase 1 first.

---

## What you are building in this phase

An automated workflow that runs daily, searches job postings for your target roles, extracts the most frequently mentioned skills, and saves them to your database. Your AI agent will surface these during your daily review so you can decide what to add to your learning list.

By the end of this phase you will have:

- A `market_signals` table in your database
- A working n8n workflow that populates it daily
- The `daily-review.md` skill file connected and working for job signals
- Everything committed to your repository

---

## Step 1 — Create a new branch

```bash
git checkout main
git pull origin main
git checkout -b phase-2-job-scanner
```

---

## Step 2 — Add the market_signals table

Open pgAdmin and run this in the Query Tool:

```sql
CREATE TABLE market_signals (
  id           SERIAL PRIMARY KEY,
  skill_name   TEXT NOT NULL,
  frequency    INTEGER DEFAULT 1,
  source       TEXT,
  role_matched TEXT,
  captured_on  DATE DEFAULT CURRENT_DATE,
  reviewed     BOOLEAN DEFAULT FALSE,
  estimated_salary Number
  salary_currency TEXT
);
```

Verify it was created:
```sql
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public';
```

You should now see `market_signals` in the list.

---

## Step 3 — Set up n8n

If you do not have n8n running yet, deploy it on Dokploy:

```
Dokploy → Templates → n8n → Deploy
```

Once running, open n8n in your browser and create an account.

---

## Step 4 — Build the job scanner workflow

In n8n, create a new workflow. The flow has five nodes:

**Node 1 — Schedule trigger**
Runs the workflow once per day at a time you choose.
```
Type: Schedule Trigger
Rule: Every day at 08:00
```

**Node 2 — HTTP Request (job board)**
Fetches job postings for your target roles. Use a job board that offers an API or RSS feed. A few options:

- **Adzuna API** — free tier available, good coverage, returns structured JSON
- **Indeed RSS** — no API key needed, returns recent postings as RSS
- **Remotive API** — good for remote tech roles, free

For Adzuna (recommended):
```
Type: HTTP Request
Method: GET
URL: https://api.adzuna.com/v1/api/jobs/gb/search/1
Parameters:
  app_id: your_app_id
  app_key: your_app_key
  what: AI engineer OR automation developer OR backend developer
  results_per_page: 50
```

Register for a free Adzuna API key at developer.adzuna.com.

**Node 3 — Code node (extract skills)**
Parses the job descriptions and extracts skill keywords. Paste this into the Code node:

```javascript
const postings = $input.all();
const skillKeywords = [
  'python', 'javascript', 'typescript', 'node.js', 'fastapi',
  'postgresql', 'docker', 'kubernetes', 'terraform', 'aws', 'gcp',
  'langchain', 'langgraph', 'n8n', 'mcp', 'rag', 'vector database',
  'pinecone', 'redis', 'graphql', 'rest api', 'ci/cd', 'github actions',
  'ollama', 'openai', 'anthropic', 'llm', 'machine learning', 'mlops'
];

const counts = {};

for (const item of postings) {
  const description = (item.json.description || '').toLowerCase();
  for (const skill of skillKeywords) {
    if (description.includes(skill)) {
      counts[skill] = (counts[skill] || 0) + 1;
    }
  }
}

return Object.entries(counts)
  .filter(([_, count]) => count > 1)
  .map(([skill, frequency]) => ({
    json: {
      skill_name: skill,
      frequency,
      source: 'adzuna',
      role_matched: 'ai/backend developer',
      captured_on: new Date().toISOString().split('T')[0],
      reviewed: false
    }
  }));
```

Edit the `skillKeywords` array to match the technologies relevant to your target roles.

**Node 4 — HTTP Request (insert to NocoDB)**
Inserts each skill into your `market_signals` table via the NocoDB API.

```
Type: HTTP Request
Method: POST
URL: https://your-nocodb-url/api/v1/db/data/noco/YOUR_PROJECT_ID/market_signals
Headers:
  xc-auth: your_nocodb_api_token
  Content-Type: application/json
Body: {{ $json }}
```

Find your project ID in NocoDB under Team & Settings → API Docs.

**Node 5 — Code node (log completion)**
Simple log to confirm the run finished.

```javascript
const inserted = $input.all().length;
return [{ json: { message: `Job scan complete. ${inserted} skills saved.` } }];
```

---

## Step 5 — Test the workflow

Run the workflow manually once before activating the schedule:

```
n8n → your workflow → Execute Workflow
```

Check NocoDB — you should see rows appearing in the `market_signals` table.

If nothing appears, check:
- Your API keys are correct
- The NocoDB URL and project ID are correct
- The API token has write access

Once the manual run works, activate the workflow so it runs on schedule.

---

## Step 6 — Add a view for the daily review

In pgAdmin, run:

```sql
CREATE VIEW pending_signals AS
SELECT skill_name, frequency, source, role_matched, captured_on
FROM market_signals
WHERE reviewed = FALSE
ORDER BY frequency DESC, captured_on DESC;
```

This view will show the agent only unreviewed signals during your daily review session.

---

## Step 7 — Test the daily review skill

Open a chat with your AI agent and say:

**"review my feed"**

The agent will load `daily-review.md`, query the `pending_signals` view, and walk you through each unreviewed skill. For each one you can say:

- **"add"** — agent adds it to `learning_skills` and marks it reviewed
- **"skip"** — agent marks it reviewed without adding it
- **"later"** — agent leaves it unreviewed for next time

---

## Step 8 — Export the workflow and commit

In n8n, export your workflow as JSON:
```
Workflow menu → Download
```

Save the file as `automations/job_scanner.json` in your repository.

```bash
git add .
git commit -m "phase 2: market_signals table, n8n job scanner workflow, pending_signals view"
git push origin phase-2-job-scanner
```

Open a Pull Request from `phase-2-job-scanner` into `main`. In the PR description, include a screenshot of NocoDB showing populated `market_signals` rows and a note about which job board you used.

---

## Phase 2 checklist

- [-] `market_signals` table created and verified
- [-] n8n deployed and running
- [-] Job scanner workflow built with all five nodes
- [-] Workflow tested manually — data appears in NocoDB
- [-] Schedule activated
- [-] `pending_signals` view created
- [-] Daily review tested via agent chat
- [-] Workflow exported and saved to `automations/job_scanner.json`
- [-] Changes committed and PR opened with screenshot

---

## What is next

Once your Phase 2 PR is reviewed and approved, move to `03-phase-3-news-feed.md`.

---

*Phase 2 of 5 — AI-Driven LMS Developer Assignment*

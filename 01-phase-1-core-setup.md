# Phase 1 — Core Setup
### AI-Driven Learning Management System

---

## What you are building in this phase

By the end of Phase 1 you will have a fully working learning system:

- A PostgreSQL database with your skill tables and views
- NocoDB running as a visual interface on top of your database
- An AI agent connected to your database via MCP
- Your initial skills loaded through a braindump session
- Everything committed to your GitHub repository

This is the foundation. Phases 2 and 3 build on top of it.

---

## Step 1 — Fork the repository

Go to the assignment repository on GitHub and fork it to your own account. Clone your fork to your local machine.

```bash
git clone https://github.com/YOUR_USERNAME/ai-lms.git
cd ai-lms
```

Create a branch for Phase 1:

```bash
git checkout -b phase-1-setup
```

All your work for this phase goes on this branch.

---

## Step 2 — Create your database on Dokploy

Log in to the TSS server Dokploy panel. If you do not have credentials yet, ask before continuing.

```
Dokploy → Services → New Service → Database → PostgreSQL
  Name: learning_db
  User: choose a username
  Password: choose a strong password
  Port: 5432
```

Once it is running, note down your connection details. You will need them in the next step.

---

## Step 3 — Set up pgAdmin on your local machine

Download and install pgAdmin from **pgadmin.org**.

Once installed, open pgAdmin and register a new server:

```
Right click Servers → Register → Server
  General tab:
    Name: learning_db

  Connection tab:
    Host: your TSS server IP
    Port: 5432
    Database: learning_db
    Username: the username you set in Step 2
    Password: the password you set in Step 2
```

Click Save. You should see your database appear in the left panel.

---

## Step 4 — Run the schema

In pgAdmin, expand your server, right click on `learning_db`, and open the Query Tool.

Open the file `schema/schema.sql` from your cloned repository and paste the full contents into the Query Tool. Run it.

This creates:
- `learning_skills` table — your skill tracking list
- `tools` table — your tool radar
- Four views — `current_sprint`, `next_up`, `progress_totals`, `project_progress`

After running, verify the tables exist:
```sql
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public';
```

You should see `learning_skills` and `tools` in the results.

---

## Step 5 — Deploy NocoDB

In Dokploy, go to **Templates** and find NocoDB. Deploy it with one click.

Once it is running, open NocoDB in your browser. On first load it will ask you to create an account — use a strong password, you will need this later.

Connect NocoDB to your database:
```
NocoDB → Team & Settings → Data Sources → Add New
  Client: PostgreSQL
  Host: your TSS server IP
  Port: 5432
  Database: learning_db
  Username: your db username
  Password: your db password
```

Your tables will appear as spreadsheet tabs. You should see `learning_skills` and `tools`.

---

## Step 6 — Connect MCP to your AI tool

MCP is how the AI agent talks to your database. This step connects them.

**Get your NocoDB API token:**
```
NocoDB → Team & Settings → API Tokens → Add New Token
  Name: agent-token
```

Copy the token — you will only see it once.

**Connect in Claude.ai:**
```
Claude.ai → Settings → Connections → NocoDB → Connect
  NocoDB URL: your NocoDB server URL
  API Token: the token you just copied
```

Once connected, the agent can read and write to your database directly from chat.

> **Using a different AI tool?** NocoDB auto-generates a REST API for every table. Go to NocoDB → API Docs to see your endpoints. You can call these from any AI tool that supports HTTP requests or custom actions.

**Optional — postgres-mcp for direct SQL access:**

This gives the agent the ability to run raw SQL queries, which is useful for complex lookups. It requires hosting a small MCP server on Dokploy via Docker Compose. The compose file is in `schema/postgres-mcp-compose.yml` in the repository. If you get stuck on this step, skip it for now — nocodb-mcp is enough to complete Phase 1.

---

## Step 7 — Add the skill files to your Claude project

In Claude.ai, open your project settings and upload the three files from the `skills/` folder in your repository:

- `skills/ingestion.md`
- `skills/learning.md`
- `skills/daily-review.md`

Once uploaded, the agent will read them automatically at the start of every session.

> **Using a different AI tool?** Paste the contents of each skill file into your system prompt or custom instructions. The files are plain markdown and will work with any capable AI.

---

## Step 8 — Seed your skills

Open a new chat with your AI agent and say:

**"open session"**

The agent will greet you with your current status and guide you from there.

**Start with a braindump.** Before adding anything structured, take 10 minutes and write down everything on your mind as a developer:

- Tools you have heard of but never properly used
- Topics you are halfway through learning
- Things that keep coming up in job postings you have looked at
- Technologies you feel you should know but do not yet
- Anything a senior dev mentioned that you did not fully understand

Paste all of it into the chat in one go. Do not organise it. The agent will go through each item, propose the right fields, and ask you to confirm before adding anything.

After the braindump say:

**"add my master profile"**

Then paste your CV, LinkedIn summary, or any profile text you have. The agent will parse it and add anything not already in your list.

This session will take 20 to 30 minutes. Do not rush it. A good braindump on day one means the system has real data to work with from the start.

---

## Step 9 — Verify everything is working

After seeding, open NocoDB and check:

- Your skills appear in the `learning_skills` table
- The `current_sprint` view is available as a tab
- The `next_up` view shows your first priority skill

In pgAdmin, run:
```sql
SELECT COUNT(*) FROM learning_skills;
SELECT * FROM progress_totals;
```

Both should return real data.

---

## Step 10 — Commit your work

You have not written any application code yet, but you have done real work — your schema is running, your system is live, and your skills are seeded. Commit what you have.

```bash
git add .
git commit -m "phase 1: database setup, NocoDB, MCP connected, initial skills seeded"
git push origin phase-1-setup
```

Open a Pull Request from `phase-1-setup` into `main` on GitHub. In the PR description, write three to five sentences about what you set up and any issues you ran into. This is not a formality — it is practice for writing professional PR descriptions.

---

## Phase 1 checklist

Before opening your PR, confirm each of these:

- [-] Repository forked and cloned
- [-] PostgreSQL database running on Dokploy
- [-] pgAdmin connected to the database
- [-] Schema SQL executed — tables and views exist
- [-] NocoDB deployed and connected to the database
- [-] MCP connected to your AI tool
- [-] Skill files added to your Claude project
- [-] Braindump session completed — at least 10 skills in the database
- [-] Master profile ingested
- [-] NocoDB shows skills correctly
- [-] Views returning data in pgAdmin
- [] Changes committed and PR opened

---

## What is next

Once your Phase 1 PR is reviewed and approved, move to `02-phase-2-job-scanner.md`.

---

*Phase 1 of 5 — AI-Driven LMS Developer Assignment*

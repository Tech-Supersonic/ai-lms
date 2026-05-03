# Phase 4 — GitHub and CI/CD Pipeline
### AI-Driven Learning Management System

---

## Before you start

Phases 1, 2, and 3 must be complete. Your system should be fully running — database, NocoDB, both automations, and your daily review working.

---

## What you are building in this phase

A professional GitHub repository with a clean README and a CI/CD pipeline that automatically checks your schema file every time you push changes.

This phase is about engineering discipline. A working system that lives only on one server is fragile. A working system with version control, documentation, and automated checks is professional.

By the end of this phase you will have:

- A clean, well-structured GitHub repository
- A proper README that anyone could follow to set up your system
- A GitHub Actions workflow that validates your schema SQL on every push
- A repository that you can show to a hiring manager

---

## Step 1 — Create a new branch

```bash
git checkout main
git pull origin main
git checkout -b phase-4-cicd
```

---

## Step 2 — Clean up your repository structure

Your repository should look like this by now. If anything is missing or named differently, fix it in this step.

```
ai-lms/
  00-overview.md
  01-phase-1-core-setup.md
  02-phase-2-job-scanner.md
  03-phase-3-news-feed.md
  04-github-and-cicd.md
  05-document-and-present.md
  schema/
    schema.sql
  skills/
    ingestion.md
    learning.md
    daily-review.md
  automations/
    job_scanner.json
    news_feed.json
  .github/
    workflows/
      validate.yml
  README.md
```

Create any missing folders now:
```bash
mkdir -p .github/workflows
```

---

## Step 3 — Write the README

The README is the first thing anyone sees when they visit your repository. Write it as if a developer you have never met needs to set up your system from scratch.

Your `README.md` should cover:

**What it is** — two or three sentences. What does this system do and why would someone want it.

**What you will have at the end** — a short bullet list. Copy from the overview if needed.

**Prerequisites** — tools they need installed before starting.

**Setup** — numbered steps pointing to the phase documents. Do not repeat all the detail here — just tell them which file to read and in what order.

**How to use it** — the key commands the agent understands. A short table works well.

**Tech stack** — a simple list of what the system uses: PostgreSQL, NocoDB, n8n, Claude/AI tool of choice, GitHub Actions.

Keep it short. A README that takes five minutes to read is too long. Aim for something a developer can scan in under two minutes and know exactly what to do.

---

## Step 4 — Set up the CI/CD pipeline

This pipeline runs a SQL syntax check every time you push changes to the repository. It catches errors in your schema file before they reach your database.

Create the file `.github/workflows/validate.yml` with this content:

```yaml
name: Validate Schema

on:
  push:
    paths:
      - 'schema/**.sql'
  pull_request:
    paths:
      - 'schema/**.sql'

jobs:
  validate-sql:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Install sqlfluff
        run: pip install sqlfluff

      - name: Lint schema SQL
        run: sqlfluff lint schema/schema.sql --dialect postgres
```

**What this does:**
- Triggers only when a `.sql` file in the `schema/` folder changes
- Installs `sqlfluff`, a SQL linter
- Runs the linter against your schema file
- Fails the check if there are syntax errors or style issues

This means every PR that touches your schema gets automatically checked. You will see a green checkmark or a red cross on every PR.

---

## Step 5 — Test the pipeline

Push your branch to GitHub:

```bash
git add .
git commit -m "phase 4: README, cleaned repo structure, validate.yml CI pipeline"
git push origin phase-4-cicd
```

Open a Pull Request on GitHub. Within a minute or two you should see the Actions workflow running on your PR. Click on it to see the output.

If the linter finds issues in your SQL, fix them and push again. The check will re-run automatically.

Common sqlfluff fixes:
- Keywords should be uppercase: `CREATE TABLE` not `create table`
- Each statement should end with a semicolon
- Consistent indentation inside CREATE TABLE blocks

---

## Step 6 — Verify the pipeline is green

Before merging, confirm:
- The `Validate Schema` check shows a green tick on your PR
- The Actions tab on GitHub shows a successful run
- You can click into the run and see the sqlfluff output

Once it is green, merge your PR into `main`.

---

## Phase 4 checklist

- [ ] Repository structure matches the layout above
- [ ] README written — clear, scannable, covers prerequisites and setup
- [ ] `.github/workflows/validate.yml` created
- [ ] Pipeline triggered on push — visible in GitHub Actions tab
- [ ] Schema lint passing — green tick on the PR
- [ ] PR merged into main

---

## What is next

Once your Phase 4 PR is merged, move to `05-document-and-present.md`.

---

*Phase 4 of 5 — AI-Driven LMS Developer Assignment*

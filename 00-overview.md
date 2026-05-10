# AI-Driven Learning Management System
### Developer Assignment — Master Overview

---

## What this is

This is your personal learning system. You will build it, use it, and present it.

It is not a throwaway exercise. By the time you finish, this system will be actively tracking your skills, surfacing relevant job market data, and helping you learn faster. You will use it throughout your entire journey as a developer — from today until you land a job.

You are also going to build it the way a professional developer builds things: with version control, a CI/CD pipeline, proper documentation, and a presentation at the end.

---

## What you will have when you are done

- A live database tracking every skill in your learning plan
- An AI agent that ingests topics and teaches you using a structured process
- A visual dashboard to browse and manage your progress
- A daily feed of in-demand skills pulled from real job postings
- A daily feed of relevant tech and AI news filtered for your profile
- A GitHub repository with a proper README and CI/CD pipeline
- A written case study: problem → plan → execution
- A recorded video walkthrough of your system
- A live presentation of your work

---

## The five phases

| Phase | What you build | Key skills practiced |
|---|---|---|
| **Phase 1** | Core system — database, NocoDB, AI agent | SQL, Docker, MCP, AI tools |
| **Phase 2** | Job market scanner automation | n8n, APIs, automation |
| **Phase 3** | News relevance feed | n8n, RSS, filtering |
| **Phase 4** | GitHub repo and CI/CD pipeline | Git, GitHub Actions, engineering discipline |
| **Phase 5** | Documentation and presentation | Writing, communication, soft skills |

Do not jump ahead. Complete each phase fully before moving to the next.

---

## How the system works

There are four pieces that work together:

**The AI agent** is Claude or any capable AI tool. You talk to it in chat. It reads instruction files and knows how to add skills to your database, teach you, and review your progress.

**The skill files** are three plain text files that act as instructions for the agent. One handles adding skills. One handles teaching. One handles reviewing your daily feeds.

**NocoDB** is a spreadsheet-style interface on top of your database. You use this to browse your skills and check your progress without writing SQL.

**PostgreSQL** is the database where everything is stored. You will also use pgAdmin locally to run queries and fix things when needed.

---

## How you interact with the system

```
You (chat)
  → AI agent reads skill files
    → agent writes to database via MCP
      → NocoDB shows your data as a spreadsheet

You (direct)
  → NocoDB for browsing and manual edits
  → pgAdmin for direct database access
```

---

## The three skill files

These live in a `skills/` folder inside your Claude project. The agent reads them automatically.

| File | Purpose |
|---|---|
| `ingestion.md` | Adding skills — from your profile, a URL, or a braindump |
| `learning.md` | Teaching — The Learning Sprint and completion tracking |
| `daily-review.md` | Daily review — job market signals and news feed |

---

## The database tables

| Table | What it stores |
|---|---|
| `learning_skills` | Every skill in your learning plan |
| `tools` | Every tool you encounter |
| `market_signals` | In-demand skills from job postings |
| `news_feed` | Relevant articles filtered for your profile |

---

## Prerequisites

Before you start Phase 1, make sure you have the following.

**Knowledge — you should understand these basics:**
- What a database is and basic SQL (SELECT, INSERT, CREATE TABLE)
- What Docker is and how containers work
- What an API is and what a REST call looks like
- Basic Git — clone, commit, push, pull request

If any of these are unfamiliar, spend a day on each before starting. Do not skip this — you will hit walls in Phase 1 if you do.

**Tools — you need these installed or available:**

| Tool | Where to get it | Required for |
|---|---|---|
| Git | git-scm.com | All phases |
| GitHub account | github.com | All phases |
| Docker Desktop | docker.com | Phase 1 |
| pgAdmin | pgadmin.org | Phase 1 |
| Dokploy access | TSS server — ask for credentials | Phase 1 |
| Claude.ai account | claude.ai | Phase 1 |
| n8n account | n8n.io | Phase 2 and 3 |

---

## Before you start — checklist

Before touching any phase document, confirm both lists below are complete.

**What you need to have received from your instructor:**

- [ ] A domain assigned to you (e.g. `yourname.tss-domain.com`)
- [ ] Database port opened on the TSS server for your instance
- [ ] Dokploy project created and access granted to you
- [ ] Dokploy login credentials (server URL, username, password)
- [ ] Invite to the GitHub organisation or assignment repository
- [ ] Claude.ai account access or credentials

If any of these are missing, do not start. Ask your instructor to complete the setup first.

**What you need to send back to your instructor before starting:**

- [ ] Your GitHub username — so you can be added to the repo
- [ ] Confirmation that you have forked the repository
- [ ] Your forked repo link — so your instructor can be added as admin to review your PRs

Once both lists are ticked, go to `01-phase-1-core-setup.md`.

---

## How this assignment works

Each phase has its own document. Read only the document for the phase you are currently on. Each document tells you exactly what to do, what to submit, and what the next step is.

Your work lives in a GitHub repository. Each phase has a corresponding Issue with a checklist. When you finish a phase, open a Pull Request. Your PR is how your work gets reviewed.

You will not be asked "how is it going." Your commits and PRs are the answer to that question.

---

## Start here

Go to `01-phase-1-core-setup.md` and follow the steps.

---

*AI-Driven LMS — Developer Assignment v1.0*
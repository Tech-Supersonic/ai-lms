# AI-Driven Learning Management System

A personal skill-building system for developers. An AI agent tracks your learning, teaches you using a structured process, and keeps your skill list aligned with what the job market wants.

## What you will have when done

- A live database tracking every skill in your learning plan
- An AI agent that ingests topics and teaches you step by step
- A visual dashboard (NocoDB) to browse and manage your progress
- A daily feed of in-demand skills from real job postings
- A daily feed of relevant tech and AI news
- A GitHub repository with CI/CD pipeline
- A written case study and recorded presentation

## Prerequisites

| Tool | Link | Required for |
|---|---|---|
| Git | git-scm.com | All phases |
| GitHub account | github.com | All phases |
| Docker Desktop | docker.com | Phase 1 |
| pgAdmin | pgadmin.org | Phase 1 |
| Dokploy access | TSS server | Phase 1 |
| Claude.ai account | claude.ai | Phase 1 |
| n8n | n8n.io | Phase 2 + 3 |

## Setup — follow in order

1. Read `00-overview.md` first
2. `01-phase-1-core-setup.md` — database, NocoDB, AI agent
3. `02-phase-2-job-scanner.md` — job market automation
4. `03-phase-3-news-feed.md` — news relevance feed
5. `04-github-and-cicd.md` — repo and CI/CD pipeline
6. `05-document-and-present.md` — case study and presentation

## Key commands

| Say this | What happens |
|---|---|
| `open session` | Shows your current progress |
| `teach me X` | Starts The Learning Sprint for skill X |
| `add X` | Intake flow for a tool, topic, or URL |
| `add my master profile` | Parses your profile and adds skills |
| `done` | Marks current skill complete |
| `what's next` | Shows your next priority skill |
| `review my feed` | Opens daily jobs and news review |

## Tech stack

PostgreSQL · NocoDB · n8n · Claude (or any capable AI) · GitHub Actions

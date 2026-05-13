# AI-Driven Learning Management System

An AI-powered learning management system designed to help developers track skills, automate learning workflows, monitor job market trends, and stay updated with relevant technology news.

---

# Overview

This project combines AI, databases, automation workflows, and developer tooling into a centralized learning platform.

The system helps developers:
- Track learning progress
- Organize technical skills
- Monitor in-demand job market skills
- Receive relevant AI and tech news
- Learn through AI-guided learning sprints

---

# System Architecture

## Core Components

### PostgreSQL
Main database storing:
- learning skills
- tools
- market signals
- news feed data

### NocoDB
Spreadsheet-style dashboard for managing and visualizing database data.

### AI Agent (Claude)
Handles:
- skill ingestion
- learning guidance
- daily review workflows

### n8n
Automation workflows for:
- job market scanning
- news feed aggregation
- API integrations

---
Here is the video: loom.com/share/100bbc9117cf4ba888bfb2d9b926f810?from_recorder=1&focus_title=1 
# Project Structure

```bash
skills/
├── ingestion.md
├── learning.md
└── daily-review.md

docs/
database/
workflows/
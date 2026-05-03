---
name: daily-review
description: Load this skill when the user wants to review their daily feeds, check job market signals, check news, or says 'review my feed', 'what is new', or 'daily review'.
---

# Skill: Daily Review

You handle the daily review session. Your job is to surface unreviewed job market signals and news articles and help the user decide what to do with each one — add it to their learning list, skip it, or save the link for later.

This is a fast, focused session. The goal is to clear the feed and make decisions, not to discuss every item at length.

---

## How to run the daily review

When the user says "review my feed" or "daily review":

1. Query `pending_signals` view — get all unreviewed job market signals
2. Query `pending_news` view — get all unreviewed news articles
3. Report the counts: "You have [X] job signals and [Y] news articles to review. Starting with job signals."

If both are empty: "Your feeds are clear. Nothing new since your last review."

---

## Part 1 — Job market signals

Present signals in order of frequency (highest first). For each one:

Show:
```
Skill: [skill_name]
Seen in: [frequency] postings
Role: [role_matched]
Source: [source]
```

Ask: "Add to learning list, skip, or later?"

- **Add** — run the ingestion flow: propose fields for `learning_skills`, confirm, insert. Mark `reviewed = TRUE` in `market_signals`.
- **Skip** — mark `reviewed = TRUE` in `market_signals`. Move to next.
- **Later** — leave `reviewed = FALSE`. Move to next.

After all signals: "Job signals done. [X] added, [Y] skipped, [Z] left for later."

---

## Part 2 — News articles

Present articles in order of relevance (high first, then medium). For each one:

Show:
```
[title]
[summary — one or two sentences]
Relevance: [high/medium] · Tags: [tags]
Source: [source]
```

Ask: "Add topic to learning list, open link, skip, or later?"

- **Add** — extract the main topic or tool from the article and run the ingestion flow. Mark `actioned = TRUE` in `news_feed`.
- **Open** — provide the link. Mark `actioned = TRUE` in `news_feed`.
- **Skip** — mark `actioned = TRUE` in `news_feed`. Move to next.
- **Later** — leave `actioned = FALSE`. Move to next.

After all articles: "News review done. [X] topics added, [Y] links shared, [Z] skipped, [W] left for later."

---

## End of review

After both parts are complete, give a short summary:

```
Review complete.
  Job signals: [X] added · [Y] skipped
  News: [X] added · [Y] opened · [Z] skipped
  Learning list: [total skills] skills, [in_progress count] in progress
```

Then query `next_up` and say: "Next up when you are ready: [skill name]."

---

## Rules

- Do not show all items at once. Present them one at a time.
- Do not push the user to add everything. Skip is a valid answer.
- If the user says "add all signals" or "skip all news", process them in bulk without asking one by one.
- Keep each item presentation short. The summary should be two sentences maximum.
- You do not teach during a review session. If the user asks to learn something, remind them to say "teach me [skill]" after the review is done.
- If the feeds are both empty, end the session immediately. Do not pad with suggestions.

---

## NocoDB MCP operations

**Query pending signals:**
- View: `pending_signals`

**Query pending news:**
- View: `pending_news`

**Mark signal reviewed:**
- Table: `market_signals`
- Operation: update record
- Field: `reviewed = TRUE`
- Filter by: `skill_name` and `captured_on`

**Mark news actioned:**
- Table: `news_feed`
- Operation: update record
- Field: `actioned = TRUE`
- Filter by: `title` and `captured_on`

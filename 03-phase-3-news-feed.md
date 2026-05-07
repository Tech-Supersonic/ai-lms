# Phase 3 — News Relevance Feed
### AI-Driven Learning Management System

---

## Before you start

Phase 2 must be fully complete before starting this phase. Your `market_signals` table should be populated and your daily review should be working.

---

## What you are building in this phase

An automated workflow that runs daily, monitors tech and AI news sources, filters articles that are relevant to your skill categories, and saves them to your database. Your AI agent will surface these during your daily review alongside the job market signals.

By the end of this phase you will have:

- A `news_feed` table in your database
- A working n8n workflow that populates it daily
- Your daily review covering both job signals and news in one session
- Everything committed to your repository

---

## Step 1 — Create a new branch

```bash
git checkout main
git pull origin main
git checkout -b phase-3-news-feed
```

---

## Step 2 — Add the news_feed table

Open pgAdmin and run:

```sql
CREATE TABLE news_feed (
  id           SERIAL PRIMARY KEY,
  title        TEXT NOT NULL,
  summary      TEXT,
  link         TEXT,
  relevance    TEXT,
  tags         TEXT,
  source       TEXT,
  published_on DATE,
  captured_on  DATE DEFAULT CURRENT_DATE,
  actioned     BOOLEAN DEFAULT FALSE
);
```

Verify:
```sql
SELECT table_name FROM information_schema.tables
WHERE table_schema = 'public';
```

---

## Step 3 — Build the news feed workflow in n8n

Create a new workflow in n8n. This one has six nodes.

**Node 1 — Schedule trigger**
```
Type: Schedule Trigger
Rule: Every day at 08:30
```
Run this 30 minutes after the job scanner so both feeds are ready when you open your session.

**Node 2 — RSS Feed node (multiple sources)**

Add one RSS Feed node per source. Use the Merge node after to combine them. Recommended sources:

| Source | RSS URL |
|---|---|
| Hacker News (AI filter) | https://hnrss.org/newest?q=AI+LLM+agent |
| The Batch (DeepLearning.AI) | https://www.deeplearning.ai/the-batch/feed |
| Towards Data Science | https://towardsdatascience.com/feed |
| Simon Willison's blog | https://simonwillison.net/atom/everything |
| GitHub Trending (via RSS bridge) | https://mshibanami.github.io/GitHubTrendingRSS/daily/python.xml |

Start with two or three sources. Add more once the workflow is running cleanly.

```
Type: RSS Feed
URL: paste the feed URL
```

**Node 3 — Merge node**
Combines all RSS feed outputs into a single stream.
```
Type: Merge
Mode: Append
```

**Node 4 — Code node (filter by relevance)**
Checks each article title and description against your skill categories and assigns a relevance score.

```javascript
const items = $input.all();
const keywords = {
  high: [
    'llm', 'agent', 'mcp', 'langchain', 'langgraph', 'rag',
    'vector', 'fine-tuning', 'ollama', 'openai', 'anthropic',
    'n8n', 'automation', 'postgresql', 'docker', 'kubernetes'
  ],
  medium: [
    'ai', 'machine learning', 'python', 'api', 'backend',
    'open source', 'developer tools', 'deployment', 'cloud'
  ]
};

const results = [];

for (const item of items) {
  const text = (
    (item.json.title || '') + ' ' +
    (item.json.contentSnippet || item.json.summary || '')
  ).toLowerCase();

  let relevance = null;

  if (keywords.high.some(k => text.includes(k))) {
    relevance = 'high';
  } else if (keywords.medium.some(k => text.includes(k))) {
    relevance = 'medium';
  }

  if (!relevance) continue;

  const matchedTags = [
    ...keywords.high.filter(k => text.includes(k)),
    ...keywords.medium.filter(k => text.includes(k))
  ].slice(0, 5).join(', ');

  results.push({
    json: {
      title: item.json.title,
      summary: (item.json.contentSnippet || item.json.summary || '').slice(0, 300),
      link: item.json.link,
      relevance,
      tags: matchedTags,
      source: item.json.feedUrl || 'rss',
      published_on: item.json.pubDate
        ? new Date(item.json.pubDate).toISOString().split('T')[0]
        : new Date().toISOString().split('T')[0],
      captured_on: new Date().toISOString().split('T')[0],
      actioned: false
    }
  });
}

return results;
```

Edit the `keywords` object to match your skill categories. High relevance articles surface first in your daily review.

**Node 5 — HTTP Request (insert to NocoDB)**

```
Type: HTTP Request
Method: POST
URL: https://your-nocodb-url/api/v1/db/data/noco/YOUR_PROJECT_ID/news_feed
Headers:
  xc-auth: your_nocodb_api_token
  Content-Type: application/json
Body: {{ $json }}
```

**Node 6 — Code node (log completion)**

```javascript
const inserted = $input.all().length;
return [{ json: { message: `News feed complete. ${inserted} articles saved.` } }];
```

---

## Step 4 — Test the workflow

Run manually once:
```
n8n → your workflow → Execute Workflow
```

Check NocoDB — rows should appear in `news_feed`. Check that:
- Titles and summaries look clean
- Relevance is either `high` or `medium`
- Tags are populated

Once it works, activate the schedule.

---

## Step 5 — Add a view for the daily review

In pgAdmin:

```sql
CREATE VIEW pending_news AS
SELECT title, summary, link, relevance, tags, source, published_on
FROM news_feed
WHERE actioned = FALSE
ORDER BY
  CASE relevance WHEN 'high' THEN 1 WHEN 'medium' THEN 2 ELSE 3 END,
  captured_on DESC;
```

High relevance articles appear first.

---

## Step 6 — Test the full daily review

Open a chat with your agent and say:

**"review my feed"**

The agent will now surface both job signals and news articles in one session using `daily-review.md`. For each news article you can say:

- **"add"** — agent runs the ingestion flow and adds the topic to `learning_skills`
- **"skip"** — agent marks it actioned
- **"open"** — agent gives you the link to read it yourself

---

## Step 7 — Export and commit

Export the workflow from n8n:
```
Workflow menu → Download
```

Save as `automations/news_feed.json` in your repository.

```bash
git add .
git commit -m "phase 3: news_feed table, n8n news workflow, pending_news view, full daily review"
git push origin phase-3-news-feed
```

Open a Pull Request from `phase-3-news-feed` into `main`. Include a screenshot of NocoDB showing populated `news_feed` rows and note which RSS sources you used.

---

## Phase 3 checklist

- [-] `news_feed` table created and verified
- [-] n8n workflow built with all six nodes
- [-] At least two RSS sources connected
- [-] Workflow tested manually — articles appear in NocoDB
- [-] Relevance filtering working — only `high` and `medium` articles saved
- [-] Schedule activated
- [-] `pending_news` view created
- [-] Full daily review tested — both job signals and news in one session
- [-] Workflow exported to `automations/news_feed.json`
- [-] Changes committed and PR opened with screenshot

---

## What is next

Once your Phase 3 PR is reviewed and approved, move to `04-github-and-cicd.md`.

---

*Phase 3 of 5 — AI-Driven LMS Developer Assignment*

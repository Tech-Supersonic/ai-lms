# Phase 5 — Document and Present
### AI-Driven Learning Management System

---

## Before you start

All four previous phases must be complete and merged into `main`. Your system should be fully running and your repository should be clean.

---

## What you are doing in this phase

You are going to explain what you built — in writing, as a visual, as a video, and live.

This is not extra work on top of the real work. This is the real work. The ability to explain what you built, why you built it, and how it works is what separates developers who get hired from developers who do not.

By the end of this phase you will have:

- A written case study covering the full journey
- A NotebookLM infographic or audio overview
- A recorded video walkthrough of your system
- A live presentation delivered on a call

---

## Step 1 — Write the case study

Write a document called `case-study.md` in the root of your repository.

Structure it in three parts:

**Part 1 — The problem**

What problem does this system solve? Write this as if explaining to someone who has never heard of a learning management system. Keep it simple. Two to three paragraphs.

Answer these questions:
- What does a developer without this system have to do manually?
- What goes wrong without a system like this?
- Why does it matter to have your learning aligned with what the job market wants?

**Part 2 — The plan**

How did you approach building it? Three to four paragraphs.

Answer these questions:
- What are the main components and how do they fit together?
- What decisions did you make and why? (For example: why PostgreSQL, why NocoDB, why n8n)
- What did you do in phases and why in that order?

**Part 3 — The execution**

What did you actually build and what did you learn? Four to five paragraphs.

Answer these questions:
- What does each phase deliver?
- What was harder than you expected?
- What would you do differently if you started again?
- What will you use this system for going forward?

Write in plain English. Short sentences. No bullet points in this document — write in paragraphs. This is a professional case study, not a list of tasks.

---

## Step 2 — Create a NotebookLM overview

Go to **notebooklm.google.com** and create a new notebook.

Upload your `case-study.md` as a source. You can also upload your `00-overview.md` and `README.md` for more context.

Then do one of the following — your choice:

**Option A — Mind map**
Click the Mind Map button. NotebookLM will generate a visual overview of the problem, plan, and execution. Screenshot it and save it as `docs/system-overview.png` in your repository.

**Option B — Audio overview**
Click the Audio Overview button. NotebookLM will generate a short podcast-style discussion of your case study. Listen to it. If it sounds right, download it and note the link in your case study.

Either option works. The point is to see your work translated into a different format — it will tell you quickly if your writing was clear enough.

---

## Step 3 — Record a video walkthrough

Record a screen recording of yourself walking through your system. Aim for 5 to 8 minutes. No longer.

**What to cover:**

1. Open your repository on GitHub and briefly show the structure — 30 seconds
2. Open NocoDB and show your `learning_skills` table with real data — 1 minute
3. Open a chat with your AI agent and run a short demo:
   - Say "open session" and show the response
   - Add one skill from a URL or by name
   - Say "teach me X" for a skill in your list and show the first step of The Learning Sprint
4. Open n8n and show your job scanner and news feed workflows — 1 minute
5. Open GitHub Actions and show a green pipeline run — 30 seconds
6. Close with one sentence about what you will use this system for next

**Tone:** Calm and clear. You are not presenting to a crowd — you are walking a colleague through something you built. Speak at normal pace. It is fine to pause. It is fine to say "let me show you this."

**Tools for recording:** Loom (free tier), OBS, or any screen recording tool you have. Loom is easiest if you have not done this before.

Save the link or file. You will share it in your final PR.

---

## Step 4 — Prepare for the live presentation

The live presentation is the same content as the video but delivered in real time with questions.

**Prepare three things:**

1. **A one-minute opening.** Introduce yourself, introduce the system, say what you will cover. Practice this until you can say it without reading.

2. **A live demo path.** Know exactly which tabs you will have open and in what order. The worst thing that can happen in a live demo is getting lost between windows. Write the order down:
   - GitHub repo
   - NocoDB — `learning_skills` table
   - Agent chat — "open session"
   - Agent chat — add a skill
   - Agent chat — start a learning sprint
   - n8n — job scanner workflow
   - n8n — news feed workflow
   - GitHub Actions — pipeline run

3. **Answers to likely questions.** Think through what someone might ask:
   - Why did you choose PostgreSQL over a simpler option?
   - How does the agent know what to do?
   - What happens if the job board API goes down?
   - What would you add next if you had more time?

Practice the presentation at least twice before the live call. Once alone, once with someone watching.

**On the call itself:** Speak slowly. It is always slower than you think. If you do not know the answer to a question, say "I am not sure — I would have to look into that" and move on. That is a professional answer.

---

## Step 5 — Final commit

Add your case study and any docs to the repository:

```bash
git add case-study.md docs/
git commit -m "phase 5: case study, system overview, video walkthrough link"
git push origin phase-5-presentation
```

Open a final Pull Request. In the PR description include:
- A link to your video walkthrough
- One sentence about the live presentation date

---

## Phase 5 checklist

- [ ] `case-study.md` written — three parts, plain English paragraphs
- [ ] NotebookLM notebook created with your documents as sources
- [ ] Mind map or audio overview generated
- [ ] Video walkthrough recorded — 5 to 8 minutes, calm and clear
- [ ] Live presentation prepared — opening, demo path, likely questions
- [ ] Live presentation delivered
- [ ] Final PR opened with video link

---

## You are done

When your Phase 5 PR is merged, you have completed the full assignment.

You have built a working system, automated it, shipped it properly with version control and CI/CD, documented it, and presented it. That is a complete professional cycle — the same loop that happens on real teams at real companies.

Keep using the system. It was built for you.

---

*Phase 5 of 5 — AI-Driven LMS Developer Assignment*

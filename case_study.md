# Case Study — AI-Driven Learning Management System

## Part 1 — The Problem

Without a structured system, developers track their learning in scattered notes, 
spreadsheets, or just memory. There is no way to know if what you are learning 
matches what employers actually want. You can spend weeks learning something that 
is rarely asked for in job postings, while missing skills that appear in every 
job description you look at.

The other problem is consistency. Most developers start learning something, get 
distracted, and never finish. Without a system to track what is in progress and 
what is next, learning becomes random and incomplete.

This system solves both problems. It tracks every skill, aligns the learning list 
with real job market data, and gives an AI agent the ability to teach skills using 
a structured five-step process.

## Part 2 — The Plan

The system has four components that work together. A PostgreSQL database stores 
all skills, job market signals, and news articles. NocoDB sits on top of the 
database as a visual dashboard. An AI agent reads three skill files and uses them 
to add skills, teach, and run daily reviews. Two n8n automations run daily to 
pull job market data and tech news into the database.

I chose PostgreSQL because it is the industry standard for relational data and 
appears in almost every backend job description. NocoDB was chosen because it 
gives a spreadsheet-style interface on top of the database without requiring any 
frontend code. n8n was chosen for automation because it has a visual workflow 
builder and connects to APIs without writing much code.

I built it in five phases — core setup first, then automations, then CI/CD, then 
documentation. Each phase builds on the previous one. Starting with the database 
meant every other component had something real to connect to from day one.

## Part 3 — The Execution

Phase 1 delivered the database, NocoDB, and the AI agent connection via MCP. 
This was the hardest phase because it involved the most infrastructure — deploying 
PostgreSQL on Dokploy, connecting NocoDB to the database, and getting the MCP 
server running so Claude Desktop could query the database directly from chat.

Phase 2 delivered the job scanner — an n8n workflow that runs daily, pulls job 
postings from the Adzuna API, extracts skill keywords from job descriptions, and 
saves the frequency counts to the market_signals table.

Phase 3 added the news feed — an n8n workflow that pulls from RSS feeds, filters 
articles by relevance using keyword matching, and saves high and medium relevance 
articles to the news_feed table.

Phase 4 added the GitHub repository and CI/CD pipeline. A GitHub Actions workflow 
now validates the schema SQL on every push, catching syntax errors before they 
reach the database.

The hardest part was the NocoDB and MCP connection. The database and NocoDB were 
on different Docker networks, and port 5432 was blocked by the server firewall. 
This took significant troubleshooting to resolve. If I started again I would 
deploy everything in a single Docker Compose file from the beginning.

I will use this system throughout my developer journey — adding skills as I 
encounter new technologies, running the daily review to stay aligned with the 
job market, and using the learning sprint to go deep on the skills that matter most.
# Case Study — AI-Driven Learning Management System

## Part 1 — The Problem

Developers often struggle to organize their learning in a structured way. Most learning happens across multiple disconnected platforms such as YouTube tutorials, online courses, documentation websites, and personal notes. Tracking progress manually becomes difficult over time, especially when learning many technologies at once.

Another major problem is staying aligned with the job market. Developers may spend weeks learning technologies that are no longer highly demanded while missing skills that companies are actively hiring for. Monitoring job postings, technology trends, and industry news manually takes significant time and effort.

This project was designed to solve those problems by creating a centralized AI-driven learning management system. The system combines skill tracking, AI-assisted learning, automation workflows, and market analysis into one platform. The goal is to help developers learn more efficiently while staying aligned with real industry demand.

---

## Part 2 — The Plan

The system was designed around four main components: PostgreSQL, NocoDB, an AI agent, and n8n automation workflows.

PostgreSQL was selected as the primary database because it is reliable, scalable, and widely used in professional software development. It stores all structured data including learning skills, tools, market signals, and news feeds. NocoDB was placed on top of PostgreSQL to provide a spreadsheet-style interface for browsing and managing data without writing SQL manually.

The AI agent acts as the intelligent layer of the system. It reads instruction files stored inside the `skills/` directory and uses them to manage learning workflows. These workflows include skill ingestion, teaching sessions, and daily reviews. The goal was to create a system that behaves more like a personal technical mentor rather than a static LMS platform.

n8n was used to automate workflows such as job market scanning and technology news aggregation. This allows the system to continuously collect external information and keep learning priorities aligned with industry trends.

The project was built in phases to reduce complexity and create a clear development process. The first phase focused on the core infrastructure and database setup. Later phases introduced automation, workflow integration, CI/CD, and documentation.

---

## Part 3 — The Execution

During Phase 1, the core architecture of the system was established. PostgreSQL, Docker, pgAdmin, and NocoDB were configured to create the database environment and management dashboard. The initial AI instruction files were also structured during this phase.

Phase 2 introduced automation workflows for scanning job postings and extracting market signals. This phase focused on collecting information about in-demand technologies and skills from external sources. Phase 3 extended the automation layer further by introducing personalized news feeds and relevance filtering for AI and technology updates.

Phase 4 focused on engineering discipline and repository management. GitHub Actions and CI/CD workflows were added to improve project organization and automation practices. The repository was structured to make the project easier to maintain and present.

One of the most challenging parts of the project was integrating the AI workflow with database operations through MCP connections. Coordinating communication between the AI agent, workflow instructions, and database actions required careful debugging and architecture planning.

If the project continues in the future, the next improvements would include stabilizing MCP integration, adding authentication, building a dedicated frontend dashboard, and introducing analytics for learning progress.

This project helped strengthen skills in system architecture, databases, automation, AI workflow design, GitHub workflows, and technical communication. More importantly, it demonstrated how multiple tools and technologies can work together to build a practical developer-focused platform.
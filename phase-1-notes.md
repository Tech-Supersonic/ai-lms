# Phase 1 — Setup Notes

## Database
- Provider: Dokploy (TSS server)
- Host: env.talent.techsupersonic.com
- Database name: ai-lms
- User: lms_user
- Port: 5432
- Status: Running ✅

## Schema
- All 4 tables created: learning_skills, tools, market_signals, news_feed
- All 6 views created
- Status: Complete ✅

## NocoDB
- URL: https://nocodb.maria.talent.techsupersonic.com
- Status: Deployed, pending port 5432 firewall access ⏳

## Skill files
- ingestion.md ✅
- learning.md ✅
- daily-review.md ✅
- Uploaded to Claude.ai project: AI LMS ✅

## Blockers
- Port 5432 needs to be opened on server firewall for NocoDB to connect to database
-- ============================================================
-- AI-Driven Learning Management System
-- Complete Schema — run this in pgAdmin Query Tool
-- ============================================================


-- ------------------------------------------------------------
-- TABLES
-- ------------------------------------------------------------

CREATE TABLE learning_skills (
    id           SERIAL PRIMARY KEY,
    number       INTEGER UNIQUE,
    name         TEXT NOT NULL,
    category     TEXT NOT NULL,
    summary      TEXT,
    link         TEXT,
    why          TEXT,
    needs_first  TEXT,
    depth        TEXT DEFAULT 'working',
    priority     INTEGER DEFAULT 2,
    status       TEXT DEFAULT 'not_started',
    hours_est    NUMERIC(5, 1),
    hours_actual NUMERIC(5, 1) DEFAULT 0,
    started_on   DATE,
    finished_on  DATE,
    project      TEXT,
    deliverable  TEXT,
    notes        TEXT,
    updated_at   TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE tools (
    id       SERIAL PRIMARY KEY,
    name     TEXT NOT NULL,
    category TEXT NOT NULL,
    status   TEXT DEFAULT 'aware',
    link     TEXT,
    notes    TEXT,
    added_on DATE DEFAULT CURRENT_DATE
);

CREATE TABLE market_signals (
    id           SERIAL PRIMARY KEY,
    skill_name   TEXT NOT NULL,
    frequency    INTEGER DEFAULT 1,
    source       TEXT,
    role_matched TEXT,
    captured_on  DATE DEFAULT CURRENT_DATE,
    reviewed     BOOLEAN DEFAULT FALSE
);

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


-- ------------------------------------------------------------
-- CONSTRAINTS
-- ------------------------------------------------------------

ALTER TABLE learning_skills ADD CONSTRAINT status_check
CHECK (status IN ('not_started', 'in_progress', 'done', 'skipped', 'revisit'));

ALTER TABLE learning_skills ADD CONSTRAINT depth_check
CHECK (depth IN ('skim', 'working', 'deep'));

ALTER TABLE learning_skills ADD CONSTRAINT priority_check
CHECK (priority IN (1, 2, 3));

ALTER TABLE learning_skills ADD CONSTRAINT category_check
CHECK (category IN (
    'ai',
    'automation',
    'backend',
    'frontend',
    'infrastructure',
    'data',
    'security',
    'leadership',
    'other'
));

ALTER TABLE tools ADD CONSTRAINT tools_status_check
CHECK (status IN ('aware', 'used', 'rejected'));


-- ------------------------------------------------------------
-- AUTO-UPDATE TRIGGER
-- ------------------------------------------------------------

CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER skills_updated_at
BEFORE UPDATE ON learning_skills
FOR EACH ROW EXECUTE FUNCTION update_updated_at();


-- ------------------------------------------------------------
-- VIEWS
-- ------------------------------------------------------------

-- What you are working on right now
CREATE VIEW current_sprint AS
SELECT
    number,
    name,
    category,
    depth,
    started_on,
    hours_est,
    project
FROM learning_skills
WHERE status = 'in_progress'
ORDER BY started_on;

-- Your next priority skill
CREATE VIEW next_up AS
SELECT
    number,
    name,
    category,
    depth,
    hours_est,
    needs_first,
    deliverable
FROM learning_skills
WHERE priority = 1
    AND status = 'not_started'
ORDER BY number
LIMIT 1;

-- Overall progress counts
CREATE VIEW progress_totals AS
SELECT
    status,
    COUNT(*) AS count,
    SUM(hours_est) AS hours
FROM learning_skills
GROUP BY status;

-- Progress by project
CREATE VIEW project_progress AS
SELECT
    project,
    COUNT(*) AS total,
    SUM(CASE WHEN status = 'done' THEN 1 ELSE 0 END) AS done,
    SUM(hours_est) AS hours_est
FROM learning_skills
WHERE project IS NOT NULL
GROUP BY project
ORDER BY done DESC;

-- Unreviewed job market signals
CREATE VIEW pending_signals AS
SELECT
    skill_name,
    frequency,
    source,
    role_matched,
    captured_on
FROM market_signals
WHERE reviewed = FALSE
ORDER BY frequency DESC, captured_on DESC;

-- Unreviewed news articles
CREATE VIEW pending_news AS
SELECT
    title,
    summary,
    link,
    relevance,
    tags,
    source,
    published_on
FROM news_feed
WHERE actioned = FALSE
ORDER BY
    CASE relevance WHEN 'high' THEN 1 WHEN 'medium' THEN 2 ELSE 3 END,
    captured_on DESC;


-- ------------------------------------------------------------
-- VERIFY SETUP
-- Run this after the schema to confirm everything was created
-- ------------------------------------------------------------

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

-- Expected output:
-- learning_skills
-- market_signals
-- news_feed
-- tools


-- ------------------------------------------------------------
-- ADD A NEW CATEGORY (run when needed)
-- Replace 'your_new_category' with the category name
-- ------------------------------------------------------------

-- ALTER TABLE learning_skills DROP CONSTRAINT category_check;
-- ALTER TABLE learning_skills ADD CONSTRAINT category_check
-- CHECK (category IN (
--     'ai', 'automation', 'backend', 'frontend',
--     'infrastructure', 'data', 'security', 'leadership', 'other',
--     'your_new_category'
-- ));


-- ------------------------------------------------------------
-- RESET SEQUENCE (run after bulk imports)
-- ------------------------------------------------------------

-- SELECT setval('learning_skills_id_seq', (SELECT MAX(id) FROM learning_skills));
-- updated

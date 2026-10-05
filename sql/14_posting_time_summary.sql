-- Posting time summary.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

SELECT
    COUNT(*) AS total_journals,
    SUM(CASE WHEN DAYOFWEEK(posted_at) IN (1, 7)
        THEN 1 ELSE 0 END) AS weekend_journals,
    SUM(CASE WHEN HOUR(posted_at) < 8 OR HOUR(posted_at) >= 18
        THEN 1 ELSE 0 END) AS out_of_hours_journals,
    SUM(CASE WHEN DAYOFWEEK(posted_at) IN (1, 7)
              OR HOUR(posted_at) < 8
              OR HOUR(posted_at) >= 18
        THEN 1 ELSE 0 END) AS flagged_journals
FROM journals;

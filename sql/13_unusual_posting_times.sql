-- Weekend and out-of-hours postings.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

SELECT
    journal_id,
    posted_at,
    department,
    supplier,
    document_no,
    entry_type,
    employee,
    approver,
    CASE
        WHEN DAYOFWEEK(posted_at) IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_flag,
    CASE
        WHEN HOUR(posted_at) < 8 OR HOUR(posted_at) >= 18
            THEN 'Out of hours'
        ELSE 'Business hours'
    END AS time_flag
FROM journals
WHERE DAYOFWEEK(posted_at) IN (1, 7)
   OR HOUR(posted_at) < 8
   OR HOUR(posted_at) >= 18
ORDER BY posted_at;

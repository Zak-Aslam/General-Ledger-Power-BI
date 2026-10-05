-- Ledger and budget data quality checks.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

SELECT
    'Ledger lines without a matching journal' AS check_name,
    COUNT(*) AS issues_found
FROM ledger_lines AS l
LEFT JOIN journals AS j
    ON l.journal_id = j.journal_id
WHERE j.journal_id IS NULL

UNION ALL

SELECT
    'Ledger lines without a matching account',
    COUNT(*)
FROM ledger_lines AS l
LEFT JOIN accounts AS a
    ON l.account_code = a.account_code
WHERE a.account_code IS NULL

UNION ALL

SELECT
    'Missing or invalid debit/credit amounts',
    COUNT(*)
FROM ledger_lines
WHERE debit IS NULL
   OR credit IS NULL
   OR debit < 0
   OR credit < 0
   OR (debit > 0 AND credit > 0)
   OR (debit = 0 AND credit = 0)

UNION ALL

SELECT
    'Journals with no ledger lines',
    COUNT(*)
FROM journals AS j
WHERE NOT EXISTS (
    SELECT 1
    FROM ledger_lines AS l
    WHERE l.journal_id = j.journal_id
)

UNION ALL

SELECT
    'Unbalanced journals',
    COUNT(*)
FROM (
    SELECT journal_id
    FROM ledger_lines
    GROUP BY journal_id
    HAVING ROUND(SUM(debit) - SUM(credit), 2) <> 0
) AS unbalanced

UNION ALL

SELECT
    'Journals missing a date or department',
    COUNT(*)
FROM journals
WHERE posted_at IS NULL
   OR department IS NULL
   OR TRIM(department) = ''

UNION ALL

SELECT
    'Duplicate budget combinations',
    COUNT(*)
FROM (
    SELECT month, department, account_code
    FROM budgets
    GROUP BY month, department, account_code
    HAVING COUNT(*) > 1
) AS duplicate_budgets;

-- Monthly net revenue.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

SELECT
    DATE_FORMAT(j.posted_at, '%Y-%m') AS month,
    ROUND(SUM(l.credit - l.debit), 2) AS revenue_gbp
FROM journals AS j
JOIN ledger_lines AS l
    ON j.journal_id = l.journal_id
JOIN accounts AS a
    ON l.account_code = a.account_code
WHERE a.category = 'Revenue'
GROUP BY DATE_FORMAT(j.posted_at, '%Y-%m')
ORDER BY month;

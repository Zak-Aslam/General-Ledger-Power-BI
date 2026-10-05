-- Monthly net expenses.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

SELECT
    DATE_FORMAT(j.posted_at, '%Y-%m') AS month,
    ROUND(SUM(l.debit - l.credit), 2) AS total_expense_gbp
FROM journals AS j
JOIN ledger_lines AS l
    ON j.journal_id = l.journal_id
JOIN accounts AS a
    ON l.account_code = a.account_code
WHERE a.category = 'Expense'
GROUP BY DATE_FORMAT(j.posted_at, '%Y-%m')
ORDER BY month;

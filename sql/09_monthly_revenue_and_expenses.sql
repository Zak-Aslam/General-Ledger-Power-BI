-- Monthly revenue and expenses.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

SELECT
    DATE_FORMAT(j.posted_at, '%Y-%m') AS month,
    ROUND(SUM(CASE
        WHEN a.category = 'Revenue' THEN l.credit - l.debit
        ELSE 0
    END), 2) AS revenue_gbp,
    ROUND(SUM(CASE
        WHEN a.category = 'Expense' THEN l.debit - l.credit
        ELSE 0
    END), 2) AS expenses_gbp,
    ROUND(SUM(CASE
        WHEN a.category = 'Revenue' THEN l.credit - l.debit
        WHEN a.category = 'Expense' THEN l.credit - l.debit
        ELSE 0
    END), 2) AS revenue_less_expenses_gbp
FROM journals AS j
JOIN ledger_lines AS l
    ON j.journal_id = l.journal_id
JOIN accounts AS a
    ON l.account_code = a.account_code
WHERE a.category IN ('Revenue', 'Expense')
GROUP BY DATE_FORMAT(j.posted_at, '%Y-%m')
ORDER BY month;

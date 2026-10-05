-- September and October payroll by department.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

SELECT
    DATE_FORMAT(j.posted_at, '%Y-%m') AS month,
    j.department,
    ROUND(SUM(l.debit - l.credit), 2) AS total_expense_gbp
FROM journals AS j
JOIN ledger_lines AS l
    ON j.journal_id = l.journal_id
JOIN accounts AS a
    ON l.account_code = a.account_code
WHERE a.category = 'Expense'
	AND a.account_name = 'Payroll'
	AND j.posted_at >= '2025-09-01'
    AND j.posted_at < '2025-11-01'
GROUP BY DATE_FORMAT(j.posted_at, '%Y-%m'),
	j.department
ORDER BY j.department, month;

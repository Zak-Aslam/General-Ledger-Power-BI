-- Net expense totals by account.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

SELECT
    a.account_name,
    ROUND(SUM(l.debit - l.credit), 2) AS total_expense_gbp
FROM ledger_lines AS l
JOIN accounts AS a
    ON l.account_code = a.account_code
WHERE a.category = 'Expense'
GROUP BY a.account_name
ORDER BY total_expense_gbp DESC;

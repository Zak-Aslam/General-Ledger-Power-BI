-- Supplier expense totals excluding payroll.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

SELECT
    j.supplier,
    COUNT(DISTINCT j.journal_id) AS transaction_count,
    ROUND(SUM(l.debit - l.credit), 2) AS expense_gbp
FROM journals AS j
JOIN ledger_lines AS l
    ON j.journal_id = l.journal_id
JOIN accounts AS a
    ON l.account_code = a.account_code
WHERE a.category = 'Expense'
    AND a.account_name <> 'Payroll'
    AND j.supplier IS NOT NULL
    AND j.supplier <> ''
GROUP BY j.supplier
ORDER BY expense_gbp DESC;

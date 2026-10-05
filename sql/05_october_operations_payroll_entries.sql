-- October Operations payroll ledger detail.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

SELECT
    j.journal_id,
    j.posted_at,
    j.document_no,
    j.supplier,
    j.description,
    (l.debit - l.credit) AS expense_gbp
FROM journals AS j
JOIN ledger_lines AS l
    ON j.journal_id = l.journal_id
JOIN accounts AS a
    ON l.account_code = a.account_code
WHERE j.department = 'Operations'
  AND a.account_name = 'Payroll'
  AND a.category = 'Expense'
  AND j.posted_at >= '2025-10-01'
  AND j.posted_at < '2025-11-01'
ORDER BY expense_gbp DESC;

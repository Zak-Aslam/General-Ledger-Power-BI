-- Large non-payroll expense journals.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

SELECT
    j.journal_id,
    j.posted_at,
    j.department,
    j.supplier,
    j.document_no,
    j.entry_type,
    j.employee,
    j.approver,
    ROUND(SUM(l.debit - l.credit), 2) AS expense_gbp
FROM journals AS j
JOIN ledger_lines AS l
    ON j.journal_id = l.journal_id
JOIN accounts AS a
    ON l.account_code = a.account_code
WHERE a.category = 'Expense'
    AND a.account_name <> 'Payroll'
GROUP BY
    j.journal_id, j.posted_at, j.department,
    j.supplier, j.document_no, j.entry_type,
    j.employee, j.approver
HAVING expense_gbp >= 10000
ORDER BY expense_gbp DESC;

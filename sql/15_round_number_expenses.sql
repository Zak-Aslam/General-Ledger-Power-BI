-- Positive round-number expense journals.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

SELECT
    j.journal_id,
    j.posted_at,
    j.department,
    j.supplier,
    j.document_no,
    j.approver,
    ROUND(SUM(l.debit - l.credit), 2) AS expense_gbp
FROM journals AS j
JOIN ledger_lines AS l
    ON j.journal_id = l.journal_id
JOIN accounts AS a
    ON l.account_code = a.account_code
WHERE a.category = 'Expense'
GROUP BY
    j.journal_id, j.posted_at, j.department,
    j.supplier, j.document_no, j.approver
HAVING expense_gbp > 0
   AND MOD(expense_gbp, 100) = 0
ORDER BY expense_gbp DESC;

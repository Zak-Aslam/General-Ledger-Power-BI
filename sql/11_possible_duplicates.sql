-- Potential duplicate expense journals.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

WITH expense_journals AS (
    SELECT
        j.journal_id,
        j.posted_at,
        j.supplier,
        j.document_no,
        ROUND(SUM(l.debit - l.credit), 2) AS expense_gbp
    FROM journals AS j
    JOIN ledger_lines AS l
        ON j.journal_id = l.journal_id
    JOIN accounts AS a
        ON l.account_code = a.account_code
    WHERE a.category = 'Expense'
    GROUP BY j.journal_id, j.posted_at, j.supplier, j.document_no
)
SELECT
    supplier,
    document_no,
    expense_gbp,
    COUNT(*) AS matching_journals
FROM expense_journals
WHERE document_no IS NOT NULL
  AND TRIM(document_no) <> ''
  AND supplier IS NOT NULL
  AND TRIM(supplier) <> ''
  AND expense_gbp > 0
GROUP BY supplier, document_no, expense_gbp
HAVING COUNT(*) > 1
ORDER BY matching_journals DESC, expense_gbp DESC;

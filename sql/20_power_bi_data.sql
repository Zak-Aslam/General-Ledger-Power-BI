-- Ledger and budget exports for Power BI.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

-- 1. Ledger data: one row per ledger line
SELECT
    j.journal_id,
    j.posted_at,
    DATE(j.posted_at) AS transaction_date,
    DATE_FORMAT(j.posted_at, '%Y-%m') AS month,
    j.department,
    j.supplier,
    j.document_no,
    j.payment_method,
    j.entry_type,
    j.employee,
    j.approver,
    j.description,
    l.account_code,
    a.account_name,
    a.category,
    l.debit,
    l.credit,
    CASE
        WHEN a.category = 'Revenue'
            THEN l.credit - l.debit
        ELSE 0
    END AS revenue_gbp,
    CASE
        WHEN a.category = 'Expense'
            THEN l.debit - l.credit
        ELSE 0
    END AS expense_gbp
FROM ledger_lines AS l
JOIN journals AS j
    ON l.journal_id = j.journal_id
JOIN accounts AS a
    ON l.account_code = a.account_code
ORDER BY j.journal_id, l.account_code;

-- 2. Budget data: one row per month, department and account
SELECT
    b.month,
    b.department,
    b.account_code,
    a.account_name,
    a.category,
    b.budget_amount
FROM budgets AS b
JOIN accounts AS a
    ON b.account_code = a.account_code
ORDER BY b.month, b.department, b.account_code;

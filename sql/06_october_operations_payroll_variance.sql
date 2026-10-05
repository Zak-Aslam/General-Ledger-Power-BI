-- October Operations payroll against budget.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

SELECT
    b.month,
    b.department,
    a.account_name,
    b.budget_amount,
    ROUND(COALESCE(SUM(l.debit - l.credit), 0), 2) AS actual_gbp,
    ROUND(COALESCE(SUM(l.debit - l.credit), 0)
          - b.budget_amount, 2) AS variance_gbp
FROM budgets AS b
JOIN accounts AS a
    ON b.account_code = a.account_code
LEFT JOIN journals AS j
    ON j.department = b.department
   AND DATE_FORMAT(j.posted_at, '%Y-%m') = b.month
LEFT JOIN ledger_lines AS l
    ON l.journal_id = j.journal_id
   AND l.account_code = b.account_code
WHERE b.month = '2025-10'
  AND b.department = 'Operations'
  AND a.account_name = 'Payroll'
GROUP BY b.month, b.department, b.account_code, a.account_name, b.budget_amount;

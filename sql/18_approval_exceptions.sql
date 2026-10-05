-- Missing approver and possible self-approval checks.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

SELECT
    journal_id,
    posted_at,
    department,
    supplier,
    document_no,
    entry_type,
    employee,
    approver,
    CASE
        WHEN approver IS NULL OR TRIM(approver) = ''
            THEN 'Missing approver'
        WHEN TRIM(employee) = TRIM(approver)
            THEN 'Employee matches approver'
    END AS exception_reason
FROM journals
WHERE approver IS NULL
   OR TRIM(approver) = ''
   OR TRIM(employee) = TRIM(approver)
ORDER BY posted_at;

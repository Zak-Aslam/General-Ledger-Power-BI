-- Detail for the Bright Ads invoice under review.
-- Synthetic general ledger portfolio project.
USE general_ledger_project;

SELECT *
FROM journals
WHERE supplier = 'Bright Ads Ltd'
  AND document_no = 'INV-10-SA-777'
ORDER BY posted_at;

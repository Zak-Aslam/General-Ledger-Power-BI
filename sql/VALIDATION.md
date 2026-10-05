# Source data validation

The supplied setup script was inspected, then its table definitions and data were loaded into SQLite. MySQL date functions were emulated to run all 20 analysis queries. This was not a MySQL server execution.

## Dataset

| Table | Rows |
| --- | ---: |
| accounts | 10 |
| budgets | 336 |
| journals | 1,300 |
| ledger_lines | 2,600 |

All seven checks in query 19 returned zero issues, including orphan ledger references, invalid debit/credit values, journals without lines, unbalanced journals, missing date/department and duplicate budget keys.

## Reconciled results

| Measure | Source result |
| --- | ---: |
| Actual expenses | £2,058,685.69 |
| Expense budget | £1,908,544.56 |
| Expense variance | £150,141.13 over budget |
| Expense variance percentage | 7.87% |
| Actual revenue | £571,338.77 |
| Finance variance | £248,192.52 over budget |
| Operations variance | £121,396.23 over budget |
| Sales variance | £128,499.93 under budget |
| Technology variance | £90,947.69 under budget |
| Marketing variance | £179,932.32 over budget |
| October Operations payroll actual | £59,200.61 |
| October Operations payroll budget | £19,440.00 |
| October Operations payroll variance | £39,760.61 over budget |

Bright Ads Ltd invoice INV-10-SA-777 appears in Sales journals 1297 and 1298 on 14 and 15 October 2025. Each contains £2,499.99 of Marketing expense. This supports the potential duplicate finding; confirmation still requires supporting documentation.

## Required report wording correction

Finding 3 should refer to **October**, rather than September–October. £59,200.61 and £39,760.61 describe October only. September payroll is £22,271.29; combined September–October actual payroll is £81,471.90 against a £38,880.00 budget, a £42,591.90 overspend.

Use this text on the Key Findings page:

**3. Operations payroll exceeded budget in October**

Operations payroll expenses were **£59,200.61** against a **£19,440** budget for October: **£39,760.61 over budget**.

**Recommended action:** Check the payroll entries and staffing records for October, then confirm whether the budget needs updating.

After changing the text, save the PBIX and export a fresh PDF before replacing the files on GitHub.

# SQL query guide

These scripts analyse the synthetic general ledger used in the Power BI portfolio. They are written for MySQL 8.0 or later and select the `general_ledger_project` database.

## Requirements and run order

1. Execute `00_setup_database.sql` in MySQL Workbench to create and populate the synthetic database. **It drops and recreates the four project tables in `general_ledger_project`.**
2. Confirm that `accounts`, `journals`, `ledger_lines` and `budgets` are populated. The required columns appear in the scripts; the following table describes the expected joins.
3. Run `19_data_quality_checks.sql` first and investigate returned issues before relying on totals.
4. Run the analysis scripts individually in MySQL Workbench or another MySQL client. The numbering is a browsing order, not a dependency chain.
5. Run each SELECT in `20_power_bi_data.sql` separately to obtain the ledger and budget datasets for Power BI.

| Table | Expected keys and role |
| --- | --- |
| `accounts` | Unique `account_code`; account name and category |
| `journals` | Unique `journal_id`; posting date and journal metadata |
| `ledger_lines` | Journal and account references; debit and credit amounts |
| `budgets` | One row per month, department and account code; budget amount |

## Query index

| File | Purpose |
| --- | --- |
| [00_setup_database.sql](00_setup_database.sql) | Create tables and load the complete synthetic dataset |
| [01_expense_categories.sql](01_expense_categories.sql) | Net expense totals by account |
| [02_monthly_expenses.sql](02_monthly_expenses.sql) | Monthly net expenses |
| [03_september_october_categories.sql](03_september_october_categories.sql) | Expense categories in September and October 2025 |
| [04_payroll_by_department.sql](04_payroll_by_department.sql) | September and October payroll by department |
| [05_october_operations_payroll_entries.sql](05_october_operations_payroll_entries.sql) | October Operations payroll ledger detail |
| [06_october_operations_payroll_variance.sql](06_october_operations_payroll_variance.sql) | October Operations payroll against budget |
| [07_october_expense_variance.sql](07_october_expense_variance.sql) | October expense variance by department and account |
| [08_monthly_revenue.sql](08_monthly_revenue.sql) | Monthly net revenue |
| [09_monthly_revenue_and_expenses.sql](09_monthly_revenue_and_expenses.sql) | Monthly revenue and expenses |
| [10_supplier_concentration.sql](10_supplier_concentration.sql) | Supplier expense totals excluding payroll |
| [11_possible_duplicates.sql](11_possible_duplicates.sql) | Potential duplicate expense journals |
| [12_duplicate_detail.sql](12_duplicate_detail.sql) | Detail for the Bright Ads invoice under review |
| [13_unusual_posting_times.sql](13_unusual_posting_times.sql) | Weekend and out-of-hours postings |
| [14_posting_time_summary.sql](14_posting_time_summary.sql) | Posting time summary |
| [15_round_number_expenses.sql](15_round_number_expenses.sql) | Positive round-number expense journals |
| [16_large_expenses.sql](16_large_expenses.sql) | Large non-payroll expense journals |
| [17_department_spending_trends.sql](17_department_spending_trends.sql) | Monthly department spending |
| [18_approval_exceptions.sql](18_approval_exceptions.sql) | Missing approver and possible self-approval checks |
| [19_data_quality_checks.sql](19_data_quality_checks.sql) | Ledger and budget data quality checks |
| [20_power_bi_data.sql](20_power_bi_data.sql) | Ledger and budget exports for Power BI |

## Assumptions and scope

- Most summary queries cover all loaded dates. Queries 03–07 explicitly investigate September and/or October 2025. For comparisons with the annual report, use the same 2025 dataset and filter context.
- Expenses are net debits on expense accounts; revenue is net credits on revenue accounts. Credits and reversals therefore reduce the respective net totals.
- Queries 06 and 07 start from budget rows. They include budgeted combinations with no actual expense, but omit actual spending for combinations with no budget. Validate the uniqueness of budget keys with query 19.
- Query 10 ranks supplier spending excluding payroll; it does not calculate supplier percentage shares.
- Query 11 flags repeated supplier, document reference and positive net expense amount across journals. Blank references and suppliers are excluded. Matching is subject to database collation and is not a comprehensive duplicate detector.
- Query 12 inspects journal metadata for the Bright Ads invoice; query 11 provides the grouped expense amounts.
- Queries 13 and 14 assume business hours of 08:00–18:00 on weekdays, using the stored posting timestamps. No timezone conversion or holiday calendar is applied.
- Round-number amounts, large expenses, unusual times and approval flags require contextual review. They do not prove an error or breach.
- Query 19 reports counts per check. Its duplicate-budget count measures duplicate key combinations, not excess rows.
- Query 20 returns one ledger row per ledger line and one budget row per budget key. It does not create the Power BI model, relationships, dimensions or measures.

## Review changes

- Query 05 now uses debit minus credit and the Expense category, making payroll detail consistent with net expense summaries.
- Queries 06 and 07 now group by account code as well as account name, keeping separate accounts distinct even when names match.
- Query 11 excludes blank supplier/document references and non-positive expense totals to reduce irrelevant duplicate candidates.
- Every script explicitly selects the database. The double underscore in the original query 02 filename was standardised.

## Validation status

The dataset contains 10 accounts, 336 budget rows, 1,300 journals and 2,600 ledger lines. The repository includes data quality checks and queries supporting the report findings. See [VALIDATION.md](VALIDATION.md) for reconciled totals.

# 2025 General Ledger Review | SQL and Power BI

A portfolio project analysing a synthetic general ledger and expense budget using SQL and Power BI. The report compares actual expenses with budget, identifies expense drivers and presents transaction-level review findings.

## View the project

- [Preview the four-page report](Zak_Aslam_General_Ledger_Review.pdf)
- [Download the Power BI file](General_Ledger_Review.pbix)
- [Explore the SQL queries and run instructions](sql/README.md)

## Key findings

- Actual expenses were **£2.06M**, approximately **£150.14K (7.9%) over budget**.
- Finance had the largest departmental overspend at **£248.19K**. Marketing was the largest account-level contributor.
- Two Sales journal entries reference Bright Ads Ltd invoice **INV-10-SA-777**, each for **£2,499.99**. This is a potential duplicate requiring checks against the original invoice and any reversal.
- Operations payroll was **£39,760.61 over budget** in October.

The source setup script includes the complete synthetic dataset. The SQL queries support the report findings and allow the analysis to be reproduced in MySQL. See the [validation notes](sql/VALIDATION.md) for reconciled totals.

## Report pages

1. **Overview:** headline figures and monthly actual expenses versus budget.
2. **Expense Drivers:** variance by department and expense account.
3. **Transaction Review:** detail filtered by month, department and supplier, plus a bookmark for the potential duplicate.
4. **Key Findings:** conclusions and recommended checks.

## SQL analysis

The database setup script and 20 MySQL analysis scripts cover expense and revenue summaries, payroll analysis, supplier spending, potential duplicates, posting times, approval exceptions and data quality. The final script returns the ledger and budget datasets for Power BI. See the [query index](sql/README.md) for each script's purpose, assumptions and limitations.

## Recreate the analysis

1. Open [sql/00_setup_database.sql](sql/00_setup_database.sql) in MySQL Workbench and execute it. It creates the database and reloads its four project tables. **It drops and recreates any existing project tables in `general_ledger_project`.**
2. Run [sql/19_data_quality_checks.sql](sql/19_data_quality_checks.sql).
3. Run the analysis queries listed in the [SQL guide](sql/README.md).
4. Run each SELECT in [sql/20_power_bi_data.sql](sql/20_power_bi_data.sql) separately to obtain ledger and budget data for Power BI.

## Tools and interpretation

- **SQL:** MySQL 8.0 or later.
- **Reporting:** Power BI Desktop, with a static PDF for quick viewing.
- **Expense calculation:** debit minus credit on expense accounts.
- **Variance calculation:** actual expense minus budget; positive values mean over budget.

*All data is synthetic. Review flags are investigation leads, not confirmed accounting errors or policy breaches.*

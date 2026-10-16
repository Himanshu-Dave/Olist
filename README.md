# Olist E-Commerce Analytics

SQL Server + Python + Power BI analysis of the Olist Brazilian e-commerce dataset.
**Status: in progress.**

## Goal
Answer business questions about delivery performance, customer reviews,
categories, sellers and payments. The questions are in `docs/questions.md`.

## Data
- Source: Brazilian E-Commerce Public Dataset by Olist (Kaggle):
  https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce
- 9 tables of orders from 2016 to 2018. The raw CSVs are not in this repo.

## Data setup
- Imported the 9 CSVs into SQL Server with SSMS Import Flat File.
- Fixed column data types and matched each table's row count to its CSV.
- Final schema: `SQL/01_Schema.sql`.

## Data quality (`SQL/02_integrity_checks.sql`)
- No orphan rows across the 7 foreign key relationships checked.
- 775 orders have no items (mostly unavailable, then canceled). They are
  excluded from revenue analysis but kept for order status analysis.
- 768 orders have no review (mostly delivered), so review analysis only
  covers customers who responded.
- 1 order has no payment record.
- 610 products have no category, and 2 categories have no English
  translation (`pc_gamer` and `portateis_cozinha_e_preparadores_de_alimentos`).
- `review_id` is not unique. `(review_id, order_id)` is. Reviews will be reduced
  to one row per order before joining.
- `customer_id` is one per order. `customer_unique_id` identifies the person:
  99441 customer rows, 99441 distinct customer_ids (every row have different customer id), 96096 distinct people,
  2997 people ordered more than once.

## Tools
SQL Server (SSMS), Python (pandas) in VS Code, Git/GitHub. Power BI planned.

## Repo structure
- `SQL/`: schema, integrity checks, views and analysis queries
- `docs/`: business questions
- `*.ipynb`: pandas profiling, one notebook per table

## Findings
Coming soon.
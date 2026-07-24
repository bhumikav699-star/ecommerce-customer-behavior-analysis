# 🛒 E-Commerce Customer Behavior & Sales Analysis

End-to-end analysis of **17,049 transactions from 5,000 customers** on a Turkish e-commerce platform (Jan 2023 – Mar 2024) — covering data cleaning in Python, exploratory and advanced analysis in SQL, and an interactive Power BI dashboard.

![Dashboard Preview](dashboard/dashboard-preview.gif)

## 📌 Project Overview

This project walks through a full analytics pipeline on raw e-commerce order data:

1. **Clean & prepare** the raw dataset in Python (`pandas`) — validate transaction math, engineer `Order_Month` and `Age_Group` fields, export an analysis-ready CSV
2. **Analyze** the cleaned data in SQL — KPIs, product/city/customer breakdowns, and advanced window-function queries (ranking, running totals, segmentation)
3. **Visualize** the results in an interactive Power BI dashboard for stakeholders to explore by date, category, city, and payment method

## 📊 Key Insights

- **17,049 orders** generating **21.78M** in total revenue, at a **1.28K** average order value
- **Returning customers drive the business**: they account for 88% of all orders (15K vs. 2K from new customers) — strong retention, but a signal to invest more in new customer acquisition
- **Credit Card is the dominant payment method**, covering roughly 42% of revenue, ahead of debit card, digital wallet, bank transfer, and cash on delivery
- **Istanbul leads all cities** in revenue, followed by Ankara and Izmir — consistent with their share of Turkey's e-commerce market
- **Electronics, Home & Garden, and Sports** are the top revenue-generating product categories
- Order math checks out perfectly: **0 discrepancies** found between `Total_Amount` and `Unit_Price × Quantity − Discount_Amount` across all 17K+ rows

## 🛠️ Tech Stack

| Stage | Tool |
|---|---|
| Data cleaning & feature engineering | Python (pandas, numpy) |
| Data storage & querying | MySQL |
| Analysis (KPIs, rankings, segmentation) | SQL (CTEs, window functions: `RANK`, `ROW_NUMBER`, `LAG`/`LEAD`, `NTILE`) |
| Dashboard & visualization | Power BI |

## 📁 Repository Structure

```
ecommerce-customer-behavior-analysis/
├── README.md
├── data/
│   ├── ecommerce_customer_behavior_dataset_v2.csv   # raw dataset
│   └── ecommerce_cleaned_csv.csv                    # cleaned, analysis-ready
├── notebooks/
│   └── ecommerce_py.ipynb                           # data cleaning & feature engineering
├── sql/
│   └── ecommerce_sqlfile.sql                        # KPI + advanced analytical queries
├── dashboard/
│   └── dashboard-preview.gif                        # Power BI dashboard walkthrough
└── docs/
    └── DATASET_README.md                            # full data dictionary
```

## 🐍 Data Cleaning (Python)

`notebooks/ecommerce_py.ipynb` handles:
- Loading and inspecting the raw dataset (17,049 rows × 18 columns)
- Validating that every transaction's `Total_Amount` reconciles with unit price, quantity, and discount
- Engineering `Order_Month` (for time-series analysis) and `Age_Group` (18-25, 26-35, 36-45, 46-55, 56+)
- Exporting the cleaned dataset used downstream in SQL and Power BI

> Open directly in Colab:
> `https://colab.research.google.com/github/YOUR_USERNAME/ecommerce-customer-behavior-analysis/blob/main/notebooks/ecommerce_py.ipynb`

## 🗃️ SQL Analysis

`sql/ecommerce_sqlfile.sql` is organized into sections:
- **Basic KPIs** — total orders, revenue, AOV, unique customers, average rating
- **Product / City / Customer / Payment analysis** — revenue and order breakdowns by segment
- **Advanced queries** — customer ranking (`RANK`, `ROW_NUMBER`), running revenue totals, revenue contribution %, customer segmentation (Premium/Gold/Silver/Regular), top category and top customer per city, previous/next order amount (`LAG`/`LEAD`), and customer spending quartiles (`NTILE`)

## 📈 Dashboard

Built in Power BI, the dashboard lets users filter by date range, product category, city, and payment method, with live-updating visuals for revenue trends, customer retention, geographic performance, and top spenders.

## 📚 Dataset

Source: *E-Commerce Customer Behavior and Sales Dataset*, originally sourced from Kaggle, released under **CC0: Public Domain**. Full column-level documentation is in [`docs/DATASET_README.md`](docs/DATASET_README.md).

## 🔗 Connect

If you found this useful or have feedback, feel free to connect or open an issue!

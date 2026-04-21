# 🏦 Lending Club Banking Analytics
### End-to-End Data Analytics Portfolio Project

![Python](https://img.shields.io/badge/Python-3.11-blue)
![SQL](https://img.shields.io/badge/SQL-SQLite-orange)
![Excel](https://img.shields.io/badge/Excel-Dashboard-green)
![PowerBI](https://img.shields.io/badge/PowerBI-Dashboard-yellow)
![Tableau](https://img.shields.io/badge/Tableau-Dashboard-lightblue)

---

## 📌 Project Summary

Built a full-stack banking analytics pipeline processing **2.26 million real-world loan records** from Lending Club (2007–2018). The project covers every stage of the data analytics lifecycle — from raw data ingestion and cleaning to SQL analysis, Excel dashboards, and interactive Power BI and Tableau visualizations.

**Dataset:** Lending Club 2007–2018 | 2,260,701 raw records | 151 columns  
**Final Clean Dataset:** 765,050 records | 26 columns  
**Tools:** Python | SQL | Excel | Power BI | Tableau

---

## 🎯 Business Questions Answered

1. What percentage of loans defaulted and which segments carry the most risk?
2. Which loan grades, purposes and borrower profiles predict default?
3. How has lending volume grown over time?
4. Which states have the highest loan concentration?
5. Does debt-to-income ratio and income level predict default behavior?

---

## 🔑 Key Findings

- **Grade risk differential:** Grade G loans defaulted at **28.76%** — 24x higher than Grade A at 1.18% — directly informing credit approval and risk-adjusted pricing strategy
- **Purpose risk signal:** **53% of all loans** were for debt consolidation — borrowers using new debt to pay old debt represent a compounding risk underweighted by standard grade scoring
- **Geographic insight:** California led loan volume at 101,385 loans but carried a 5.76% default rate while Illinois (4.18%) and Washington (4.06%) showed significantly better repayment behavior

---
## 📁 Project Structure

```
banking-analytics/
│
├── data/
│   ├── raw/                          ← Original dataset + working file
│   ├── cleaned/                      ← Excel Power Query output
│   └── processed/                    ← Final Python-ready CSV + SQLite DB
│
├── sql/
│   ├── 01_customer_analysis.sql      ← Loan volume and borrower profiles
│   ├── 02_loan_default_queries.sql   ← Default patterns and risk analysis
│   └── 03_risk_segmentation.sql      ← Borrower risk scoring
│
├── notebooks/
│   ├── 01_load_and_filter.ipynb      ← Data ingestion and filtering
│   ├── 02_data_cleaning.ipynb        ← Full cleaning pipeline
│   ├── 03_EDA.ipynb                  ← Exploratory data analysis
│   └── 04_sql_setup.ipynb            ← SQLite database setup
│
├── excel/
│   └── banking_dashboard.xlsx        ← 6-chart interactive dashboard
│
├── powerbi/
│   └── banking_dashboard.pbix        ← 2-page interactive dashboard
│
├── tableau/
│   └── banking_dashboard.twbx        ← 5-sheet interactive dashboard
│
├── outputs/
│   └── charts/                       ← 9 exported EDA visualizations
│
├── README.md
└── requirements.txt
```
---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|---|---|
| **Python (Pandas, Matplotlib, Seaborn)** | Data ingestion, cleaning, EDA |
| **SQL (SQLite)** | Risk segmentation, default analysis |
| **Excel** | Interactive dashboard for business users |
| **Power BI** | Executive dashboard with KPI cards and slicers |
| **Tableau** | Interactive dashboard with geographic map |

---

## 🐍 Step 1 — Data Ingestion & Cleaning

- Loaded 1.55GB CSV using chunked processing (100k rows at a time)
- Filtered 2.26M records to 938,821 rows (2017–2018)
- Resolved **8 data quality issues:**
  - Mixed date formats (`%b-%Y` and `ISO8601`)
  - Percentage symbols stored as strings in `int_rate`
  - Text embedded in numeric fields (`emp_length`)
  - 43 columns exceeding 50% null threshold dropped
  - Inconsistent categorical labels in `loan_status`
  - Outliers removed using IQR method
  - Whitespace in text columns
  - Wrong data types across multiple columns
- Reduced from **151 columns → 26** business-relevant features
- Final clean dataset: **765,050 records**

---

## 🗄️ Step 2 — SQL Analysis

Three SQL files covering 20+ queries:

**01_customer_analysis.sql**
- Loan volume by year, grade, purpose, state
- Borrower profiles by home ownership and employment length

**02_loan_default_queries.sql**
- Default rate by grade, purpose, home ownership, term
- High risk loan flagging
- Estimated financial loss per grade

**03_risk_segmentation.sql**
- 3-tier risk scoring (Low/Medium/High)
- DTI band analysis
- Income segmentation
- Combined risk score model

---

## 📊 Step 3 — Excel Dashboard

6-chart interactive dashboard covering:
- Loan status breakdown
- Default rate by loan grade
- Loan purpose distribution
- Monthly volume trend
- Risk segment comparison
- Top 10 states by loan volume

---

## 📈 Step 4 — Power BI Dashboard

**Page 1 — Executive Overview**
- 4 KPI cards: 765,050 total loans | 13.06% avg rate | $13,426 avg loan | 5.33% default rate
- Loan status donut chart
- Default rate by grade
- Loans by purpose
- Monthly trend line
- Top 10 states
- 3 interactive slicers (loan status, grade, purpose)

**Page 2 — Risk Analysis**
- Default rate by DTI band
- Default rate by home ownership
- Default rate by income band
- Average loan amount by grade

---

## 📉 Step 5 — Tableau Dashboard

5-sheet interactive dashboard:
- Loan status bar chart
- Default rate by grade
- Loans by purpose
- Monthly trend line
- US geographic map — loan volume by state

---

## 🚀 How To Run This Project

### Prerequisites
```bash
pip install -r requirements.txt
```

### Run Notebooks In Order
```bash
1. notebooks/01_load_and_filter.ipynb
2. notebooks/02_data_cleaning.ipynb
3. notebooks/03_EDA.ipynb
4. notebooks/04_sql_setup.ipynb
```

### Data
Download the dataset from:
`kaggle.com/datasets/wordsforthewise/lending-club`

Place `accepted_2007_to_2018Q4.csv` in `data/raw/`

---

## 👤 Author

**Vakula Annapareddy**
Data Analyst | Toronto, Ontario

- 🔗 LinkedIn: [linkedin.com/in/vakula-annapareddy](https://www.linkedin.com/in/vakula-annapareddy)
- 💻 GitHub: [github.com/AnnapareddyVakula](https://github.com/AnnapareddyVakula)
- 📧 Email: vakulaa2k@gmail.com
---

## 📄 License

This project is for portfolio and educational purposes.  
Dataset: Lending Club via Kaggle (CC0 Public Domain)
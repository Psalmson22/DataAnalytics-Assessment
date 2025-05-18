# DataAnalytics-Assessment
Cowrywise Data Analyst Assessment Repo

# SQL Analytics Queries
This repository contains four SQL query solutions addressing common business intelligence and operations use cases for a financial institution. 
Each query is designed to extract valuable insights from users and transaction data, aiding marketing, operations, and product teams in making data-driven decisions.

## 🔧 Data Sources
These queries utilize data from the following main tables:
- `users_customuser` – Contains customer details such as ID, name, and signup date.
- `plans_plan` – Represents savings or investment plans owned by users.
- `savings_savingsaccount` – Stores transactions made under various financial plans.

## 📊 Queries

### 1. Cross-Sell Opportunity: Customers with Both Savings & Investments
Identifies users who have **at least one funded savings plan and one funded investment plan**, ordered by total confirmed deposits.

**Key Metrics:**
- Number of savings plans
- Number of investment plans
- Total deposits

📌 Helps marketing identify users with cross-sell potential.

### 2. Transaction Frequency Analysis

Calculates the **average number of transactions per customer per month**, and segments customers into frequency categories:

- **High Frequency**: ≥10 transactions/month  
- **Medium Frequency**: 3–9 transactions/month  
- **Low Frequency**: ≤2 transactions/month

**Output:**
- Frequency category
- Number of customers in each category
- Average monthly transactions per category

📌 Supports customer segmentation and engagement strategies.

### 3. Active Accounts with Recent Transactions

Finds **active savings or investment plans** that have had **at least one transaction in the past 365 days**.

**Metrics:**
- Last transaction date
- Days since last transaction

📌 Enables the ops team to monitor account engagement and prevent churn.

### 4. Customer Lifetime Value (CLV) Estimation

Estimates **CLV** for each customer based on account tenure and transaction volume.

**Assumptions:**
- Profit per transaction = 0.1% of transaction value
- CLV = (total_transactions / tenure_months) * 12 * avg_profit_per_transaction

**Metrics:**
- Tenure in months
- Total number of transactions
- Estimated CLV (ranked descending)

📌 Helps prioritize high-value customers for retention and rewards.

## 💡 Notes
- All queries use `MySQL` syntax and standard SQL functions.
- Modify schema/table prefixes (e.g., `adashi_staging`) as necessary for your environment.
- Queries include basic data validation using `NULLIF`, `COALESCE`, `DATE` etc

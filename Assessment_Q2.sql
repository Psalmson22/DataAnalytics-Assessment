WITH monthly_transactions AS (
    SELECT 
        users.id AS customer_id,
        YEAR(savings.transaction_date) AS txn_year,
        MONTH(savings.transaction_date) AS txn_month,
        COUNT(*) AS monthly_txn_count
    FROM 
        adashi_staging.users_customuser AS users
    INNER JOIN 
        adashi_staging.savings_savingsaccount AS savings ON users.id = savings.owner_id
    GROUP BY 
        users.id, YEAR(savings.transaction_date), MONTH(savings.transaction_date)
),
avg_txn_per_customer AS (
    SELECT 
        customer_id,
        AVG(monthly_txn_count) AS avg_txns_per_month
    FROM 
        monthly_transactions
    GROUP BY 
        customer_id
),
categorized_customers AS (
    SELECT 
        CASE 
            WHEN avg_txns_per_month >= 10 THEN 'High Frequency'
            WHEN avg_txns_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_txns_per_month
    FROM 
        avg_txn_per_customer
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txns_per_month), 1) AS avg_transactions_per_month
FROM 
    categorized_customers
GROUP BY 
    frequency_category
ORDER BY 
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');

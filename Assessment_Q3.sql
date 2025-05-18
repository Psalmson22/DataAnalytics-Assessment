SELECT 
    plan.id AS plan_id,
    plan.owner_id,
    CASE 
        WHEN plan.is_regular_savings = 1 THEN 'Savings'
        WHEN plan.is_a_fund = 1 THEN 'Investment'
        ELSE 'Unknown'
    END AS type,
    DATE(MAX(savings.transaction_date)) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(savings.transaction_date)) AS inactivity_days
FROM 
    adashi_staging.plans_plan AS plan
LEFT JOIN 
    adashi_staging.savings_savingsaccount AS savings
    ON plan.id = savings.plan_id
WHERE 
    (plan.is_regular_savings = 1 OR plan.is_a_fund = 1)
GROUP BY 
    plan.id, plan.owner_id, type	
HAVING 
    last_transaction_date IS NOT NULL 
    AND DATEDIFF(CURDATE(), last_transaction_date) <= 365
ORDER BY 
    inactivity_days DESC;	
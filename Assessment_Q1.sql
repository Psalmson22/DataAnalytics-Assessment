SELECT 
    users.id AS owner_id,
    CONCAT(users.first_name, ' ', users.last_name) AS name,
    COUNT(DISTINCT CASE WHEN plan.is_regular_savings = 1 THEN plan.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN plan.is_a_fund = 1 THEN plan.id END) AS investment_count,
    ROUND(SUM(COALESCE(savings.confirmed_amount, 0)),2) AS total_deposits
FROM 
    adashi_staging.users_customuser AS users
LEFT JOIN 
    adashi_staging.plans_plan AS plan ON plan.owner_id = users.id
LEFT JOIN 
    adashi_staging.savings_savingsaccount AS savings ON plan.id = savings.plan_id
WHERE 
    plan.is_regular_savings = 1 OR plan.is_a_fund = 1
GROUP BY 
    users.id, users.first_name, users.last_name
HAVING 
    savings_count >= 1 AND investment_count >= 1
ORDER BY 
    total_deposits DESC;

SELECT 
    users.id AS customer_id,
    CONCAT(users.first_name, ' ', users.last_name) AS name,
    TIMESTAMPDIFF(MONTH, users.date_joined, CURDATE()) AS tenure_months,
    COUNT(savings.id) AS total_transactions,
    ROUND((
        (COUNT(savings.id) / NULLIF(TIMESTAMPDIFF(MONTH, users.date_joined, CURDATE()), 0)) 
        * 12 
        * (0.001 * AVG(savings.confirmed_amount))
    ), 2) AS estimated_clv
FROM 
    adashi_staging.users_customuser AS users
JOIN 
    adashi_staging.savings_savingsaccount AS savings
    ON users.id = savings.owner_id
GROUP BY 
    users.id, name
ORDER BY 
    estimated_clv DESC;
USE adashi_staging;

-- QUERY OPTIMIZATION: 
CREATE INDEX index_customer_id ON users_customuser(id);
CREATE INDEX index_plans_customer_id ON plans_plan(owner_id);
CREATE INDEX index_savings_customer_id ON savings_savingsaccount(owner_id);
CREATE INDEX index_saving_and_investment ON plans_plan(is_regular_savings, is_a_fund);
CREATE INDEX index_customer_plans ON plans_plan(id);
CREATE INDEX index_transaction_account_date ON savings_savingsaccount(transaction_status, transaction_date DESC);



-- Questiion 1: High-Value Customers with Multiple Products 
-- id is primary key for users_customer and owner_id is foreign key in the savings and plans table. is_regular savings and is_a_fund are binary values, its easier to filter out the 0 to better performance especially in larger database
-- EXPLAIN
SELECT ucu.id, concat(ucu.first_name," ",ucu.last_name) full_name, sum(psp.is_regular_savings) saving_count, sum(psp.is_a_fund) investment_count, ROUND(COALESCE(sum(ssa.amount),0),2) total_deposit
FROM users_customuser ucu 
LEFT JOIN plans_plan psp
	ON ucu.id = psp.owner_id
LEFT JOIN savings_savingsaccount ssa    
    ON ucu.id = ssa.owner_id
GROUP BY ucu.id
HAVING saving_count > 0 AND investment_count > 0 
ORDER BY total_deposit DESC
;    

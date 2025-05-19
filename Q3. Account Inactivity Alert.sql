USE adashi_staging;

-- QUERY OPTIMIZATION: 
CREATE INDEX index_customer_id ON users_customuser(id);
CREATE INDEX index_plans_customer_id ON plans_plan(owner_id);
CREATE INDEX index_savings_customer_id ON savings_savingsaccount(owner_id);
CREATE INDEX index_saving_and_investment ON plans_plan(is_regular_savings, is_a_fund);
CREATE INDEX index_customer_plans ON plans_plan(id);
CREATE INDEX index_transaction_account_date ON savings_savingsaccount(transaction_status, transaction_date DESC);


-- Question 3. Account Inactivity Alert
-- EXPLAIN
SELECT psp.id plan_id, psp.owner_id, 'Savings' Type, MAX(ssa.transaction_date) last_transaction_date, DATEDIFF(CURRENT_DATE,MAX(ssa.transaction_date)) last_active
FROM plans_plan psp
LEFT JOIN savings_savingsaccount ssa
	ON psp.id = ssa.plan_id
WHERE psp.is_a_fund = 1 OR psp.is_regular_savings = 1
GROUP BY psp.id, psp.owner_id
HAVING last_transaction_date IS NULL OR last_active > 365   
ORDER BY last_active DESC
;
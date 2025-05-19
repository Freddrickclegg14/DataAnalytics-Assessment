USE adashi_staging;

-- QUERY OPTIMIZATION: 
CREATE INDEX index_customer_id ON users_customuser(id);
CREATE INDEX index_plans_customer_id ON plans_plan(owner_id);
CREATE INDEX index_savings_customer_id ON savings_savingsaccount(owner_id);
CREATE INDEX index_saving_and_investment ON plans_plan(is_regular_savings, is_a_fund);
CREATE INDEX index_customer_plans ON plans_plan(id);
CREATE INDEX index_transaction_account_date ON savings_savingsaccount(transaction_status, transaction_date DESC);


-- Question 4. Customer Lifetime Value (CLV) Estimation
-- 
WITH account_tenure AS (
SELECT ucu.id customer_id, concat(first_name," ",last_name) full_name, ucu.date_joined, nullif(timestampdiff(month, ucu.date_joined, current_date()),0) Account_Tenure_Months , date_format(max(ssa.transaction_date),'%Y-%m') "recent_trans_period",
count(ssa.transaction_status) total_transaction, (count(ssa.transaction_status)/nullif(timestampdiff(month, ucu.date_joined, current_date()),0))*12*(0.001 * avg(ssa.amount)) estimated_clv
FROM users_customuser ucu
LEFT JOIN savings_savingsaccount ssa
	ON ucu.id = ssa.owner_id
GROUP BY ucu.id
)
SELECT customer_id, full_name, Account_Tenure_Months, total_transaction, estimated_clv
FROM account_tenure
WHERE Account_Tenure_Months > 1 -- excluding accounts which are 1 month old, because we want to give them time to build their account. 
-- if you want to see the performance of accounts with just one month. remove the comment from the next line (delete "--" and add the "--" to the first where clause) 
-- WHERE Account_Tenure_Months => 1
ORDER BY estimated_clv DESC
;
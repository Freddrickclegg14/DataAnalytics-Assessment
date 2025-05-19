USE adashi_staging;

-- QUERY OPTIMIZATION: 
CREATE INDEX index_customer_id ON users_customuser(id);
CREATE INDEX index_plans_customer_id ON plans_plan(owner_id);
CREATE INDEX index_savings_customer_id ON savings_savingsaccount(owner_id);
CREATE INDEX index_saving_and_investment ON plans_plan(is_regular_savings, is_a_fund);
CREATE INDEX index_customer_plans ON plans_plan(id);
CREATE INDEX index_transaction_account_date ON savings_savingsaccount(transaction_status, transaction_date DESC);
    


-- QUESTION 2. Transaction Frequency Analysis
-- Note: Depending on what you consider Transaction, this values can change. For now, we will focus on all transactions (all rows in the table). However, transaction_status "success" and "successful" should be the focus , as this shows intent from the Customer/User 
-- Depending on frequency of Need, Monthly_Transaction can be changed from a CTE to MATERIALIZED VIEW to aid with query reusefulness
-- EXPLAIN
WITH monthly_transaction AS ( 
	SELECT ucu.id customer_id, date_format(ssa.transaction_date,'%Y-%m') "year-month",count(ssa.transaction_status) transaction_count
    FROM users_customuser ucu
    LEFT JOIN savings_savingsaccount ssa
		ON ucu.id = ssa.owner_id
   -- if you choose to focus on only successful transactions, as this is a better indicator of customer retention, uncomment the line below (remove "--")
   -- WHERE (ssa.transaction_status = "success" OR ssa.transaction_status = "successful" )
    GROUP BY ucu.id, date_format(ssa.transaction_date,'%Y-%m') 
),
Avg_customer_transaction AS (
SELECT customer_id, avg(transaction_count) avg_trans_per_month
FROM monthly_transaction 
GROUP BY customer_id
)
SELECT 
CASE 
	WHEN avg_trans_per_month >= 10 THEN 'High Frequency'
    WHEN avg_trans_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
    ELSE 'Low Frequency'
END frequency_category, count(customer_id) customer_count, ROUND(avg(avg_trans_per_month),1) avg_transactions_per_month
FROM Avg_customer_transaction
GROUP BY frequency_category
ORDER BY customer_count
;
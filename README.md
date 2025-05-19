# DataAnalytics-Assessment
Question 1: High-Value Customers with Multiple Products 
Q1 looks into how well different products (mainly Investment and Savings) is being received by our customers. The aim of the query is to target our premium users. 
The benefit of this Analysis
	Increase transactions from this demography by offering premium service to them.
 	Reduce transaction fee for this demography, thereby increasing customer retention. 

 Approach: There are two approach that i could use in this question, one was creating CTE and using join to solve the issue, the other was just running my query directly. The reason i chose running the query without CTE/VIEW/MATERIALIZED VIEW was because I assumed this task can be considered ad-hoc and depending on which "plan" amongs others you choose, you will want to see how well this high value customers are behaving when considering other plans
	
Challenges: Using LEFT JOIN to join 2 tables to the users_customuser may create cartesian products. Still used the LEFT JOIN because i needed to capture all rows in the 2 tables 
Had to consider how the NULL values will react in my query. Used COALESCE to eliminate that issue.


Question 2: Transaction Frequency Analysis
Q2 looks into how well our product is being received

The benefit of this Analysis
	Good Indicator of Application Usage rate/Customer Behaviour/Customer Retention.
 	Building a good cohort for each category of Transaction. 

 Approach: Chose to use a CTE in this case, as this was more of a deepdive into our transaction bucket and how well we are doing. The Higher the number of "High Frequency", the better indicator of how well our Application/Service is doing. 
	
Challenges: Transaction definition, in the question; all transactions are considered valid even though we have failed transactions and charge backs which shouldnt be counted. In case of charge backs, its the fee from the transactions so it should not be counted as the reach transaction is the Withdrawal. 

I chose to highlight the posibility of just using the status "success" or "successful" has the only indicator of a transaction. 


Question 3: Account Inactivity Alert
Q3 looks at how much customer we are losing.

The benefit of this Analysis
	Good Indicator of Churn Rate/Market Availability. 

 Approach: Chose to use a CTE in this case, as the MAX function, could cause the query performance to reduce especially in large data and with either a subquery. 	
Challenges: Putting into consideration NULL values


Question 4: Customer Lifetime Value (CLV) Estimation
Q4 looks at Customer Lifetime value.

The benefit of this Analysis
	How much value Customers are getting from our services per month per transaction. 
	
Challenges: Putting into consideration NULL values

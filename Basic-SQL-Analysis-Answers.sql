create database PROJECT_RDA
Select * from customer
select * from prod_cat_info
select * from transactions
----------------------------------------------------------------------------------------------------------
--------------------------------DATA PREPARATION AND UNDERSTANDING----------------------------------------
--Q1.)
select * from
(select 'customer' as Table_name, count(*) as Number_of_records from customer union all
 select 'Prod_cat_info' as Table_name, count(*) as Number_of_records from prod_cat_info union all
 select 'Transactions' as Table_name, count(*) as Number_of_records from transactions) TBL

--Q2.)
select count(total_amt) as returned_transactions from Transactions
where total_amt like '-%'

--Q3.)
/* Ans-3.) while importing the data I already changed the format into DATE data type with the help of 
   Advanced option - selecting column - changing data type to DATE. */

--Q4.)
select datediff(year,min(tran_date),max(tran_date)) as No_of_years,
datediff(month,min(tran_date),max(tran_date)) as No_of_months,
datediff(day,min(tran_date),max(tran_date)) as No_of_days from Transactions

--Q5.)
select prod_cat from prod_cat_info
where prod_subcat = 'DIY'

----------------------------------------------------------------------------------------------------------
----------------------------------------------DATA ANALYSIS-----------------------------------------------

--Q1.)
select top 1 store_type as Diff_channels, count(Store_type) as No_of_transactions from Transactions
group by store_type 
order by No_of_transactions DESC

--Q2.)
select Gender, count(Gender) as Total_customer from Customer
where gender in ('m', 'f')
group by Gender

--Q3.)
select top 1 city_code, count(city_code) as Total_customer from Customer
group by city_code
order by Total_customer DESC

--Q4.)
select prod_cat, count(prod_subcat) as No_of_subcategory from prod_cat_info
where prod_cat = 'Books'
group by prod_cat

--Q5.)
select top 1 transaction_id,cust_id, tran_date, prod_cat_code, prod_subcat_code, max(qty) as Total_Qty from Transactions
group by transaction_id,cust_id, tran_date, prod_cat_code, prod_subcat_code
order by Total_Qty Desc

--Q6.)
select prod_cat, sum(T2.total_amt) as total_revenue_generated from prod_cat_info as T1
inner join Transactions as T2
on T1.prod_cat_code = T2.prod_cat_code
and T1.prod_sub_cat_code = T2.prod_subcat_code
where prod_cat in ('Electronics', 'Books')
group by prod_cat

--Q7.)
select cust_id, count(transaction_id) as No_of_transactions from Transactions
where total_amt > 0
group by cust_id
having count(transaction_id) > 10

--Q8.)
select T2.Store_type,sum(T2.total_amt) as combined_revenue from prod_cat_info as T1
inner join Transactions as T2
on T1.prod_cat_code = T2.prod_cat_code
and T1.prod_sub_cat_code = T2.prod_subcat_code
where prod_cat in ('Electronics','clothing') 
and Store_type in ('flagship store')
group by T2.Store_type

--Q9.)
select prod_subcat, sum(T2.total_amt) as total_revenue from prod_cat_info as T1 
inner join Transactions as T2
on T1.prod_cat_code = T2.prod_cat_code
and T1.prod_sub_cat_code = T2.prod_subcat_code
inner join Customer as T3 
on T3.customer_Id = T2.cust_id
where prod_cat = 'Electronics' and Gender = 'M' 
group by prod_subcat

--Q10.)
SELECT  TOP 5 PROD_SUBCAT,
(SUM(CASE WHEN total_amt > 0  THEN total_amt  end)/SUM(total_amt))*100 as Sales_percent,
abs (SUM( CASE WHEN total_amt < 0 THEN total_amt  end)/SUM(total_amt))*100 as  Return_percent
FROM prod_cat_info INNER JOIN Transactions 
ON prod_cat_info.prod_sub_cat_code =Transactions.prod_subcat_code
AND prod_cat_info.prod_cat_code=Transactions.prod_cat_code
GROUP BY prod_subcat
ORDER BY Sales_percent DESC

--Q11.)
select sum(total_amt-Tax) as total_sales from Customer as T1 inner join Transactions as T2
on T1.customer_Id = T2.cust_id
where DOB between DATEADD(year,-35,(select max(tran_date) from Transactions)) and DATEADD(year,-25,(select max(tran_date) from Transactions)) and
tran_date >= (select dateadd(day,-30,max(tran_date)) from Transactions)

--Q12.)
select top 1 prod_cat, sum(total_amt) as total_return from prod_cat_info as T1 inner join Transactions as T2 
on T1.prod_cat_code = T2.prod_cat_code and
T1.prod_sub_cat_code = T2.prod_subcat_code
where total_amt like '-%' and tran_date > (select dateadd(month,-3,max(tran_date)) from Transactions) 
group by prod_cat
order by total_return asc

--Q13.)
select top 1 store_type, count(qty) as prod_qty, sum(total_amt) as total_sales from Transactions
group by store_type
order by prod_qty desc

--Q14.)
select prod_cat, avg(total_amt) as avg_sales from prod_cat_info as T1
inner join Transactions as T2
on T1.prod_cat_code = T2.prod_cat_code
and T1.prod_sub_cat_code = T2.prod_subcat_code
group by prod_cat
having avg(total_amt) > (select avg(total_amt) from Transactions)

--Q15.)
select * from (select top 5 prod_cat, count(Qty) as Quantity from prod_cat_info as T1
inner join Transactions as T2
on T1.prod_cat_code = T2.prod_cat_code
and T1.prod_sub_cat_code = T2.prod_subcat_code
group by prod_cat
order by Quantity desc) as x inner join (select prod_cat,prod_subcat,sum(total_amt) as total_amt, avg(total_amt) as Avg_amount from prod_cat_info as T1
inner join Transactions as T2
on T1.prod_cat_code = T2.prod_cat_code
and T1.prod_sub_cat_code = T2.prod_subcat_code
group by prod_cat, prod_subcat) as y
on x.prod_cat = y.prod_cat














 


























































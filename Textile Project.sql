create database Project1;

use project1;


/*1. What was the total quantity sold for all products?*/
select product_name,
sum(qty) as totalqty from sales s inner join product_details pd 
on s.prod_id=pd.product_id
group by product_name
order by totalqty asc;

/*2. What is the total generated revenue for all products before
discounts?*/
select sum(price*qty) as Revenue from sales;

/*3. What was the total discount amount for all products?*/
select sum(price*discount*qty) as DiscountAmt from sales;

/*4. How many unique transactions were there?*/

select count(distinct txn_id) as unqtransactions from sales;

/*5. What are the average unique products purchased in each
transaction?*/
with cte_trans_prod AS (
	 select txn_id,count(distinct prod_id) as unqproduct from sales
group by txn_id
)
select avg(unqproduct) as avg_unq_prod from cte_trans_prod;

/*6. What is the average discount value per transaction?*/
with cte_trans_disc as(
select txn_id,sum(price*qty*discount) as totaldisc from sales group by txn_id)
select avg(totaldisc) as avg_unq_prod from cte_trans_disc;

/*7. What is the average revenue for member transactions and non-
member transactions?*/
with cte_member_revenue as(
select `member`,txn_id,sum(price*qty) as revenue from sales group by txn_id,member)
select member,avg(revenue) from cte_member_revenue group by member;
 
/*8. What are the top 3 products by total revenue before discount?*/
select pd.product_name,sum(s.price*s.qty) as total_revenue 
from sales s inner join product_details as pd
on s.prod_id=pd.product_id
group by pd.product_name
order by total_revenue desc
limit 3;

/*9. What are the total quantity, revenue and discount for each
segment?*/
select segment_name,sum(s.qty) as totalqty,sum(s.price*s.qty) as revenue ,sum(s.qty*s.price*s.discount) as discount
from sales s inner join product_details as pd
on s.prod_id=pd.product_id
group by segment_name
order by revenue desc;

/*10. What is the top selling product for each segment?*/
select pd.segment_name,pd.segment_id,sum(s.qty) as product_qty,product_name 
from product_details pd inner join sales s on s.prod_id=pd.product_id
group by  pd.segment_name,pd.segment_id,pd.product_name
order by product_qty desc
;

/*11. What are the total quantity, revenue and discount for each
category?*/
select pd.category_name,sum(s.price*s.qty) as revenue,sum(s.qty) as totalqty, sum(s.qty*s.price*s.discount) as discount
from sales s inner join product_details as pd
on s.prod_id=pd.product_id
group by pd.category_name
order by revenue desc;

/*12. What is the top selling product for each category*/

select pd.category_id,pd.category_name,pd.product_id,pd.product_name ,sum(s.qty) as product_qty
from sales s inner join product_details as pd
on s.prod_id=pd.product_id
group by pd.category_id
order by product.qty desc;




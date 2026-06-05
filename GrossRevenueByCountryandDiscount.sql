with cte as (select 
a.product_id,
a.category,
a.brand,
a.base_price, 
b.timestamp,
b.quantity,
b.discount_applied,
b.refund_flag,
c.country,
(base_price*quantity) as revenue,
round((base_price-(base_price*discount_applied)), 2) as sale_price,
format(timestamp,'MMMM') as month,
format(timestamp,'yyyy') as year
from [funnanal].[dbo].[products] a 
join [funnanal].[dbo].[transactions] b on a.product_id = b.product_id
join [funnanal].[dbo].[customers] c on b.customer_id = c.customer_id)

select *, (sale_price*quantity - 2*refund_flag*sale_price*quantity) as discount_revenue from cte

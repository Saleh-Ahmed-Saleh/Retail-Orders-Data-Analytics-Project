Select * From [Retail Ordes]..[Retail Orders]



--find top 10 highest reveue generating products 
Select Top 10 Product_Id as Id, sum(Sale_Price) AS Total_Revenue 
From [Retail Ordes]..[Retail Orders]
Group By  Product_Id
order by sum(Sale_Price) desc



--find top 5 highest selling products in each region
Select Top 5 Region as Region, Category as Products , Sum(Quantity) as Total_Sold
From [Retail Ordes]..[Retail Orders]
Group by Category , Region
Order by Sum(Quantity) DESC



--find top 5 highest selling products in each region
With cte as (
select region , product_id, sum(sale_price) as sales
From [Retail Ordes]..[Retail Orders]
Group By region ,product_id
)

Select * From( Select * , row_number() over (Partition by region Order by sales Desc) as rn From cte) A
Where rn<= 5



 --Find month over month growth comparison for 2022 and 2023 sales eg : jan 2022 vs jan 2023

With cte as (
Select Year(Order_Date) as Order_Year ,MONTH(Order_Date) as Order_Month, Sum(Sale_Price) as Sales From [Retail Ordes]..[Retail Orders]
 Group by  Year(Order_Date), MONTH(Order_Date) 
 )
Select Order_Month
, Sum(Case When Order_Year = 2022 Then Sales Else 0 End) AS Order_2022
, Sum (Case When Order_Year = 2023 Then Sales Else 0 End ) AS Order_2023
From cte
Group by  Order_Month
Order by  Order_Month


--For each category which month had highest sales 
with cte AS (
select category,format(order_date,'yyyy-MM') AS order_year_month
, sum(sale_price) AS sales 
From [Retail Ordes]..[Retail Orders]
Group by category,format(order_date,'yyyy-MM')
)

Select * From (select *,
row_number() over(partition by category Order by sales Desc) AS rn
From cte) a
Where rn = 1




--which sub category had highest growth by profit in 2023 compare to 2022

With cte AS (
Select Sub_Category, Year(Order_Date) as Order_Year, sum(sale_price) as Sales From [Retail Ordes]..[Retail Orders]
Group by Sub_Category , Year(Order_Date)
)

, cte2 as (Select sub_category 
,sum(case when order_year=2022 then sales else 0 end) as sales_2022
, sum(case when order_year=2023 then sales else 0 end) as sales_2023
From cte
Group By sub_category
)

Select Top 1 * , (sales_2023-sales_2022)
From  cte2
Order by (sales_2023-sales_2022) Desc
 




 
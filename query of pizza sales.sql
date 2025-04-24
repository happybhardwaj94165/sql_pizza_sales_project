-- calculate the total price of all pizzas who sell.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2)
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;




-- Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;





-- Identify the most common pizza size ordered.
SELECT 
    PIZZAS.SIZE, COUNT(ORDER_DETAILS.ORDER_DETAILS_ID)
FROM
    PIZZAS
        JOIN
    ORDER_DETAILS ON ORDER_DETAILS.PIZZA_ID = PIZZAS.PIZZA_ID
GROUP BY PIZZAS.SIZE
ORDER BY PIZZAS.SIZE;




-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;


-- intermediate quotions

-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT count(order_details.quantity), pizza_types.category 
from 
pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details 
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category;




-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS hour,
    COUNT(*) AS order_count
FROM 
    orders
GROUP BY 
    HOUR(order_time)
ORDER BY 
    order_count desc;



-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    ROUND(AVG(AVERAGE), 0)
FROM
    (SELECT 
        ORDERS.ORDER_DATE AS MONTH,
            SUM(ORDER_DETAILS.QUANTITY) AS AVERAGE
    FROM
        ORDERS
    JOIN ORDER_DETAILS ON ORDERS.ORDER_ID = ORDER_DETAILS.ORDER_ID
    GROUP BY ORDERS.ORDER_DATE) AS ROUND_AVERAGE;
    
    

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    PIZZA_TYPES.NAME,
    SUM(ORDER_DETAILS.QUANTITY * PIZZAS.PRICE) AS REVENUE
FROM
    PIZZAS
        JOIN
    PIZZA_TYPES ON PIZZAS.PIZZA_TYPE_ID = PIZZA_TYPES.PIZZA_TYPE_ID
        JOIN
    ORDER_DETAILS ON ORDER_DETAILS.PIZZA_ID = PIZZAS.PIZZA_ID
GROUP BY PIZZA_TYPES.NAME
ORDER BY REVENUE DESC
LIMIT 3;




-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT PIZZA_TYPES.CATEGORY, (SUM(ORDER_DETAILS.QUANTITY * PIZZAS.PRICE) / (SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2)
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id))* 100 AS REVENUE

FROM PIZZA_TYPES JOIN PIZZAS ON PIZZA_TYPES.PIZZA_TYPE_ID = PIZZAS.PIZZA_TYPE_ID
JOIN ORDER_DETAILS ON ORDER_DETAILS.PIZZA_ID = PIZZAS.PIZZA_ID
GROUP BY PIZZA_TYPES.CATEGORY ORDER BY REVENUE DESC;



-- items whose order doesn't exist
SELECT 
COUNT(*)
FROM order_items oi
WHERE NOT EXISTS(
SELECT 1 FROM orders o
WHERE o.order_id = oi.order_id
);
--result: 0

--orphan payment
SELECT 
COUNT(*)
FROM order_payments op
WHERE NOT EXISTS(
SELECT 1 FROM orders o
WHERE o.order_id = op.order_id
);
--result: 0

----orphan reviews
SELECT 
COUNT(*)
FROM order_reviews orr
WHERE NOT EXISTS(
SELECT 1 FROM orders o
WHERE o.order_id = orr.order_id
);
--result: 0

--customers whose order doesnt exist
SELECT 
COUNT(*)
FROM customers c
WHERE NOT EXISTS(
SELECT 1 FROM orders o
WHERE o.customer_id = c.customer_id
);
--result: 0

--items which doesnt have corresponding product id
SELECT 
COUNT(*)
FROM order_items oi
WHERE NOT EXISTS(
SELECT 1 FROM products p
WHERE p.product_id = oi.product_id
);
--result: 0

--items without sellers
SELECT 
COUNT(*)
FROM order_items oi
WHERE NOT EXISTS(
SELECT 1 FROM sellers s
WHERE s.seller_id = oi.seller_id
);
--result: 0

--orders without customers
SELECT 
COUNT(*)
FROM orders o
WHERE NOT EXISTS(
SELECT 1 FROM customers c
WHERE o.customer_id = c.customer_id
);
--result: 0

--not translated products
SELECT 
DISTINCT p.product_category_name
FROM products p
WHERE NOT EXISTS(
SELECT 1 FROM product_category_name_translation pc
WHERE pc.product_category_name = p.product_category_name
) AND p.product_category_name IS NOT NULL;
--result: 2 categories, "namely pc_gamer" and "portateis_cozinha_e_preparadores_de_alimentos"

--order without payments
SELECT 
*
FROM orders o
WHERE NOT EXISTS(
SELECT 1
FROM order_payments op
WHERE op.order_id = o.order_id
);
--result: 1 order

--order without items
SELECT 
order_status,
COUNT(*) as orders_without_items
FROM orders o
WHERE NOT EXISTS(
        SELECT 1
        FROM order_items oi
        WHERE oi.order_id = o.order_id
    )
GROUP BY o.order_status
ORDER BY orders_without_items DESC
--result: 775 orders, most belong to unavailable status followed by canceled

--Order without reviews
SELECT 
order_status,
COUNT(*) as orders_without_reviews
FROM orders o
WHERE NOT EXISTS(
    SELECT 1
    FROM order_reviews orr
    WHERE orr.order_id = o.order_id
)
GROUP BY o.order_status
ORDER BY orders_without_reviews DESC;
;
--result: 768 orders,most belong to delivered category followed by shipped.

--checking uniquness of composite keys
SELECT 
order_id,
order_item_id,
COUNT(*) as n
FROM order_items
GROUP BY order_id, order_item_id
HAVING COUNT(*) > 1;
--result: 0 rows, means order_id and order_item_id are unique composite keys of order_items


SELECT 
order_id,
payment_sequential,
COUNT(*) as n
FROM order_payments 
GROUP BY order_id,payment_sequential
HAVING COUNT(*) > 1;
--result: 0 rows, means order_id and payment_sequential are unique composite keys of order_payments


--checking for order_reviews table
SELECT 
review_id,
COUNT(*) N
FROM order_reviews
GROUP BY review_id
HAVING COUNT(*)>1;

SELECT 
review_id,
order_id,
COUNT(*) N
FROM order_reviews
GROUP BY review_id, order_id
HAVING COUNT(*)>1;
-- result: review_id repeats; (review_id, order_id) is unique, so use the pair as the key


--checking nulls in important cols
SELECT
SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS null_order_id,
SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id
FROM orders;
--result: zero nulls

SELECT COUNT(*)
FROM products 
WHERE product_category_name IS NULL;
--result: 610 such categories where category name is null


--Finding difference in no. of people and customer id  
SELECT
COUNT(*) AS customer_rows,
COUNT(DISTINCT customer_id) AS distinct_customer_ids,
COUNT(DISTINCT customer_unique_id) AS actual_people
FROM customers;
--result 96096 actual people and 99441 distinct customer ids, basically every row has 
--it's unique customer id

-- how many people ordered more than once
SELECT COUNT(*) AS repeat_customers
FROM (
    SELECT customer_unique_id
    FROM customers
    GROUP BY customer_unique_id
    HAVING COUNT(*) > 1
)t;
--result: 2997 repeated orders
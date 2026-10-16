# Business Questions

## Definitions (used in every question)
- **Delivered orders only** for any delivery-time analysis.
- **Late:** delivered after the estimated delivery date.
- **Bad review:** review score of 1 or 2.
- **Revenue:** [item price only / price + freight: pick one].
- **Grain:** items, payments and reviews are aggregated to one row per order before joining.
- **Minimum threshold:** sellers and categories need at least [N] orders to be ranked.
- **Time range:** first and last months are incomplete and excluded from trends.

## Questions

1. **Trend and seasonality.** How do monthly orders and revenue change over time,
   and do 2017 and 2018 show the same seasonal peaks and troughs?
   Tables: orders, order_items.
   Decision: 

2. **Order status.** What share of orders are canceled or unavailable,
   and does this vary by month or state?
   Tables: orders, customers.
   Decision: 

3. **Estimated vs actual delivery.** What share of delivered orders arrive late,
   how many days late are they on average, and how are early and late
   deliveries distributed (median, percentiles)?
   Tables: orders.
   Decision: 

4. **Where delivery time is spent.** How long does each stage take
   (purchase to approval, approval to carrier handoff, handoff to customer),
   and do sellers meet the shipping limit date?
   Tables: orders, order_items.
   Decision: 

5. **Lateness and reviews.** Do late deliveries get more bad reviews,
   and does the review score fall as the delay grows (on time, 1-3, 4-7, 8+ days)?
   Tables: orders, order_reviews.
   Decision: 

6. **Geography.** How are customers, sellers and revenue concentrated by state,
   and are cross-state orders late more often than same-state orders?
   Tables: orders, order_items, customers, sellers.
   Decision: 

7. **Seller concentration and performance.** What share of revenue comes from
   the top 10% of sellers, and which sellers combine high late rates with
   low review scores?
   Tables: order_items, sellers, orders, order_reviews.
   Decision: 

8. **Category performance.** Which product categories lead in units, revenue
   and average price, and how concentrated is revenue across categories?
   Tables: order_items, products, category translation.
   Decision: 

9. **Price and reviews.** Within the largest categories, do higher-priced
   products get more bad reviews than cheaper ones (price quartiles)?
   Tables: order_items, products, order_reviews.
   Decision: 

10. **Payments.** What is the payment type mix by orders and revenue,
    and how do payment type and installments relate to order value?
    Tables: order_payments, order_items.
    Decision: 

11. **Stretch: repeat customers.** Among repeat vs one-time customers
    (using customer_unique_id), what differs in first-order review score,
    lateness, order value, category and state?
    Tables: orders, customers, order_items, order_reviews.
    Decision:
SELECT
    orders.*,
    transactions.*,
    verification.*
FROM orders
LEFT JOIN transactions ON orders.id = transactions.order_id
LEFT JOIN verification ON transactions.id = verification.transaction_id
WHERE orders.updated_at > (SELECT MAX(uploaded_at) FROM orders)
   OR transactions.updated_at > (SELECT MAX(uploaded_at) FROM transactions)
   OR verification.updated_at > (SELECT MAX(uploaded_at) FROM verification);

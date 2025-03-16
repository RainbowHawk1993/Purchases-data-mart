SELECT
    orders.*,
    transactions.*,
    verification.*
FROM orders
LEFT JOIN transactions ON orders.id = transactions.order_id
LEFT JOIN verification ON transactions.id = verification.transaction_id
WHERE
    (orders.uploaded_at > (SELECT MAX(uploaded_at) FROM orders) OR orders.uploaded_at IS NULL)
    OR
    (transactions.uploaded_at > (SELECT MAX(uploaded_at) FROM transactions) OR transactions.uploaded_at IS NULL)
    OR
    (verification.uploaded_at > (SELECT MAX(uploaded_at) FROM verification) OR verification.uploaded_at IS NULL);

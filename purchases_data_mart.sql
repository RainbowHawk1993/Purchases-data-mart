WITH LatestUpload AS (
    SELECT COALESCE(MAX(uploaded_at), '1970-01-01 00:00:00'::timestamp) AS latest_upload
    FROM purchases
)
SELECT
    orders.*,
    transactions.*,
    verification.*
FROM orders
LEFT JOIN transactions ON orders.id = transactions.order_id
LEFT JOIN verification ON transactions.id = verification.transaction_id
WHERE orders.updated_at > (SELECT latest_upload FROM LatestUpload)
   OR transactions.updated_at > (SELECT latest_upload FROM LatestUpload)
   OR verification.updated_at > (SELECT latest_upload FROM LatestUpload);

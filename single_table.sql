-- Convert all user emails to uppercase for standardization (single-row function)
SELECT UPPER(email) AS upper_email FROM Users;

-- Calculate the average current price of all listed stocks (aggregate function)
SELECT AVG(current_price) AS avg_current_price FROM Stocks;

-- List all portfolios, ordered alphabetically to improve readability (ORDER BY)
SELECT * FROM Portfolios
ORDER BY portfolio_name ASC;

-- Show the 3 most recent transactions for user insight (LIMIT)
SELECT * FROM Transactions
ORDER BY transaction_date DESC
LIMIT 3;

-- Classify alert status messages using CASE for user-friendly labels (selection control function)
SELECT 
    alert_id,
    user_id,
    stock_id,
    alert_status,
    CASE 
        WHEN alert_status = 'active' THEN 'Still Monitoring'
        WHEN alert_status = 'triggered' THEN 'Alert Hit'
        WHEN alert_status = 'expired' THEN 'No Longer Valid'
        ELSE 'Unknown'
    END AS status_message
FROM Stock_Alerts;

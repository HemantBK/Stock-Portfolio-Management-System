-- Display all stocks held in each portfolio using an associative table and inner join
SELECT ps.portfolio_id, p.portfolio_name, s.ticker_symbol, ps.shares_owned
FROM Portfolio_Stocks ps
INNER JOIN Portfolios p ON ps.portfolio_id = p.portfolio_id
INNER JOIN Stocks s ON ps.stock_id = s.stock_id;

-- Show users and their latest transactions using lefrt join
SELECT u.user_id, u.name, t.transaction_id, t.transaction_date
FROM Users u
LEFT OUTER JOIN Transactions t ON u.user_id = t.user_id;

-- Combine portfolios holding either Technology or E-commerce sector stocks using union
SELECT DISTINCT p.portfolio_name
FROM Portfolio_Stocks ps
JOIN Stocks s ON ps.stock_id = s.stock_id
JOIN Portfolios p ON ps.portfolio_id = p.portfolio_id
WHERE s.sector = 'Technology'
UNION
SELECT DISTINCT p.portfolio_name
FROM Portfolio_Stocks ps
JOIN Stocks s ON ps.stock_id = s.stock_id
JOIN Portfolios p ON ps.portfolio_id = p.portfolio_id
WHERE s.sector = 'E-commerce';

-- List names of users who have at least one stock alert using a subquery (multi-row operation)
SELECT name
FROM Users
WHERE user_id IN (
    SELECT DISTINCT user_id
    FROM Stock_Alerts
);

-- Identify top 3 most-owned stocks across portfolios using a CTE (WITH clause)
WITH TotalShares AS (
    SELECT stock_id, SUM(shares_owned) AS total
    FROM Portfolio_Stocks
    GROUP BY stock_id
)
SELECT s.ticker_symbol, t.total
FROM TotalShares t
JOIN Stocks s ON s.stock_id = t.stock_id
ORDER BY t.total DESC
LIMIT 3;

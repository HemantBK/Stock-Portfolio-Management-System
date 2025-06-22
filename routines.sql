-- Procedure to log a new transaction for a user buying or selling stock
DELIMITER //
CREATE PROCEDURE AddTransaction(
    IN p_user_id INT,
    IN p_stock_id INT,
    IN p_type ENUM('buy', 'sell'),
    IN p_shares INT,
    IN p_price DECIMAL(10,2),
    IN p_date DATETIME
)
BEGIN
    INSERT INTO Transactions(user_id, stock_id, transaction_type, shares, price_per_share, transaction_date)
    VALUES (p_user_id, p_stock_id, p_type, p_shares, p_price, p_date);
END;
//
DELIMITER ;

-- Procedure to show all stocks in a users portfolios for review or display
DELIMITER //
CREATE PROCEDURE ShowUserPortfolio(IN p_user_id INT)
BEGIN
    SELECT u.name, p.portfolio_name, s.ticker_symbol, ps.shares_owned
    FROM Users u
    JOIN Portfolios p ON u.user_id = p.user_id
    JOIN Portfolio_Stocks ps ON p.portfolio_id = ps.portfolio_id
    JOIN Stocks s ON ps.stock_id = s.stock_id
    WHERE u.user_id = p_user_id;
END;
//
DELIMITER ;

-- Function to calculte total shares owned of a specific stock across all portfolios
DELIMITER //
CREATE FUNCTION GetTotalShares(stock INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT SUM(shares_owned) INTO total
    FROM Portfolio_Stocks
    WHERE stock_id = stock;
    RETURN total;
END;
//
DELIMITER ;

-- Bonus functions and a trigger statement to analyse the user portfolio and trigger exceed of buy

-- Function to calculate the total current value of all portfolios for a given user
-- It multiplies shares_owned by the current stock price and sums it up
DELIMITER //
CREATE FUNCTION GetUserPortfolioValue(p_user_id INT)
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE total_value DECIMAL(15,2);

    SELECT SUM(ps.shares_owned * s.current_price)
    INTO total_value
    FROM Portfolios p
    JOIN Portfolio_Stocks ps ON p.portfolio_id = ps.portfolio_id
    JOIN Stocks s ON ps.stock_id = s.stock_id
    WHERE p.user_id = p_user_id;

    RETURN COALESCE(total_value, 0.00); -- Returns 0 if user has no stocks
END;
//
DELIMITER ;

-- Trigger to mark a stock alert as 'triggered' when a buy transaction exceeds target price
DELIMITER //
CREATE TRIGGER Log_Triggered_Alert
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    IF NEW.transaction_type = 'buy' THEN
        UPDATE Stock_Alerts
        SET alert_status = 'triggered'
        WHERE user_id = NEW.user_id
          AND stock_id = NEW.stock_id
          AND target_price < NEW.price_per_share
          AND alert_status = 'active';
    END IF;
END;
//
DELIMITER ;

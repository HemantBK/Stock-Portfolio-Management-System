-- 1) Create the database
CREATE DATABASE IF NOT EXISTS stocks_data;
USE stocks_data;

-- 2) Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    username VARCHAR(50),
    password VARCHAR(255),
    created_at DATETIME
);

-- 3) Inserting values from data.xlsx into the Users table
INSERT INTO Users (user_id, name, email, username, password, created_at) VALUES
(1, 'Alice Johnson', 'alice@example.com', 'alicej', 'pass123', '2024-02-01'),
(2, 'Bob Smith', 'bob@example.com', 'bobsmith', 'securepass', '2024-02-02'),
(3, 'Charlie Lee', 'charlie@example.com', 'charliel', 'mypassword', '2024-02-03'),
(4, 'David Kim', 'david@example.com', 'davidk', 'dksecure', '2024-02-04'),
(5, 'Emma Davis', 'emma@example.com', 'emmad', 'emmasecure', '2024-02-05'),
(6, 'Frank Brown', 'frank@example.com', 'frankb', 'frankpass', '2024-02-06'),
(7, 'Grace Miller', 'grace@example.com', 'gracem', 'gracepwd', '2024-02-07'),
(8, 'Henry Wilson', 'henry@example.com', 'henryw', 'henrypass', '2024-02-08'),
(9, 'Isabella Thomas', 'isabella@example.com', 'isabellat', 'isapass', '2024-02-09'),
(10, 'Jack White', 'jack@example.com', 'jackw', 'jackpass', '2024-02-10');

-- 4) Stocks Table
CREATE TABLE Stocks (
    stock_id INT PRIMARY KEY,
    ticker_symbol VARCHAR(10),
    company_name VARCHAR(100),
    sector VARCHAR(50),
    current_price DECIMAL(10,2),
    historical_price DECIMAL(10,2),
    Users_user_id INT,
    FOREIGN KEY (Users_user_id) REFERENCES Users(user_id)
);

-- 5) Inserting values from data.xlsx into the Stocks table 
INSERT INTO Stocks (stock_id, ticker_symbol, company_name, sector, current_price, historical_price) VALUES
(1, 'AAPL', 'Apple Inc.', 'Technology', 180.5, 175),
(2, 'TSLA', 'Tesla Inc.', 'Automotive', 210.3, 205.7),
(3, 'AMZN', 'Amazon Inc.', 'E-commerce', 145.8, 140),
(4, 'GOOGL', 'Alphabet Inc.', 'Technology', 2750, 2700.5),
(5, 'MSFT', 'Microsoft Corp.', 'Technology', 300.7, 290.1);

-- 6) Portfolios Table
CREATE TABLE Portfolios (
    portfolio_id INT PRIMARY KEY,
    user_id INT,
    portfolio_name VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- 7) Inserting values from data.xlsx into the Portfolios table
INSERT INTO Portfolios (portfolio_id, user_id, portfolio_name) VALUES
(1, 1, 'Tech Giants'),
(2, 2, 'Growth Picks'),
(3, 3, 'My Portfolio'),
(4, 4, 'Diversified'),
(5, 5, 'Long-Term Holdings');

-- 8) Portfolio_Stocks Table
CREATE TABLE Portfolio_Stocks (
    portfolio_id INT,
    stock_id INT,
    shares_owned INT,
    PRIMARY KEY (portfolio_id, stock_id),
    FOREIGN KEY (portfolio_id) REFERENCES Portfolios(portfolio_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

-- 9) Inserting values from data.xlsx into the Portfolios_Stocks table
INSERT INTO Portfolio_Stocks (portfolio_id, stock_id, shares_owned) VALUES
(1, 1, 10),
(1, 2, 5),
(2, 3, 15),
(2, 4, 8),
(3, 5, 12),
(4, 1, 7),
(4, 3, 9),
(5, 2, 6),
(5, 5, 11),
(3, 4, 4);

-- 10) Transactions Table
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    user_id INT,
    stock_id INT,
    transaction_type ENUM('buy', 'sell'),
    shares INT,
    price_per_share DECIMAL(10,2),
    transaction_date DATETIME,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

-- 11) Inserting values from data.xlsx into the Transactions table
INSERT INTO Transactions (transaction_id, user_id, stock_id, transaction_type, shares, price_per_share, transaction_date) VALUES
(1, 1, 1, 'buy', 10, 180.5, '2024-02-11'),
(2, 2, 2, 'buy', 5, 210.3, '2024-02-12'),
(3, 3, 3, 'sell', 8, 145.8, '2024-02-14'),
(4, 4, 4, 'buy', 12, 2750, '2024-02-15'),
(5, 5, 5, 'buy', 7, 300.7, '2024-02-16'),
(6, 6, 1, 'sell', 4, 550.2, '2024-02-17'),
(7, 7, 2, 'buy', 6, 800.5, '2024-02-18');

-- 12) Stock_Alerts Table
CREATE TABLE Stock_Alerts (
    alert_id INT PRIMARY KEY,
    user_id INT,
    stock_id INT,
    target_price DECIMAL(10,2),
    alert_status ENUM('active', 'triggered', 'expired'),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

-- 13) Inserting values from data.xlsx into the Stocks_Alerts table
INSERT INTO Stock_Alerts (alert_id, user_id, stock_id, target_price, alert_status) VALUES
(1, 1, 1, 190.00, 'active'),
(2, 2, 2, 220.00, 'triggered'),
(3, 3, 3, 150.00, 'expired'),
(4, 4, 4, 2800.00, 'active'),
(5, 5, 5, 310.00, 'active');

-- 14) News_Articles Table
CREATE TABLE News_Articles (
    news_id INT PRIMARY KEY,
    stock_id INT,
    headline VARCHAR(255),
    published_date DATETIME,
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);

-- 15) Inserting values from data.xlsx into the News_Articles table
INSERT INTO News_Articles (news_id, stock_id, headline, published_date) VALUES
(1, 1, 'Apple releases new AI chip', '2024-02-01'),
(2, 2, 'Tesla announces new battery technology', '2024-02-02'),
(3, 3, 'Amazon expands logistics network', '2024-02-03');


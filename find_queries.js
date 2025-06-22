// 1) Match names starting with "A"

db.collection.find({ name: { $regex: '^A', $options: 'i' } }, { name: 1, email: 1 })

// 2) Find users who have at least one portfolio with a stock in the 'Technology' sector using $elemMatch

db.collection.find({ portfolios: { $elemMatch: { 'stocks.sector': 'Technology' } } }, { name: 1, portfolios: 1 })

// 3) Find users who made a transaction for stock_id 4 (embedded document)

db.collection.find({ 'transactions.stock_id': 4 }, { name: 1, transactions: 1 })

// 4) Return only the matching stock where ticker_symbol is 'AAPL' using $

db.collection.find({ 'portfolios.stocks.ticker_symbol': 'AAPL' }, { name: 1, 'portfolios.stocks.$': 1 })

// 5) Find users who do NOT have username 'alicej' or 'bobsmith' using $nor

db.collection.find({ $nor: [ { username: 'alicej' }, { username: 'bobsmith' } ] }, { username: 1, name: 1 })

// 6) Find users who have the 'alerts' field (i.e., at least one alert exists)
db.collection.find(
  { alerts: { $exists: true, $ne: [] } },
  { name: 1, alerts: 1 }
)

// 7) Find users where created_at is stored as a string
db.collection.find(
  { created_at: { $type: "string" } },
  { name: 1, created_at: 1 }
)

// 8) Find users who have portfolios with stocks in stock_id 1, 2, or 3
db.collection.find(
  { "portfolios.stocks.stock_id": { $in: [1, 2, 3] } },
  { name: 1, "portfolios.stocks": 1 }
)

// 9) Find users who have both 'active' and 'inactive' alerts
db.collection.find(
  {
    "alerts.alert_status": { $all: ["active", "inactive"] }
  },
  { name: 1, alerts: 1 }
)

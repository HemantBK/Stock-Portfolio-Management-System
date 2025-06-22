// 1) Unwind portfolios to show each user-portfolio combination

db.collection.aggregate([
  { $unwind: '$portfolios' },
  { $project: { name: 1, portfolio_name: '$portfolios.portfolio_name' } }
]);

// 2) Group by transaction_type and count how many transactions of each type exist

db.collection.aggregate([
  { $unwind: '$transactions' },
  { $group: { _id: '$transactions.transaction_type', total: { $sum: 1 } } }
]);

// 3) Group by sector and push user names who have that stock sector

db.collection.aggregate([
  { $unwind: '$portfolios' },
  { $unwind: '$portfolios.stocks' },
  { $group: { _id: '$portfolios.stocks.sector', users: { $push: '$name' } } }
]);

// 4) Project only 'active' alerts using $filter

db.collection.aggregate([
  { $project: {
      name: 1,
      active_alerts: {
        $filter: {
          input: '$alerts',
          as: 'alert',
          cond: { $eq: ['$$alert.alert_status', 'active'] }
        }
      }
  } }
]);

// 5) Reshape user output to include name and total number of stocks owned across all portfolios

db.collection.aggregate([
  { $unwind: '$portfolios' },
  { $project: {
      name: 1,
      stock_count: { $size: '$portfolios.stocks' }
  } }
]);

// 6) Get average transaction price for each user
db.collection.aggregate([
  { $unwind: "$transactions" },
  {
    $group: {
      _id: "$_id",
      name: { $first: "$name" },
      average_transaction_price: { $avg: "$transactions.price_per_share" }
    }
  }
]);

// 7) Count total number of active vs inactive alerts
db.collection.aggregate([
  { $unwind: "$alerts" },
  {
    $group: {
      _id: "$alerts.alert_status",
      count: { $sum: 1 }
    }
  }
]);

// 8) Find users with most number of stocks across all portfolios
db.collection.aggregate([
  { $unwind: "$portfolios" },
  {
    $group: {
      _id: "$_id",
      name: { $first: "$name" },
      total_stocks: { $sum: { $size: "$portfolios.stocks" } }
    }
  },
  { $sort: { total_stocks: -1 } }
]);

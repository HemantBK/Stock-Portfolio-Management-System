# 📊 Stock Portfolio Management System(SQL & NoSQL)


## 🚀 Project Overview

The **Stock Portfolio Management System** is a comprehensive data project that models, implements, and queries a stock investment platform using both **SQL (MySQL)** and **NoSQL (MongoDB)** technologies. The system enables users to manage portfolios, perform transactions, track real-time stock prices, set alerts, and receive news updates.

---

## 🛠️ Tools & Technologies Used

| Tool/Technology      | Purpose                                         |
|----------------------|-------------------------------------------------|
| **MySQL**            | Relational schema creation, querying & routines |
| **MongoDB**          | NoSQL database for document-based storage       |
| **Lucid chart**      | Conceptual & physical data modeling             |
| **VS Code**          | SQL and JavaScript code development             |
| **Mongo Shell**      | Testing and running NoSQL queries               |
| **JSON / JavaScript**| MongoDB document and query definition           |

---

## 📦 Project Structure

The project was developed across **three phases**, each building upon the previous.

---

## 🧱 Phase 1: **Database Design**

  
### Deliverables:
- `requirements_analysis.pdf`: Describes the platform features & data requirements.
- `data.xlsx`: Sample dataset of users, portfolios, stocks, transactions, alerts.
- `conceptual_data_model.png`: Crow’s Foot ER Diagram showing all entities and relationships.
- `physical_data_model.png`: Physical data model with primary and foreign keys.

📌 Key Features:
- 6+ non-associative entities and 1 associative entity (`Portfolio_Stocks`)
- 15+ attributes (excluding PK/FK)
- 50+ records distributed across all tables
- Resolved many-to-many and one-to-many relationships

---

## 🧮 Phase 2: **SQL Implementation & Querying**


### Deliverables:
- `stocks_data.sql`: Table creation + data insertion.
- `single_table.sql`: Single-table queries using:
  - `CASE`, `COALESCE`, `UPPER`, `LIMIT`, `ORDER BY`, and aggregation functions
- `multiple_table.sql`: Multi-table queries using:
  - `INNER JOIN`, `LEFT OUTER JOIN`, `UNION`, subqueries, CTEs (`WITH`)
- `routines.sql`: 
  - ✅ 2 Procedures (`AddTransaction`, `ShowUserPortfolio`)
  - ✅ 2 Functions (`GetTotalShares`, `GetUserPortfolioValue`)
  - ✅ 1 Trigger (`Log_Triggered_Alert`)

📌 Concepts Covered:
- SQL DDL, DML
- Aggregate functions, filters
- Stored procedures and user-defined functions
- Joins, set operations, derived tables

---

## 🍃 Phase 3: **NoSQL Implementation (MongoDB)**

 
### Deliverables:
- `collection.json`: Denormalized collection of 10 complete user documents
- `collection.pdf`: Justification for user-centric aggregate boundary
- `collection_creation.js`: Script to insert user documents into MongoDB
- `find_queries.js`: Find queries using:
  - `$regex`, `$elemMatch`, `$nor`, `$exists`, `$in`, `$all`
- `aggregate_pipelines.js`: Aggregation pipelines using:
  - `$unwind`, `$group` + `$sum`, `$push`, `$avg`
  - `$project` with `$filter`, reshaped documents

📌 Highlights:
- Used embedded documents for portfolios, transactions, alerts
- Document modeling to optimize real-time access & user dashboards
- Complex MongoDB operations for analytics and personalization

---

## 📈 Learning Outcomes

- Designed normalized relational schemas and converted to NoSQL documents
- Applied advanced SQL queries, joins, routines, and triggers
- Mastered MongoDB document modeling and aggregation
- Understood trade-offs between relational vs document-based systems

---


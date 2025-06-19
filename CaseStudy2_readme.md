# 🎯 Advanced SQL Queries — Sakila & Orders Database

This project includes a series of complex SQL queries focused on analyzing a **film rental database (like Sakila)** and a **product-carton fitting problem**. These queries demonstrate usage of SQL aggregation, joins, subqueries, window functions, and optimization logic.

---

## 📁 Part 1: Sakila (Film Rental) Database

### 1. Top 5 Customers by Money Spent
- **Goal:** Identify the top 5 customers who spent the most.
- **Output:** First name, last name, total money spent.

### 2. Customers Renting from All Stores
- **Goal:** Find customers who have rented from every store location.
- **Output:** First name, last name, money spent.

### 3. Average Rental Duration by Category
- **Goal:** Compute average rental duration (in days) for each film category.
- **Output:** Category name, average duration.

### 4. Actor with the Most Films
- **Goal:** Identify the actor who acted in the most films.
- **Output:** Full name, number of films.

### 5. Above-Average Renters
- **Goal:** List customers who rented more than the average customer.
- **Output:** Full name, number of rentals.

### 6. City with Highest Revenue
- **Goal:** Find which city generated the most revenue from rentals.
- **Output:** City name, country, total revenue.

### 7. Top 3 Rented Films per Category
- **Goal:** Use window functions to fetch top 3 most rented films in each category.
- **Output:** Title, category, number of rentals, revenue generated.

### 8. Customers with No Payments
- **Goal:** Identify customers who never made any payments.
- **Output:** Full name.

### 9. Most Active Staff Member
- **Goal:** Find the staff member who processed the highest number of rentals.
- **Output:** Staff ID, number of rentals.

### 10. Customers Who Rented Both 'Action' and 'Comedy'
- **Goal:** List customers who rented at least one film from both genres.
- **Output:** Full name, number of rentals.

### 11. Customer with Most Late Returns
- **Goal:** Detect the customer with the most late returns (where rental days exceeded expected).
- **Output:** Full name.

### 12. Actors in All Rating Categories
- **Goal:** Find actors who acted in at least one film from every rating type.
- **Output:** Actor name, number of films.

---

## ⚙️ Part 2: Orders & Carton Database

### 🎯 Problem:
> For each product, find the best fitting carton that can contain it. Choose the carton with the **smallest possible volume** that can still hold the product dimensions.

### 🧮 Assumptions:
- Product and carton have 3D dimensions: `length`, `width`, `height`.
- A carton fits a product if its dimensions are all **greater than or equal** to the product’s.

### ✅ Output:
- `product_id`, `best_fit_carton_id`

---

## 🛠️ Technologies Used

- SQL (MySQL syntax)
- Subqueries
- Window Functions (`rank() over`)
- Common Table Expressions (CTEs)
- Conditional Logic

---

## 📂 How to Use

1. Import the Sakila sample database (`sakila-schema.sql`, `sakila-data.sql`).
2. Run each query individually or use a SQL client like **DBeaver**, **MySQL Workbench**, or **pgAdmin**.
3. For the carton fitting logic, ensure you have `product` and `carton` tables with size attributes.

---

## 🤝 Contributions

Feel free to fork, star ⭐, and raise pull requests for optimization, documentation, or query enhancements.

---

## 📬 Contact

For questions or collaborations:
- 👤 Tarun Chaudhary  
- 📧 tarun2004tc@gmail.com  
- 🔗 [LinkedIn](https://www.linkedin.com/in/tarun-chaudhary-5812bb326)

---

# Part 1 - Relational Databases

## Anomaly Analysis

### Insert Anomaly
**Example**: In the denormalized `orders_flat.csv`, a new product cannot be added to the system until it is actually ordered. For instance, if we want to add "Wireless Keyboard" as a new product (product_name, category, unit_price) but no customer has ordered it yet, we cannot insert this product information because the CSV requires order-related fields (order_id, order_date, customer_id, etc.) to have values. This creates a data inconsistency where we cannot maintain a complete product catalog independently of orders.

### Update Anomaly
**Example**: Customer information is duplicated across multiple order rows. In `orders_flat.csv`, if customer "Rahul Sharma" (customer_id: 1) appears in 5 different order rows, and his email or phone number changes, we would need to update all 5 rows individually. If we only update some of them, the data becomes inconsistent with different email/phone values for the same customer across rows.

### Delete Anomaly
**Example**: If we delete an order row for a customer who has only placed one order, we would lose that customer's information entirely. For instance, deleting the order with customer "Anjali Verma" would also delete her city, email, and phone number from the dataset, even though she is a valid customer entity that should be retained in the system.

## Normalization Justification

My manager argues that keeping everything in one table is simpler and normalization is over-engineering. This position is fundamentally flawed for the following reasons.

First, the denormalized `orders_flat.csv` leads to severe **data redundancy**. Every time a customer places an order, their entire profile (name, city, email, phone) is duplicated across rows. With 10,000 orders and an average customer placing 5 orders each, we are storing the same customer data 5 times unnecessarily, wasting storage and increasing the risk of inconsistencies.

Second, the **data integrity issues** are substantial. As demonstrated in the anomaly analysis above, update anomalies mean a single customer record change requires updating potentially hundreds of rows. A single missed update creates conflicting data - one row shows Rahul Sharma's old phone number while another shows the new one. This makes the data unreliable for business decisions.

Third, **delete anomalies** cause unintended data loss. Removing a single order for a customer with only one purchase erases their entire profile. This violates the basic principle that customer data should persist independently of their transaction history.

Fourth, **query complexity increases** with denormalized data. Finding the top 3 products or calculating unique customers per sales representative requires handling duplicate data and complex aggregations that normalized schemas handle elegantly with simple JOINs.

Finally, while a single flat table may appear simpler initially, the **maintenance cost** of fixing data inconsistencies, handling anomalies, and ensuring data quality far exceeds the learning curve of normalization. A properly normalized 3NF schema with customers, products, orders, order_items, and sales_representatives tables eliminates all three types of anomalies while making the data more maintainable and queries more efficient.

In conclusion, normalization is not over-engineering — it is the essential foundation for any production-grade database system. The initial complexity of multiple tables is a small price to pay for data integrity, consistency, and long-term maintainability.

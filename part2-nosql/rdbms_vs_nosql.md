# Part 2 - NoSQL Databases

## Database Recommendation

For a healthcare startup building a patient management system, I would recommend **MongoDB (NoSQL)** over MySQL, primarily due to the nature of patient data and the system's requirements.

### ACID vs BASE Consideration

Patient management systems involve highly varied data types per patient — medical history, allergies, medications, lab results, imaging reports, insurance details, and visit records. These data structures differ significantly across specialties (cardiology vs dermatology vs pediatrics). MySQL's rigid schema would require either creating numerous separate tables with complex JOINs or a single massive table with many NULL columns. MongoDB's flexible document model handles this naturally. Each patient record can be a single document containing nested objects for visit history, arrays for medications, and varying structures per medical condition.

While MySQL guarantees ACID properties (Atomicity, Consistency, Isolation, Durability) essential for financial transactions, healthcare systems often prioritize **availability and scalability** (BASE: Basically Available, Soft state, Eventually consistent). A doctor needing quick access to a patient's record during an emergency cannot afford system downtime. MongoDB's replication and horizontal scaling capabilities ensure high availability.

### CAP Theorem Analysis

According to the CAP theorem, a distributed database can only guarantee two of three: Consistency, Availability, and Partition Tolerance. Healthcare systems prioritize **AP (Availability + Partition Tolerance)** over strict CP. During network partitions, it is more critical for a doctor's terminal to display patient records (even slightly stale ones) than to completely deny access. MongoDB, as an AP-oriented system, handles this well with eventual consistency. Patient data like allergies and chronic conditions rarely change frequently, making eventual consistency acceptable.

### When MySQL Might Be Considered

However, MySQL becomes more attractive when the startup needs to add a **fraud detection module**. Fraud detection involves complex analytical queries, joins across billing records, insurance claims, and provider networks — tasks where relational databases excel. The module would require:

- Complex JOINs across billing, claims, and provider tables
- Aggregations for detecting suspicious patterns
- Strict ACID compliance for financial audit trails
- Referential integrity between claims and payments

In this scenario, the recommendation changes to a **hybrid architecture**: MongoDB for the core patient management system (document storage) and MySQL (or PostgreSQL) for the fraud detection module (transactional/analytical queries). This approach leverages the strengths of both database paradigms.

### Conclusion

For the base patient management system, MongoDB wins due to its schema flexibility, horizontal scalability, and availability guarantees. If fraud detection is added, a polyglot persistence architecture combining MongoDB for patient documents and MySQL for transactional analytics provides the optimal solution.

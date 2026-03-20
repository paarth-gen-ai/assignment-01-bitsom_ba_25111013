## ETL Decisions

### Decision 1 Date Standardization
Problem: Source data contained dates in multiple formats (DD-MM-YYYY, MM/DD/YYYY, YYYY-MM-DD), causing inconsistent parsing and incorrect chronological sorting in the data warehouse.
Resolution: Implemented a parsing pipeline that first detects the date format using regex pattern matching, then converts all dates to the ISO 8601 standard (YYYY-MM-DD) before loading into the Dim_Date dimension table. Invalid dates are flagged for manual review.

### Decision 2 Category Case Normalization
Problem: Product categories had inconsistent capitalization across source files (e.g., "Electronics", "electronics", "ELECTRONICS"), which would result in duplicate dimension entries and fragmented analytics.
Resolution: Applied a normalization rule to convert all category names to Title Case using a lookup mapping. Unrecognized categories trigger a data quality alert and are assigned to an "Uncategorized" bucket for downstream classification.

### Decision 3 NULL Store City Handling
Problem: Approximately 15% of retail transaction records had NULL values for the store_city field, making geographic segmentation impossible and skewing regional sales analysis.
Resolution: Implemented a hierarchical imputation strategy: (1) If store_name exists, look up the city from the store master reference table, (2) If the store is unknown, assign the value "Unknown" and flag for investigation, (3) Records with both NULL store_name and NULL store_city are routed to a quarantine table for manual data quality review before warehouse loading.

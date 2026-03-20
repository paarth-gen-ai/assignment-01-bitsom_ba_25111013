-- ========================================
-- Data Warehouse Analytical Queries
-- Healthcare Analytics Domain
-- ========================================

-- Q1: Total sales revenue by product category for each month
SELECT
    d.Year,
    d.Month,
    d.MonthName,
    t.TreatmentName,
    t.Category AS ProductCategory,
    SUM(f.TotalAmount) AS TotalRevenue,
    COUNT(*) AS TransactionCount
FROM Fact_MedicalTransactions f
JOIN Dim_Date d ON f.DateKey = d.DateKey
JOIN Dim_Treatment t ON f.TreatmentKey = t.TreatmentKey
GROUP BY d.Year, d.Month, d.MonthName, t.TreatmentName, t.Category
ORDER BY d.Year, d.Month, TotalRevenue DESC;

-- Q2: Top 2 performing stores (doctors) by total revenue
SELECT
    doc.DoctorKey,
    doc.FirstName,
    doc.LastName,
    doc.Specialty,
    doc.HospitalName,
    SUM(f.TotalAmount) AS TotalRevenue,
    COUNT(*) AS TotalTransactions
FROM Fact_MedicalTransactions f
JOIN Dim_Doctor doc ON f.DoctorKey = doc.DoctorKey
GROUP BY doc.DoctorKey, doc.FirstName, doc.LastName, doc.Specialty, doc.HospitalName
ORDER BY TotalRevenue DESC
LIMIT 2;

-- Q3: Month-over-month sales trend across all stores
SELECT
    d.Year,
    d.Month,
    d.MonthName,
    SUM(f.TotalAmount) AS MonthlyRevenue,
    LAG(SUM(f.TotalAmount)) OVER (ORDER BY d.Year, d.Month) AS PreviousMonthRevenue,
    ROUND(
        (SUM(f.TotalAmount) - LAG(SUM(f.TotalAmount)) OVER (ORDER BY d.Year, d.Month)) * 100.0 /
        NULLIF(LAG(SUM(f.TotalAmount)) OVER (ORDER BY d.Year, d.Month), 0),
        2
    ) AS MoMGrowthPercent
FROM Fact_MedicalTransactions f
JOIN Dim_Date d ON f.DateKey = d.DateKey
GROUP BY d.Year, d.Month, d.MonthName
ORDER BY d.Year, d.Month;

-- ========================================
-- Data Warehouse Star Schema Design
-- Healthcare Analytics Domain
-- ========================================

-- DIMENSION TABLES

-- Dim_Patient
CREATE TABLE Dim_Patient (
    PatientKey INT PRIMARY KEY,
    PatientID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender VARCHAR(10),
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    InsuranceType VARCHAR(50),
    RegistrationDate DATE,
    IsActive BOOLEAN
);

-- Dim_Doctor
CREATE TABLE Dim_Doctor (
    DoctorKey INT PRIMARY KEY,
    DoctorID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialty VARCHAR(100),
    Department VARCHAR(100),
    HospitalName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    YearsOfExperience INT,
    Qualification VARCHAR(100),
    IsActive BOOLEAN
);

-- Dim_Diagnosis
CREATE TABLE Dim_Diagnosis (
    DiagnosisKey INT PRIMARY KEY,
    DiagnosisCode VARCHAR(20),
    DiagnosisName VARCHAR(200),
    Category VARCHAR(100),
    Severity VARCHAR(20),
    ICD10Code VARCHAR(20)
);

-- Dim_Treatment
CREATE TABLE Dim_Treatment (
    TreatmentKey INT PRIMARY KEY,
    TreatmentCode VARCHAR(20),
    TreatmentName VARCHAR(200),
    Category VARCHAR(100),
    StandardCost DECIMAL(10, 2),
    AverageDurationDays INT
);

-- Dim_Date
CREATE TABLE Dim_Date (
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    Day INT,
    Month INT,
    Year INT,
    Quarter INT,
    DayOfWeek VARCHAR(20),
    MonthName VARCHAR(20),
    IsHoliday BOOLEAN,
    IsWeekend BOOLEAN
);

-- FACT TABLE

-- Fact_MedicalTransactions
CREATE TABLE Fact_MedicalTransactions (
    TransactionKey INT PRIMARY KEY,
    PatientKey INT,
    DoctorKey INT,
    DiagnosisKey INT,
    TreatmentKey INT,
    DateKey INT,
    VisitType VARCHAR(50),
    VisitDurationMinutes INT,
    TreatmentCost DECIMAL(10, 2),
    ConsultationFee DECIMAL(10, 2),
    TotalAmount DECIMAL(10, 2),
    InsuranceClaimAmount DECIMAL(10, 2),
    PatientOutofPocket DECIMAL(10, 2),
    PaymentStatus VARCHAR(20),
    FOREIGN KEY (PatientKey) REFERENCES Dim_Patient(PatientKey),
    FOREIGN KEY (DoctorKey) REFERENCES Dim_Doctor(DoctorKey),
    FOREIGN KEY (DiagnosisKey) REFERENCES Dim_Diagnosis(DiagnosisKey),
    FOREIGN KEY (TreatmentKey) REFERENCES Dim_Treatment(TreatmentKey),
    FOREIGN KEY (DateKey) REFERENCES Dim_Date(DateKey)
);

-- SAMPLE DATA INSERTS

-- Dim_Date samples
INSERT INTO Dim_Date VALUES
(20250101, '2025-01-01', 1, 1, 2025, 1, 'Wednesday', 'January', TRUE, FALSE),
(20250102, '2025-01-02', 2, 1, 2025, 1, 'Thursday', 'January', FALSE, FALSE),
(20250103, '2025-01-03', 3, 1, 2025, 1, 'Friday', 'January', FALSE, FALSE);

-- Dim_Patient samples
INSERT INTO Dim_Patient VALUES
(1, 1001, 'John', 'Smith', '1975-05-15', 'Male', 'Mumbai', 'Maharashtra', '400001', 'Private', '2020-01-10', TRUE),
(2, 1002, 'Priya', 'Sharma', '1982-08-22', 'Female', 'Delhi', 'Delhi', '110001', 'Public', '2019-06-15', TRUE);

-- Dim_Doctor samples
INSERT INTO Dim_Doctor VALUES
(1, 501, 'Dr. Rajesh', 'Kumar', 'Cardiology', 'Cardiac Care', 'Apollo Hospital', 'Mumbai', 'Maharashtra', 15, 'MBBS, MD, DM', TRUE),
(2, 502, 'Dr. Anjali', 'Desai', 'Neurology', 'Neuro Sciences', 'Max Hospital', 'Delhi', 'Delhi', 10, 'MBBS, MD, DM', TRUE);

-- Dim_Diagnosis samples
INSERT INTO Dim_Diagnosis VALUES
(1, 'D001', 'Hypertension', 'Cardiovascular', 'Moderate', 'I10'),
(2, 'D002', 'Type 2 Diabetes', 'Endocrine', 'Moderate', 'E11');

-- Dim_Treatment samples
INSERT INTO Dim_Treatment VALUES
(1, 'T001', 'Cardiac Consultation', 'Consultation', 1500.00, 0),
(2, 'T002', 'Blood Sugar Test', 'Lab Test', 500.00, 0);

-- Fact_MedicalTransactions samples
INSERT INTO Fact_MedicalTransactions VALUES
(1, 1, 1, 1, 1, 20250101, 'OPD', 30, 1500.00, 500.00, 2000.00, 1500.00, 500.00, 'Paid'),
(2, 2, 2, 2, 2, 20250102, 'OPD', 25, 500.00, 400.00, 900.00, 0.00, 900.00, 'Pending');

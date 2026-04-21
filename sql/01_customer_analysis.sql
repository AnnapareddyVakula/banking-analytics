-- ============================================================
-- FILE: 01_customer_analysis.sql
-- PROJECT: Lending Club Banking Analytics
-- DESCRIPTION: Customer profile and loan volume analysis
-- AUTHOR: [Your Name]
-- DATE: 2024
-- ============================================================


-- ============================================================
-- QUERY 1: Overall loan volume summary
-- Business question: What is the overall size of our loan book?
-- ============================================================
SELECT
    COUNT(*)                          AS total_loans,
    ROUND(SUM(loan_amnt), 2)          AS total_loan_value,
    ROUND(AVG(loan_amnt), 2)          AS avg_loan_amount,
    ROUND(MIN(loan_amnt), 2)          AS min_loan_amount,
    ROUND(MAX(loan_amnt), 2)          AS max_loan_amount
FROM loans;


-- ============================================================
-- QUERY 2: Loan volume by year
-- Business question: How has lending grown year over year?
-- ============================================================
SELECT
    SUBSTR(issue_d, 1, 4)             AS year,
    COUNT(*)                          AS total_loans,
    ROUND(SUM(loan_amnt), 2)          AS total_value,
    ROUND(AVG(loan_amnt), 2)          AS avg_loan_amount
FROM loans
GROUP BY year
ORDER BY year;


-- ============================================================
-- QUERY 3: Loan volume by grade
-- Business question: What is our risk distribution by grade?
-- ============================================================
SELECT
    grade,
    COUNT(*)                          AS total_loans,
    ROUND(SUM(loan_amnt), 2)          AS total_value,
    ROUND(AVG(loan_amnt), 2)          AS avg_loan_amount,
    ROUND(AVG(int_rate), 2)           AS avg_interest_rate
FROM loans
GROUP BY grade
ORDER BY grade;


-- ============================================================
-- QUERY 4: Loan volume by purpose
-- Business question: Why are customers borrowing?
-- ============================================================
SELECT
    purpose,
    COUNT(*)                          AS total_loans,
    ROUND(SUM(loan_amnt), 2)          AS total_value,
    ROUND(AVG(loan_amnt), 2)          AS avg_loan_amount,
    ROUND(AVG(int_rate), 2)           AS avg_interest_rate
FROM loans
GROUP BY purpose
ORDER BY total_loans DESC;


-- ============================================================
-- QUERY 5: Borrower profile by home ownership
-- Business question: Do homeowners borrow differently?
-- ============================================================
SELECT
    home_ownership,
    COUNT(*)                          AS total_loans,
    ROUND(AVG(loan_amnt), 2)          AS avg_loan_amount,
    ROUND(AVG(annual_inc), 2)         AS avg_annual_income,
    ROUND(AVG(int_rate), 2)           AS avg_interest_rate,
    ROUND(AVG(dti), 2)                AS avg_debt_to_income
FROM loans
GROUP BY home_ownership
ORDER BY total_loans DESC;


-- ============================================================
-- QUERY 6: Top 10 states by loan volume
-- Business question: Where are our customers located?
-- ============================================================
SELECT
    addr_state                        AS state,
    COUNT(*)                          AS total_loans,
    ROUND(SUM(loan_amnt), 2)          AS total_value,
    ROUND(AVG(loan_amnt), 2)          AS avg_loan_amount
FROM loans
GROUP BY state
ORDER BY total_loans DESC
LIMIT 10;


-- ============================================================
-- QUERY 7: Employment length vs loan amount
-- Business question: Do longer employed borrowers get bigger loans?
-- ============================================================
SELECT
    emp_length                        AS employment_years,
    COUNT(*)                          AS total_loans,
    ROUND(AVG(loan_amnt), 2)          AS avg_loan_amount,
    ROUND(AVG(annual_inc), 2)         AS avg_annual_income,
    ROUND(AVG(int_rate), 2)           AS avg_interest_rate
FROM loans
WHERE emp_length IS NOT NULL
GROUP BY employment_years
ORDER BY employment_years;
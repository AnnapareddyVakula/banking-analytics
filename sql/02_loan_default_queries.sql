-- ============================================================
-- FILE: 02_loan_default_queries.sql
-- PROJECT: Lending Club Banking Analytics
-- DESCRIPTION: Loan default and risk analysis
-- AUTHOR: [Your Name]
-- DATE: 2024
-- ============================================================


-- ============================================================
-- QUERY 1: Default rate overall
-- Business question: What percentage of loans defaulted?
-- ============================================================
SELECT
    loan_status,
    COUNT(*)                              AS total_loans,
    ROUND(COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER(), 2)          AS percentage
FROM loans
GROUP BY loan_status
ORDER BY total_loans DESC;


-- ============================================================
-- QUERY 2: Default rate by grade
-- Business question: Which loan grades carry the most default risk?
-- ============================================================
SELECT
    grade,
    COUNT(*)                              AS total_loans,
    SUM(CASE WHEN loan_status = 'Defaulted'
        THEN 1 ELSE 0 END)                AS defaulted_loans,
    ROUND(SUM(CASE WHEN loan_status = 'Defaulted'
        THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2)                    AS default_rate_pct
FROM loans
GROUP BY grade
ORDER BY grade;


-- ============================================================
-- QUERY 3: Default rate by purpose
-- Business question: Which loan purposes default most?
-- ============================================================
SELECT
    purpose,
    COUNT(*)                              AS total_loans,
    SUM(CASE WHEN loan_status = 'Defaulted'
        THEN 1 ELSE 0 END)                AS defaulted_loans,
    ROUND(SUM(CASE WHEN loan_status = 'Defaulted'
        THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2)                    AS default_rate_pct
FROM loans
GROUP BY purpose
ORDER BY default_rate_pct DESC;


-- ============================================================
-- QUERY 4: Default rate by home ownership
-- Business question: Do renters default more than homeowners?
-- ============================================================
SELECT
    home_ownership,
    COUNT(*)                              AS total_loans,
    SUM(CASE WHEN loan_status = 'Defaulted'
        THEN 1 ELSE 0 END)                AS defaulted_loans,
    ROUND(SUM(CASE WHEN loan_status = 'Defaulted'
        THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2)                    AS default_rate_pct,
    ROUND(AVG(annual_inc), 2)            AS avg_annual_income
FROM loans
GROUP BY home_ownership
ORDER BY default_rate_pct DESC;


-- ============================================================
-- QUERY 5: Default rate by term
-- Business question: Do longer term loans default more?
-- ============================================================
SELECT
    term                                  AS loan_term_months,
    COUNT(*)                              AS total_loans,
    SUM(CASE WHEN loan_status = 'Defaulted'
        THEN 1 ELSE 0 END)                AS defaulted_loans,
    ROUND(SUM(CASE WHEN loan_status = 'Defaulted'
        THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2)                    AS default_rate_pct
FROM loans
GROUP BY term
ORDER BY term;


-- ============================================================
-- QUERY 6: High risk loans
-- Business question: Which loans should we flag for review?
-- ============================================================
SELECT
    grade,
    purpose,
    loan_amnt,
    int_rate,
    dti,
    annual_inc,
    loan_status
FROM loans
WHERE
    grade IN ('E', 'F', 'G')
    AND dti > 30
    AND loan_status = 'Defaulted'
ORDER BY loan_amnt DESC
LIMIT 20;


-- ============================================================
-- QUERY 7: Average loss from defaults
-- Business question: How much money was lost to defaults?
-- ============================================================
SELECT
    grade,
    COUNT(*)                              AS defaulted_loans,
    ROUND(AVG(loan_amnt), 2)             AS avg_loan_amount,
    ROUND(SUM(loan_amnt), 2)             AS total_loaned,
    ROUND(SUM(total_pymnt), 2)           AS total_recovered,
    ROUND(SUM(loan_amnt) -
        SUM(total_pymnt), 2)             AS estimated_loss
FROM loans
WHERE loan_status = 'Defaulted'
GROUP BY grade
ORDER BY estimated_loss DESC;
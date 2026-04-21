-- ============================================================
-- FILE: 03_risk_segmentation.sql
-- PROJECT: Lending Club Banking Analytics
-- DESCRIPTION: Borrower risk scoring and segmentation
-- AUTHOR: [Your Name]
-- DATE: 2024
-- ============================================================


-- ============================================================
-- QUERY 1: Risk segmentation using CASE WHEN
-- Business question: How do we categorize borrowers by risk?
-- ============================================================
SELECT
    CASE
        WHEN grade IN ('A', 'B')        THEN 'Low Risk'
        WHEN grade IN ('C', 'D')        THEN 'Medium Risk'
        WHEN grade IN ('E', 'F', 'G')   THEN 'High Risk'
    END                                   AS risk_category,
    COUNT(*)                              AS total_loans,
    ROUND(AVG(loan_amnt), 2)             AS avg_loan_amount,
    ROUND(AVG(int_rate), 2)              AS avg_interest_rate,
    ROUND(AVG(dti), 2)                   AS avg_dti,
    ROUND(SUM(CASE WHEN loan_status = 'Defaulted'
        THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2)                    AS default_rate_pct
FROM loans
GROUP BY risk_category
ORDER BY default_rate_pct;


-- ============================================================
-- QUERY 2: DTI risk bands
-- Business question: Does high debt-to-income predict default?
-- ============================================================
SELECT
    CASE
        WHEN dti < 10               THEN '0-10% DTI'
        WHEN dti BETWEEN 10 AND 20  THEN '10-20% DTI'
        WHEN dti BETWEEN 20 AND 30  THEN '20-30% DTI'
        WHEN dti > 30               THEN '30%+ DTI'
    END                               AS dti_band,
    COUNT(*)                          AS total_loans,
    ROUND(AVG(loan_amnt), 2)         AS avg_loan_amount,
    ROUND(SUM(CASE WHEN loan_status = 'Defaulted'
        THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2)                AS default_rate_pct
FROM loans
WHERE dti IS NOT NULL
GROUP BY dti_band
ORDER BY default_rate_pct;


-- ============================================================
-- QUERY 3: Income segments
-- Business question: How does income affect borrowing behavior?
-- ============================================================
SELECT
    CASE
        WHEN annual_inc < 40000             THEN 'Under $40K'
        WHEN annual_inc BETWEEN 40000
            AND 75000                       THEN '$40K-$75K'
        WHEN annual_inc BETWEEN 75000
            AND 120000                      THEN '$75K-$120K'
        WHEN annual_inc > 120000            THEN 'Over $120K'
    END                                     AS income_band,
    COUNT(*)                                AS total_loans,
    ROUND(AVG(loan_amnt), 2)               AS avg_loan_amount,
    ROUND(AVG(int_rate), 2)                AS avg_interest_rate,
    ROUND(SUM(CASE WHEN loan_status = 'Defaulted'
        THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2)                      AS default_rate_pct
FROM loans
GROUP BY income_band
ORDER BY default_rate_pct;


-- ============================================================
-- QUERY 4: Full risk score per borrower segment
-- Business question: Which combination of factors predicts default?
-- ============================================================
SELECT
    CASE
        WHEN grade IN ('A','B')
            AND dti < 20
            AND annual_inc > 75000      THEN 'Very Low Risk'
        WHEN grade IN ('C','D')
            AND dti BETWEEN 20 AND 30   THEN 'Moderate Risk'
        WHEN grade IN ('E','F','G')
            AND dti > 30               THEN 'Very High Risk'
        ELSE                               'Standard Risk'
    END                                   AS risk_score,
    COUNT(*)                              AS total_loans,
    ROUND(AVG(loan_amnt), 2)             AS avg_loan_amount,
    ROUND(AVG(int_rate), 2)              AS avg_interest_rate,
    ROUND(SUM(CASE WHEN loan_status = 'Defaulted'
        THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2)                    AS default_rate_pct
FROM loans
GROUP BY risk_score
ORDER BY default_rate_pct;
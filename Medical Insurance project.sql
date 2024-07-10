Create database Insurance ;



-- Q1 Select all coloumns for all patients ? 
SELECT * FROM insurance_data;

-- Q2 Display the average claim amount for patients in each region ? 
SELECT 
    region, AVG(claim)
FROM
    insurance_data
GROUP BY region;


-- Q3 Select the maximum and minimum BMI values in the table ? 
SELECT 
    MAX(bmi) AS Min_bmivalue, MIN(bmi) AS Min_bmivalue
FROM
    insurance_data;

-- Q4 	Select the patientid ,age and BMI for patients with a BMI between 40 and 50 . 
Select Patientid, age,bmi 
from insurance_data
where bmi 
between 40 and 50 ;

-- Q5  Select the number of smokers in each region ? 

SELECT 
    Region, COUNT(smoker) AS 'smoker'
FROM
    insurance_data
WHERE
    smoker = 'yes'
GROUP BY region;

-- Q6 What is the average claim amount for patients who are both diabetic and smokers ? 
SELECT 
    AVG(claim)
FROM
    insurance_data
WHERE
    Diabetic = 'Yes' AND Smoker = 'yes'
GROUP BY diabetic , smoker;	

-- Q7 Retreive all patients who have a  BMI greater than the average BMI of patients who are smokers ? 
SELECT 
    *
FROM
    insurance_data
WHERE
    bmi > (SELECT 
            AVG(bmi)
        FROM
            insurance_data
        WHERE
            smoker = 'Yes');

-- Q8 Select the average claim amount for patients in each age group ?

SELECT 
    CASE
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 30 THEN '18-30'
        WHEN age BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'over 50'
    END AS age_group,
    round(AVG(claim),2) AS Avg_claim
FROM
    insurance_data
GROUP BY age_group; 

-- Q 9 	Retrieve the total claim amount for each patient ,along with the average claim amount across all patients ?

select *,sum(claim) over(partition by PatientID) as total_claim,
avg(claim) over() as avg_claim from insurance_data;

-- Q 10 Retrieve the top 3 patients with the highest claim amount, along with their 
-- respective claim amounts and the total claim amount for all patients.

Select patientID,claim, Sum(claim) over() as totalclaim from insurance_data 
order by claim
Desc 
limit 3 ;


-- 11 Select the details of patients who have a claim amount 
-- greater than the average claim amount for their region ? 

select * from (select *, avg(claim)  over(partition by region) 
as avg_claim from insurance_data) as subquery
where claim > avg_claim;

-- 12. Retrieve the rank of each patient based on their claim amount.

Select * ,rank()  over(order by claim 
desc  ) as 'rank'  from insurance_data;

-- -- 13. Select the details of patients along with their claim amount, 
-- and their rank based on claim amount within their region.

select *, rank() over(partition by region order by claim desc) as 'Rank' from insurance_data;


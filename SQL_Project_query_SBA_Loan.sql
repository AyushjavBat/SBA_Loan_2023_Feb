
SELECT 
	SBADistrictOffice, 
	BankName, 
	FranchiseName, 
	ApprovalFiscalYear, 
	Program, 
	PaidInFullDate, 
	LoanStatus
FROM dbo.SBA_LOAN_DATA;

SELECT 
    SBADistrictOffice, 
    SUM(CAST(GrossApproval AS DECIMAL(18, 2))) AS TotalLoanAmount
FROM dbo.SBA_LOAN_DATA
GROUP BY SBADistrictOffice;

SELECT 
    SBADistrictOffice, 
    SUM(CAST(GrossApproval AS DECIMAL(18, 2))) AS TotalLoanAmount
FROM dbo.SBA_LOAN_DATA
GROUP BY SBADistrictOffice
HAVING SUM(CAST(GrossApproval AS DECIMAL(18, 2))) IS NOT NULL;

SELECT 
    SUM(CAST(GrossApproval AS DECIMAL(18, 2))) AS TotalLoanAmount
FROM dbo.SBA_LOAN_DATA
WHERE GrossApproval IS NOT NULL;

--Validation

SELECT 
    SBADistrictOffice,
    COUNT(*) AS RecordCount,
    SUM(CAST(GrossApproval AS DECIMAL(18, 2))) AS TotalLoanAmount
FROM dbo.SBA_LOAN_DATA
WHERE GrossApproval IS NULL
GROUP BY SBADistrictOffice;



SELECT   
    SBADistrictOffice,     
    SUM(CAST(GrossApproval AS DECIMAL(18, 2))) AS TotalLoanAmount
FROM dbo.SBA_LOAN_DATA
WHERE GrossApproval IS NULL
GROUP BY SBADistrictOffice;

SELECT 
	SUM(CAST(GrossApproval AS DECIMAL(18, 2))) AS TotalLoanAmount
FROM dbo.SBA_LOAN_DATA
WHERE SBADistrictOffice = 'ALABAMA DISTRICT OFFICE';



/*
•	Top 5 Banks with the Highest Gross Approval Amount:
		•	Formulate a SQL query to identify the top 5 banks with the highest gross approval amounts.
		*/
SELECT * FROM [dbo].[SBA_LOAN_DATA];

SELECT TOP 5 BankName,
       SUM(CAST (GrossApproval AS DECIMAL(18, 2))) AS TotalGrossApproval
FROM [dbo].[SBA_LOAN_DATA]
GROUP BY BankName
ORDER BY TotalGrossApproval DESC;

--Validation

SELECT TOP 1 BankName,
       SUM(CAST (GrossApproval AS DECIMAL(18, 2))) AS TotalGrossApproval
FROM [dbo].[SBA_LOAN_DATA]
GROUP BY BankName
ORDER BY TotalGrossApproval DESC;

/*
Top 10 Franchises with the Most Approved Loans:
		•	Create a SQL query to determine the top 10 franchises with the most approved loans.

*/
SELECT * FROM [dbo].[SBA_LOAN_DATA]

--Issue (name is null) 170,988 customers
SELECT 
    FranchiseName, 
    COUNT(*) AS Record_Franchise_Name_Count
FROM [dbo].[SBA_LOAN_DATA]
WHERE FranchiseName IS NULL
GROUP BY FranchiseName;

---Not null top 10
SELECT count(*), 
    FranchiseName,
    SUM(CAST(GrossApproval AS DECIMAL(18, 2))) AS TotalGrossApproval
FROM [dbo].[SBA_LOAN_DATA]
WHERE FranchiseName IS NOT NULL
GROUP BY FranchiseName
ORDER BY 1 desc




/*	•	Calculate Total Gross Approval for Each Year and Program:
		•	Devise a SQL query to calculate the total gross approval for each year and program.*/

SELECT YEAR(ApprovalDate) AS Year,
		Program,
		SUM(CAST(GrossApproval AS DECIMAL(18, 2))) AS TotalGrossApproval
FROM [dbo].[SBA_LOAN_DATA]
GROUP BY YEAR(ApprovalDate), Program;


SELECT YEAR(ApprovalDate) AS Year,subpgmdesc, 
		
		SUM(CAST(GrossApproval AS DECIMAL(18, 2))) AS TotalGrossApproval
FROM [dbo].[SBA_LOAN_DATA]
GROUP BY YEAR(ApprovalDate), subpgmdesc;


/*
•	Total Percentage of PaidInFullDate and Not Paid Full:

		•	Construct a SQL query to determine the total percentage breakdown of loans based on 
			their payment status.
*/
	
	SELECT * FROM [dbo].[SBA_LOAN_DATA]
/*	
SELECT 
    CASE 
        WHEN PaidInFullDate IS NOT NULL THEN 'PaidInFull'
        ELSE 'NotPaidInFull' 
    END AS PaymentStatus,
    COUNT(*) AS LoanCount,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM dbo.SBA_LOAN_DATA) AS DECIMAL(5,2)) AS Percentage
FROM 
    dbo.SBA_LOAN_DATA
GROUP BY 
    CASE 
        WHEN PaidInFullDate IS NOT NULL THEN 'PaidInFull'
        ELSE 'NotPaidInFull' 
    END;*/
SELECT
    LoanStatus,
     COUNT(*) AS LoanCount,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM dbo.SBA_LOAN_DATA) AS DECIMAL(18,2)) AS Percentage
FROM
    [dbo].[SBA_LOAN_DATA]
GROUP BY
    LoanStatus
ORDER BY
    Percentage DESC;


/*
2. Generate CSV or Flat File Reports using SSIS:

Utilize SSIS package to generate CSV or flat file reports containing the results of the query analysis.

Configure SSIS packages to export data into a user-friendly file format.


3. Send Reports to Stakeholders via Email:

Compose an email to stakeholders, attaching the generated CSV or flat files.

Provide a brief explanation of the data included in the reports and highlight any significant insights. 

Email to:


4. Create Tableau Report using SBA loan data:

Import the SBA loan data into Tableau.

Create visualizations, charts, and graphs to present key insights interactively.

Good luck with your SBA loan data analysis project!
*/
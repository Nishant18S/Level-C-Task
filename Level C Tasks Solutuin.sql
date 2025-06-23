-- Q1
SELECT 
    EmployeeID, 
    CONCAT(FirstName, ' ', LastID) AS FullName, 
    Salary
FROM 
    Employees;

-- Q2
SELECT 
    ReportsTo AS ManagerID, 
    COUNT(*) AS EmployeeCount
FROM 
    Employees
WHERE ReportsTo IS NOT NULL
GROUP BY 
    ReportsTo;

-- Q3
SELECT 
    EmployeeID, FirstName, LastID, Salary
FROM 
    Employees
WHERE 
    Salary = (SELECT MAX(Salary) FROM Employees);

-- Q4
SELECT 
    AVG(Salary) AS AverageSalary
FROM 
    Employees;

-- Q5
SELECT 
    EmployeeID, FirstName, LastID, Salary
FROM 
    Employees
WHERE 
    Salary > (SELECT AVG(Salary) FROM Employees);

-- Q7
SELECT 
    EmployeeID, FirstName, LastID, ReportsTo
FROM 
    Employees
WHERE 
    ReportsTo IS NOT NULL;

-- Q8
SELECT 
    EmployeeID, FirstName, LastID
FROM 
    Employees
WHERE 
    ReportsTo IS NULL;
-- Q9
SELECT TOP 1 
    ReportsTo AS ManagerID, 
    COUNT(*) AS ReporteeCount
FROM 
    Employees
WHERE ReportsTo IS NOT NULL
GROUP BY 
    ReportsTo
ORDER BY 
    ReporteeCount DESC;
-- Q10
SELECT 
    E.EmployeeID, 
    CONCAT(E.FirstName, ' ', E.LastID) AS EmployeeName,
    CONCAT(M.FirstName, ' ', M.LastID) AS ManagerName
FROM 
    Employees E
LEFT JOIN 
    Employees M ON E.ReportsTo = M.EmployeeID;
-- Q11
SELECT 
    E1.EmployeeID, E1.FirstName, E1.LastID, E1.Salary
FROM 
    Employees E1
WHERE EXISTS (
    SELECT 1 
    FROM Employees E2 
    WHERE E2.EmployeeID != E1.EmployeeID 
      AND E2.Salary = E1.Salary
);
-- Q12
SELECT 
    ReportsTo AS ManagerID, 
    MAX(Salary) AS MaxSalary
FROM 
    Employees
WHERE ReportsTo IS NOT NULL
GROUP BY 
    ReportsTo;
-- Q13
SELECT 
    EmployeeID, FirstName, LastID
FROM 
    Employees
WHERE 
    ReportsTo IS NULL;
-- Q14
SELECT 
    RIGHT(CAST(LastID AS VARCHAR), 1) AS LastDigit,
    COUNT(*) AS CountByDigit
FROM 
    Employees
GROUP BY 
    RIGHT(CAST(LastID AS VARCHAR), 1);
-- Q15
SELECT 
    EmployeeID, FirstName
FROM 
    Employees
WHERE 
    LOWER(LEFT(FirstName, 1)) = LOWER(RIGHT(FirstName, 1));
-- Q16
SELECT 
    ReportsTo AS ManagerID, 
    COUNT(*) AS NumReportees
FROM 
    Employees
WHERE ReportsTo IS NOT NULL
GROUP BY 
    ReportsTo
HAVING COUNT(*) > 2;
-- Q17
SELECT 
    EmployeeID, FirstName, LastID, Salary
FROM 
    Employees
WHERE 
    Salary = (
        SELECT MAX(Salary) 
        FROM Employees 
        WHERE Salary < (SELECT MAX(Salary) FROM Employees)
    );
-- Q18
SELECT 
    EmployeeID, FirstName, LastID
FROM 
    Employees
WHERE 
    EmployeeID % 2 = 0;
-- Q19
SELECT 
    EmployeeID, FirstName
FROM 
    Employees
WHERE 
    LOWER(FirstName) = REVERSE(LOWER(FirstName));
-- Q20
SELECT 
    EmployeeID, FirstName, LastID, Salary
FROM 
    Employees
ORDER BY 
    Salary DESC;

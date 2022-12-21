-- 1. Retrieve the names of the dependents that have employee relatives working in the research department.
SELECT dependent_name AS 'Dependents of Research Dept Employees'
FROM DEPENDENT p
WHERE essn IN (SELECT ssn
			   FROM DEPARTMENT d INNER JOIN EMPLOYEE e
			   ON e.dno = d.dnumber
			   AND p.essn = e.ssn
			   AND d.dname = 'Research');

-- 2. Retrieve the maximum salary of the employees working on the project that is located in ‘Zamalek’.
SELECT salary AS 'Max salary of employees working on projects in Houston'
FROM EMPLOYEE e
WHERE ssn IN (SELECT wo.essn
			  FROM WORKS_ON wo INNER JOIN PROJECT p
			  ON wo.pno = p.pnumber
			  AND p.plocation = 'Houston'
			  AND e.ssn = wo.essn);

-- 3. Retrieve the name of the project having the maximum number of hours.
SELECT pname, hours
FROM PROJECT p INNER JOIN WORKS_ON wo
ON p.pnumber = wo.pno
WHERE wo.hours = (SELECT MAX(hours)
						FROM WORKS_ON);

-- 4. Retrieve the department names where the working employees have female dependents.
SELECT dname
FROM DEPARTMENT d
WHERE d.dnumber IN (SELECT dno
					FROM EMPLOYEE e
					WHERE d.dnumber = e.dno AND e.sex = 'F');

-- 5. Retrieve the names of the employees who live in the same location as that of their project. Display the project names and the locations as well.
SELECT fname + ' ' + lname AS 'Full name', pname, plocation
FROM ((EMPLOYEE e INNER JOIN WORKS_ON wo
ON e.ssn = wo.essn) INNER JOIN PROJECT p
ON p.pnumber = wo.pno)
WHERE E.address LIKE '%' + p.plocation + '%';		  
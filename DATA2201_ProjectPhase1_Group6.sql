----------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------- CREATE DATABASE --------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------
GO
USE master

IF EXISTS (SELECT name FROM sys.databases WHERE name = 'SksNationalBank')
	DROP DATABASE SksNationalBank

CREATE DATABASE SksNationalBank
GO
USE SksNationalBank


----------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------- CREATE TABLES ---------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------- REGULAR TABLES -----------------------------------------------------------------
CREATE TABLE Customers (
	customer_id INT IDENTITY PRIMARY KEY,
	customer_name VARCHAR(50),
	customer_home_address VARCHAR(50)
)

CREATE TABLE Employees (
	employee_id INT IDENTITY PRIMARY KEY,
	manager_id INT FOREIGN KEY REFERENCES Employees(employee_id),
	start_date DATE,
	length_employment_days INT,
	employee_name VARCHAR(50),
	employee_address VARCHAR(50)
)

CREATE TABLE Branches (
	branch_id INT IDENTITY PRIMARY KEY,
	branch_name VARCHAR(50),
	branch_city VARCHAR(50)
)

CREATE TABLE Loans (
	loan_id INT IDENTITY PRIMARY KEY,
	branch_id INT FOREIGN KEY REFERENCES Branches(branch_id),
	amount_total FLOAT
)

CREATE TABLE Accounts (
	account_id INT IDENTITY PRIMARY KEY,
	branch_id INT FOREIGN KEY REFERENCES Branches(branch_id),
	balance FLOAT,
	most_recent_activity DATETIME,
	interest_rate FLOAT,
	is_overdrafted BIT,
	account_type VARCHAR(50)
)

----------------------------------------------------- BRIDGE TABLES -----------------------------------------------------------------
CREATE TABLE FinancialAdvisor (
	financial_advisor_id INT IDENTITY PRIMARY KEY,
	customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
	employee_id INT FOREIGN KEY REFERENCES Employees(employee_id),
	advisor_type VARCHAR(50)
)

CREATE TABLE EmploymentRole (
	employment_role_id INT IDENTITY PRIMARY KEY,
	branch_id INT FOREIGN KEY REFERENCES Branches(branch_id),
	employee_id INT FOREIGN KEY REFERENCES Employees(employee_id),
	role VARCHAR(50)
)

CREATE TABLE LoanTransactions (
	loan_transaction_id INT IDENTITY PRIMARY KEY,
	loan_id INT FOREIGN KEY REFERENCES Loans(loan_id),
	customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
	date_transaction DATETIME,
	amount_transaction FLOAT
)

CREATE TABLE RegularTransactions (
	regular_transaction_id INT IDENTITY PRIMARY KEY,
	account_id INT FOREIGN KEY REFERENCES Accounts(account_id),
	customer_id INT FOREIGN KEY REFERENCES Customers(customer_id),
	date_transaction DATETIME,
	is_transaction_in_overdraft BIT,
	amount_in_overdraft FLOAT,
	amount_transaction FLOAT
)


----------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------- POPULATE TABLES --------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------ POPULATE REGULAR TABLES ------------------------------------------------------------
INSERT INTO Customers (customer_name, customer_home_address)
VALUES
    ('John Smith', '123 Main St'),
    ('Jane Doe', '456 Elm St'),
    ('Mike Johnson', '789 Oak St'),
    ('Sarah Williams', '101 Pine St'),
    ('Robert Davis', '202 Cedar St'),
    ('Emily Wilson', '303 Maple St'),
    ('Daniel Brown', '404 Birch St'),
    ('Linda Lee', '505 Walnut St'),
    ('Chris Evans', '606 Spruce St'),
    ('Olivia White', '707 Redwood St'),
    ('Mark Taylor', '808 Fir St'),
    ('Ava Thomas', '909 Sequoia St'),
    ('William Hall', '111 Sycamore St'),
    ('Sophia Clark', '222 Red Oak St'),
    ('James Martinez', '333 White Oak St'),
    ('Chloe Anderson', '444 Black Oak St'),
    ('Matthew Harris', '555 Blue Oak St'),
    ('Ella Lewis', '666 Green Oak St'),
    ('Andrew Walker', '777 Yellow Oak St'),
    ('Grace Wright', '888 Purple Oak St');

INSERT INTO Employees (manager_id, start_date, length_employment_days, employee_name, employee_address)
VALUES
    (NULL, '2022-01-10', 300, 'David Johnson', '123 Manager Ave'),
    (1, '2022-02-15', 280, 'Susan Wilson', '456 Employee St'),
    (1, '2022-03-20', 260, 'Kevin Brown', '789 Employee St'),
    (2, '2022-04-25', 240, 'Anna Taylor', '101 Employee St'),
    (2, '2022-05-30', 220, 'Paula Evans', '202 Employee St'),
    (3, '2022-06-05', 200, 'George Martinez', '303 Employee St'),
    (3, '2022-07-10', 180, 'Nancy Anderson', '404 Employee St'),
    (4, '2022-08-15', 160, 'Brian Harris', '505 Employee St'),
    (4, '2022-09-20', 140, 'Carol Lewis', '606 Employee St'),
    (5, '2022-10-25', 120, 'Tom Walker', '707 Employee St'),
    (5, '2022-11-30', 100, 'Lily Wright', '808 Employee St'),
    (6, '2022-12-05', 80, 'Edward Smith', '909 Employee St'),
    (6, '2023-01-10', 60, 'Oliver Doe', '111 Employee St'),
    (7, '2023-02-15', 40, 'Mia Johnson', '222 Employee St'),
    (7, '2023-03-20', 20, 'Leo Williams', '333 Employee St');

INSERT INTO Branches (branch_name, branch_city)
VALUES
    ('Downtown', 'New York'),
    ('Uptown', 'New York'),
    ('Midtown', 'New York'),
    ('Downtown', 'Los Angeles'),
    ('Uptown', 'Los Angeles'),
    ('Downtown', 'Chicago'),
    ('Uptown', 'Chicago'),
    ('Downtown', 'San Francisco'),
    ('Uptown', 'San Francisco'),
    ('Downtown', 'Miami'),
    ('Uptown', 'Miami'),
    ('Downtown', 'Houston'),
    ('Uptown', 'Houston'),
    ('Downtown', 'Dallas'),
    ('Uptown', 'Dallas');

INSERT INTO Loans (branch_id, amount_total)
VALUES
    (1, 50000.00),
    (2, 75000.00),
    (4, 60000.00),
    (5, 45000.00),
    (6, 55000.00),
    (7, 40000.00),
    (8, 65000.00),
    (9, 70000.00),
    (10, 80000.00),
    (11, 90000.00),
    (12, 100000.00),
    (13, 110000.00),
    (14, 120000.00),
    (15, 130000.00);

INSERT INTO Accounts (branch_id, balance, most_recent_activity, interest_rate, is_overdrafted, account_type)
VALUES
    (1, 5000.00, '2023-10-10 09:15:00', 0.02, 0, 'Savings'),
    (2, 7500.00, '2023-10-11 11:30:00', NULL, 0, 'Checking'),
    (4, 600.00, '2023-10-10 14:45:00', NULL, 1, 'Checking'),
    (5, 45000.00, '2023-10-12 10:20:00', 0.02, 0, 'Savings'),
    (6, 5500.00, '2023-10-13 13:10:00', NULL, 0, 'Checking'),
    (7, 4000.00, '2023-10-11 16:55:00', NULL, 1, 'Checking'),
    (8, 65000.00, '2023-10-14 09:25:00', 0.02, 0, 'Savings'),
    (9, 7000.00, '2023-10-10 15:30:00', NULL, 0, 'Checking'),
    (10, 8000.00, '2023-10-12 18:40:00', 0.03, 0, 'Savings'),
    (11, 900.00, '2023-10-11 11:15:00', NULL, 1, 'Checking'),
    (12, 10000.00, '2023-10-13 10:50:00', 0.015, 0, 'Savings'),
    (13, 11000.00, '2023-10-10 12:55:00', 0.03, 0, 'Savings'),
    (14, 1200.00, '2023-10-11 09:30:00', NULL, 1, 'Checking'),
    (15, 13000.00, '2023-10-14 08:15:00', 0.015, 0, 'Savings');


------------------------------------------------- POPULATE BRIDGE TABLES ------------------------------------------------------------
INSERT INTO FinancialAdvisor (customer_id, employee_id, advisor_type)
VALUES
    (1, 2, 'Savings Advisor'),
    (2, 3, 'Investment Advisor'),
    (3, 4, 'Savings Advisor'),
    (4, 5, 'Investment Advisor'),
    (5, 6, 'Savings Advisor'),
    (6, 7, 'Investment Advisor'),
    (7, 8, 'Savings Advisor'),
    (8, 9, 'Investment Advisor'),
    (9, 10, 'Savings Advisor'),
    (10, 11, 'Investment Advisor');

INSERT INTO EmploymentRole (branch_id, employee_id, role)
VALUES
    (1, 2, 'Manager'),
    (1, 3, 'Teller'),
    (2, 4, 'Manager'),
    (2, 5, 'Teller'),
    (4, 6, 'Manager'),
    (4, 7, 'Teller'),
    (5, 8, 'Manager'),
    (5, 9, 'Teller'),
    (6, 10, 'Manager'),
    (6, 11, 'Teller');

INSERT INTO LoanTransactions (loan_id, customer_id, date_transaction, amount_transaction)
VALUES
    (1, 1, '2023-10-15 10:00:00', 10000.00),
    (2, 2, '2023-10-16 11:30:00', 15000.00),
    (4, 3, '2023-10-17 14:45:00', 12000.00),
    (5, 4, '2023-10-18 10:20:00', 9000.00),
    (6, 5, '2023-10-19 13:10:00', 11000.00),
    (7, 6, '2023-10-20 16:55:00', 8000.00),
    (8, 7, '2023-10-21 09:25:00', 13000.00),
    (9, 8, '2023-10-22 15:30:00', 14000.00),
    (10, 9, '2023-10-23 18:40:00', 16000.00),
    (11, 10, '2023-10-24 11:15:00', 18000.00);

INSERT INTO RegularTransactions (account_id, customer_id, date_transaction, is_transaction_in_overdraft, amount_in_overdraft, amount_transaction)
VALUES
    (1, 1, '2023-10-25 09:15:00', 0, 0.00, 200.00),
    (2, 1, '2023-10-26 11:30:00', 0, 0.00, 100.00),
    (2, 3, '2023-10-27 14:45:00', 1, 50.00, 300.00),
    (4, 4, '2023-10-28 10:20:00', 0, 0.00, 400.00),
    (5, 5, '2023-10-29 13:10:00', 0, 0.00, 150.00),
    (6, 6, '2023-10-30 16:55:00', 1, 30.00, 250.00),
    (7, 7, '2023-10-31 09:25:00', 0, 0.00, 350.00),
    (8, 8, '2023-11-01 15:30:00', 0, 0.00, 200.00),
    (9, 9, '2023-11-02 18:40:00', 0, 0.00, 100.00),
    (10, 10, '2023-11-03 11:15:00', 1, 25.00, 300.00);


----------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------- CREATE STORED PROCEDURES ----------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------

/* User Story 1
 * As a bank manager, I want to retrieve detailed information about a specific customer identified by their customer ID so that I can quickly access their
 * contact information and other customer-specific details.
 */
GO
CREATE PROCEDURE GetCustomerInformation (@customerID INT)
AS
BEGIN
    SELECT * FROM Customers WHERE customer_id = @customerID;
END;


/* User Story 2
 * As a bank manager, I need a way to list all the accounts associated with a particular customer identified by their customer ID so that I can see their 
 * account details and financial activity.
 */
GO
CREATE PROCEDURE ListCustomerAccountsUsingBridge(@customerID INT)
AS
BEGIN
    SELECT DISTINCT A.*
    FROM Accounts A
    JOIN RegularTransactions RT ON A.account_id = RT.account_id
    WHERE RT.customer_id = @customerID;
END;


/* User Story 3
 * As a bank manager, I want to calculate and display the total account balance for a specific customer identified by their customer ID to understand their 
 * overall financial standing with the bank.
 */
GO
CREATE PROCEDURE GetCustomerTotalBalanceUsingBridge(@customerID INT)
AS
BEGIN
    SELECT SUM(A.balance) AS TotalBalance
    FROM Accounts A
    JOIN RegularTransactions RT ON A.account_id = RT.account_id
    WHERE RT.customer_id = @customerID;
END;


 /* User Story 4
 * As a bank manager, I would like to view the most recent financial transactions for a particular customer, identified by their customer ID, to monitor their
 * recent financial activities.
 */
GO
CREATE PROCEDURE GetCustomerRecentTransactions(@customerID INT)
AS
BEGIN
    SELECT * FROM RegularTransactions WHERE customer_id = @customerID ORDER BY date_transaction DESC;
END;


 /* User Story 5
 * As a bank manager, I need to identify the financial advisor responsible for guiding a specific customer, identified by their customer ID, so that I can 
 * coordinate with the advisor for tailored financial services.
 */
GO
CREATE PROCEDURE GetCustomerFinancialAdvisor(@customerID INT)
AS
BEGIN
    SELECT f.*, e.employee_name
    FROM FinancialAdvisor f
    JOIN Employees e ON f.employee_id = e.employee_id
    WHERE f.customer_id = @customerID;
END;


 /* User Story 6
 * As a bank manager, I want to access the loan details, including loan amounts and associated branches, for a particular customer, identified by their 
 * customer ID, to provide better assistance with their loan-related inquiries.
 */
GO
CREATE PROCEDURE GetCustomerLoans(@customerID INT)
AS
BEGIN
    SELECT l.*, b.branch_name
    FROM LoanTransactions lt
    JOIN Loans l ON lt.loan_id = l.loan_id
    JOIN Branches b ON l.branch_id = b.branch_id
    WHERE lt.customer_id = @customerID;
END;


 /* User Story 7
 * As a bank manager, I need to find out the role and branch of a particular employee, identified by their employee ID, to understand their responsibilities
 * and work location.
 */
GO
CREATE PROCEDURE GetEmployeeRoleAndBranch(@employeeID INT)
AS
BEGIN
    SELECT ef.role, b.branch_name
    FROM EmploymentFunction ef
    JOIN Branches b ON ef.branch_id = b.branch_id
    WHERE ef.employee_id = @employeeID;
END;


 /* User Story 8
 * As a bank manager, I want to identify and review all transactions in which a specific customer, identified by their customer ID, encountered overdraft 
 * situations to manage potential issues and offer solutions.
 */
GO
CREATE PROCEDURE GetCustomerOverdraftTransactions(@customerID INT)
AS
BEGIN
    SELECT * FROM RegularTransactions WHERE customer_id = @customerID AND is_transaction_in_overdraft = 1;
END;


 /* User Story 9
 * As a bank manager, I need to calculate the average account balance for each branch to assess branch performance and allocate resources accordingly.
 */
GO
CREATE PROCEDURE GetAverageAccountBalanceByBranch
AS
BEGIN
    SELECT b.branch_name, AVG(a.balance) AS AverageBalance
    FROM Accounts a
    JOIN Branches b ON a.branch_id = b.branch_id
    GROUP BY b.branch_name;
END;


 /* User Story 10
 * As a bank manager, I want to list all employees working at a particular branch, identified by the branch ID, to understand the branch's staffing and
 * roles for better management and coordination.
 */
GO
CREATE PROCEDURE ListEmployeesInBranch(@branchID INT)
AS
BEGIN
    SELECT e.employee_name, ef.role
    FROM EmploymentFunction ef
    JOIN Employees e ON ef.employee_id = e.employee_id
    WHERE ef.branch_id = @branchID;
END;

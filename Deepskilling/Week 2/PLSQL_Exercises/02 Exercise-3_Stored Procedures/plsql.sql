-- Customers table
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    LastModified DATE,
    IsVIP CHAR(10) CHECK (IsVIP IN ('TRUE', 'FALSE'))
);

-- Accounts table
CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Transactions table
CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER,
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- Loans table
CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Employees table
CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
);

-- Step 2: Insert Sample Data

-- Customers
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
VALUES (1, 'Aman Verma', TO_DATE('1958-08-15', 'YYYY-MM-DD'), 25000, SYSDATE, NULL);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
VALUES (2, 'Priya Nair', TO_DATE('2002-03-12', 'YYYY-MM-DD'), 9500, SYSDATE, NULL);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP)
VALUES (3, 'Rahul Singh', TO_DATE('1960-11-05', 'YYYY-MM-DD'), 12000, SYSDATE, NULL);


-- Accounts
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (1, 1, 'Savings', 25000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (2, 2, 'Savings', 9500, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (3, 3, 'Savings', 12000, SYSDATE);

-- Transactions
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (1, 1, SYSDATE, 5000, 'Deposit');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2, 2, SYSDATE, 3000, 'Withdrawal');

-- Loans
INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (1, 1, 400000, 8, SYSDATE, SYSDATE + 15);

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (2, 2, 150000, 10, SYSDATE, ADD_MONTHS(SYSDATE, 36));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (3, 3, 250000, 7.5, SYSDATE, ADD_MONTHS(SYSDATE, 60));

-- Employees
INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (1, 'Neha Sharma', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (2, 'Rohit Mehta', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));

COMMIT;


-- Exercise 3: Stored Procedures

-- Scenario 1: The bank needs to process monthly interest for all savings accounts.
-- o	Question: Write a stored procedure ProcessMonthlyInterest that calculates and updates the balance of all savings accounts by applying an interest rate of 1% to the current balance.

-- Scenario 2: The bank wants to implement a bonus scheme for employees based on their performance.
-- o	Question: Write a stored procedure UpdateEmployeeBonus that updates the salary of employees in a given department by adding a bonus percentage passed as a parameter.

-- Scenario 3: Customers should be able to transfer funds between their accounts.
-- o	Question: Write a stored procedure TransferFunds that transfers a specified amount from one account to another, checking that the source account has sufficient balance before making the transfer.




-- Scenario 1 :

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
    -- Add 1% interest to all savings accounts
    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType = 'Savings';

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Monthly interest added to savings accounts.');
END;

BEGIN ProcessMonthlyInterest; END;
/



-- Scenario 2 :

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    dept_name IN VARCHAR2,
    bonus_percent IN NUMBER
) AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * bonus_percent / 100)
    WHERE Department = dept_name;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Bonus of ' || bonus_percent || '% applied to ' || dept_name || ' department.');
END;
/
BEGIN
    UpdateEmployeeBonus('IT', 10);  -- Apply 10% bonus to IT department
END;

/

select * from EMPLOYEES;




-- Scenario 3 :

-- Enable output
SET SERVEROUTPUT ON;

-- Create procedure
CREATE OR REPLACE PROCEDURE TransferFunds (
    from_account_id IN NUMBER,
    to_account_id   IN NUMBER,
    amount          IN NUMBER
) AS
    v_balance NUMBER;
BEGIN
    -- Get balance of source account
    SELECT Balance INTO v_balance
    FROM Accounts
    WHERE AccountID = from_account_id
    FOR UPDATE;

    -- Check sufficient balance
    IF v_balance < amount THEN
        DBMS_OUTPUT.PUT_LINE('Insufficient balance in source account.');
        RETURN;
    END IF;

    -- Deduct from source
    UPDATE Accounts
    SET Balance = Balance - amount,
        LastModified = SYSDATE
    WHERE AccountID = from_account_id;

    -- Credit to destination
    UPDATE Accounts
    SET Balance = Balance + amount,
        LastModified = SYSDATE
    WHERE AccountID = to_account_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Transfer of ' || amount || ' from Account ' || from_account_id ||
                         ' to Account ' || to_account_id || ' successful.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('One or both account IDs are invalid.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

BEGIN
    TransferFunds(1, 2, 5000);  -- Transfer ₹5000 from Account 1 to 2
END;
/
select * from ACCOUNTS;


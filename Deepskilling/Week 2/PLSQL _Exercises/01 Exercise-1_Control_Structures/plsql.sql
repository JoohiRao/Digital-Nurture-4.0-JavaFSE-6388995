-- Schema to be Created


-- Create Customers table
CREATE TABLE CUSTOMERS (
    CUSTOMERID   NUMBER PRIMARY KEY,
    NAME         VARCHAR2(100),
    DOB          DATE,
    BALANCE      NUMBER,
    LASTMODIFIED DATE
);


-- Create Accounts table
CREATE TABLE ACCOUNTS (
    ACCOUNTID    NUMBER PRIMARY KEY,
    CUSTOMERID   NUMBER,
    ACCOUNTTYPE  VARCHAR2(20),
    BALANCE      NUMBER,
    LASTMODIFIED DATE,
    FOREIGN KEY ( CUSTOMERID )
        REFERENCES CUSTOMERS ( CUSTOMERID )
);

-- Create Transactions table
CREATE TABLE TRANSACTIONS (
    TRANSACTIONID   NUMBER PRIMARY KEY,
    ACCOUNTID       NUMBER,
    TRANSACTIONDATE DATE,
    AMOUNT          NUMBER,
    TRANSACTIONTYPE VARCHAR2(10),
    FOREIGN KEY ( ACCOUNTID )
        REFERENCES ACCOUNTS ( ACCOUNTID )
);

-- Create Loans table
CREATE TABLE LOANS (
    LOANID       NUMBER PRIMARY KEY,
    CUSTOMERID   NUMBER,
    LOANAMOUNT   NUMBER,
    INTERESTRATE NUMBER,
    STARTDATE    DATE,
    ENDDATE      DATE,
    FOREIGN KEY ( CUSTOMERID )
        REFERENCES CUSTOMERS ( CUSTOMERID )
);

-- Create Employees table
CREATE TABLE EMPLOYEES (
    EMPLOYEEID NUMBER PRIMARY KEY,
    NAME       VARCHAR2(100),
    POSITION   VARCHAR2(50),
    SALARY     NUMBER,
    DEPARTMENT VARCHAR2(50),
    HIREDATE   DATE
);



-- Example Scripts for Sample Data Insertion

--- Insert Customers
INSERT INTO Customers VALUES (1, 'Ram Sharma', TO_DATE('1960-03-15', 'YYYY-MM-DD'), 50000, SYSDATE); -- Age 65
INSERT INTO Customers VALUES (2, 'Sneha Rao', TO_DATE('1985-06-22', 'YYYY-MM-DD'), 30000, SYSDATE); -- Age 40
INSERT INTO Customers VALUES (3, 'Mohit Jain', TO_DATE('1955-11-10', 'YYYY-MM-DD'), 70000, SYSDATE); -- Age 69

-- Insert Accounts
INSERT INTO Accounts VALUES (101, 1, 'Savings', 50000, SYSDATE);
INSERT INTO Accounts VALUES (102, 2, 'Checking', 30000, SYSDATE);
INSERT INTO Accounts VALUES (103, 3, 'Savings', 70000, SYSDATE);

-- Insert Loans
INSERT INTO Loans VALUES (201, 1, 100000, 8.5, TO_DATE('2021-01-01','YYYY-MM-DD'), TO_DATE('2025-07-10','YYYY-MM-DD'));
INSERT INTO Loans VALUES (202, 2, 150000, 9.0, TO_DATE('2022-02-01','YYYY-MM-DD'), TO_DATE('2027-02-01','YYYY-MM-DD'));
INSERT INTO Loans VALUES (203, 3, 200000, 10.0, TO_DATE('2020-06-01','YYYY-MM-DD'), TO_DATE('2025-06-01','YYYY-MM-DD'));

-- Insert Employees
INSERT INTO Employees VALUES (301, 'Anita Desai', 'Manager', 75000, 'Loans', TO_DATE('2015-07-01','YYYY-MM-DD'));
INSERT INTO Employees VALUES (302, 'Ravi Mehra', 'Clerk', 40000, 'Accounts', TO_DATE('2019-11-10','YYYY-MM-DD'));


-- Transactions for Account 101 (Customer 1)
INSERT INTO Transactions VALUES (1, 101, SYSDATE - 5, 10000, 'Deposit');
INSERT INTO Transactions VALUES (2, 101, SYSDATE - 3, 2500, 'Withdrawal');

-- Transactions for Account 102 (Customer 2)
INSERT INTO Transactions VALUES (3, 102, SYSDATE - 7, 20000, 'Deposit');
INSERT INTO Transactions VALUES (4, 102, SYSDATE - 2, 5000, 'Withdrawal');

-- Transactions for Account 103 (Customer 3)
INSERT INTO Transactions VALUES (5, 103, SYSDATE - 10, 3000, 'Deposit');
INSERT INTO Transactions VALUES (6, 103, SYSDATE - 1, 1500, 'Withdrawal');



-- Exercise 1: Control Structures

-- Scenario 1: The bank wants to apply a discount to loan interest rates for customers above 60 years old.
--   	Question: Write a PL/SQL block that loops through all customers, checks their age, and if they are above 60, apply a 1% discount to their current loan interest rates.
-- Scenario 2: A customer can be promoted to VIP status based on their balance.
--    	Question: Write a PL/SQL block that iterates through all customers and sets a flag IsVIP to TRUE for those with a balance over $10,000.
-- Scenario 3: The bank wants to send reminders to customers whose loans are due within the next 30 days.
--    	Question: Write a PL/SQL block that fetches all loans due in the next 30 days and prints a reminder message for each customer.




-- SCENARIO 1


SET SERVEROUTPUT ON;
DECLARE
    CURSOR CUSTOMER_CURSOR IS
        SELECT CUSTOMERID, EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM DOB) AS AGE
        FROM CUSTOMERS;

    VAR_CUSTOMER_ID CUSTOMERS.CUSTOMERID%TYPE;
    VAR_AGE NUMBER;
BEGIN
    FOR CUSTOMER_RECORD IN CUSTOMER_CURSOR LOOP
        VAR_CUSTOMER_ID := CUSTOMER_RECORD.CUSTOMERID;
        VAR_AGE := CUSTOMER_RECORD.AGE;

        IF VAR_AGE > 60 THEN
            UPDATE LOANS
            SET INTERESTRATE = INTERESTRATE - 1
            WHERE CUSTOMERID = VAR_CUSTOMER_ID;
        ELSE
            DBMS_OUTPUT.PUT_LINE('CUSTOMER WITH CUSTOMER ID : ' || VAR_CUSTOMER_ID || ' IS OF AGE : ' || VAR_AGE);
            DBMS_OUTPUT.PUT_LINE('NO CHANGE IN LOAN');
        END IF;
    END LOOP;

    COMMIT;
END;

SELECT * FROM LOANS;


-- SCENARIO 2

-- Add IsVIP column if it doesn't exist
ALTER TABLE CUSTOMERS ADD (IsVIP VARCHAR2(5));

-- Set default value for existing customers
UPDATE Customers SET IsVIP = 'FALSE';
COMMIT;

SET SERVEROUTPUT ON;
DECLARE
    CURSOR cust_cursor IS
        SELECT CustomerID, Balance FROM Customers;

    v_cust_id Customers.CustomerID%TYPE;
    v_balance Customers.Balance%TYPE;
BEGIN
    FOR cust_record IN cust_cursor LOOP
        v_cust_id := cust_record.CustomerID;
        v_balance := cust_record.Balance;

        IF v_balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = v_cust_id;

            DBMS_OUTPUT.PUT_LINE('Customer ID ' || v_cust_id || ' marked as VIP.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Customer ID ' || v_cust_id || ' NOT eligible for VIP.');
        END IF;
    END LOOP;

    COMMIT;
END;
/

SELECT CustomerID, Name, Balance, IsVIP FROM Customers;



-- SCENARIO 3


SET SERVEROUTPUT ON;
DECLARE
    CURSOR CUR_LOANS IS
        SELECT L.LOANID, L.CUSTOMERID, C.NAME, L.ENDDATE
        FROM LOANS L
        JOIN CUSTOMERS C ON L.CUSTOMERID = C.CUSTOMERID
        WHERE L.ENDDATE BETWEEN SYSDATE AND SYSDATE + 30;
    
    V_LOAN_ID LOANS.LOANID%TYPE;
    V_CUSTOMER_ID LOANS.CUSTOMERID%TYPE;
    V_CUSTOMER_NAME CUSTOMERS.NAME%TYPE;
    V_END_DATE LOANS.ENDDATE%TYPE;
    V_FOUND BOOLEAN := FALSE;
BEGIN
    OPEN CUR_LOANS;
    LOOP
        FETCH CUR_LOANS INTO V_LOAN_ID, V_CUSTOMER_ID, V_CUSTOMER_NAME, V_END_DATE;
        EXIT WHEN CUR_LOANS%NOTFOUND;
        
        V_FOUND := TRUE;
        DBMS_OUTPUT.PUT_LINE('Reminder: Loan ' || V_LOAN_ID || ' for customer ' || V_CUSTOMER_NAME || ' (ID: ' || V_CUSTOMER_ID || ') is due on ' || TO_CHAR(V_END_DATE, 'YYYY-MM-DD'));
    END LOOP;
    CLOSE CUR_LOANS;

    IF NOT V_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No loans are due within the next 30 days.');
    END IF;
END;
/
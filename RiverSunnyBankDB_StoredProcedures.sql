-- PBSC Database Capstone Project --
-- Stored Procedure Creation --



-- Procedure 1: To view all current balances of accounts --

CREATE PROCEDURE ViewAllBalances
AS

SELECT CONCAT(FirstName, ' ', LastName) AS AccountHolder, AccountType, Balance AS CurrentBalance
FROM Customer 
	JOIN CustomerAccountBridge
		ON Customer.CustomerID = CustomerAccountBridge.CustomerID
	JOIN ACCOUNT 
		ON CustomerAccountBridge.AccountNumber = Account.AccountNumber
	JOIN AccountStatusCodes
		ON Account.AccountStatus = AccountStatusCodes.StatusCode
	JOIN Checking
		ON Account.AccountNumber = Checking.AccountNumber
UNION

SELECT CONCAT(FirstName, ' ', LastName) AS AccountHolder, AccountType, CurrentBalance AS CurrentBalance
FROM Customer 
	JOIN CustomerAccountBridge
		ON Customer.CustomerID = CustomerAccountBridge.CustomerID
	JOIN ACCOUNT 
		ON CustomerAccountBridge.AccountNumber = Account.AccountNumber
	JOIN AccountStatusCodes
		ON Account.AccountStatus = AccountStatusCodes.StatusCode
	JOIN CreditCard
		ON Account.AccountNumber = CreditCard.AccountNumber

UNION

SELECT CONCAT(FirstName, ' ', LastName) AS AccountHolder, AccountType, CurrentBalance AS CurrentBalance
FROM Customer 
	JOIN CustomerAccountBridge
		ON Customer.CustomerID = CustomerAccountBridge.CustomerID
	JOIN ACCOUNT 
		ON CustomerAccountBridge.AccountNumber = Account.AccountNumber
	JOIN AccountStatusCodes
		ON Account.AccountStatus = AccountStatusCodes.StatusCode
	JOIN Loan
		ON Account.AccountNumber = Loan.AccountNumber

UNION

SELECT CONCAT(FirstName, ' ', LastName) AS AccountHolder, AccountType, Balance AS CurrentBalance
FROM Customer 
	JOIN CustomerAccountBridge
		ON Customer.CustomerID = CustomerAccountBridge.CustomerID
	JOIN ACCOUNT 
		ON CustomerAccountBridge.AccountNumber = Account.AccountNumber
	JOIN AccountStatusCodes
		ON Account.AccountStatus = AccountStatusCodes.StatusCode
	JOIN Savings
		ON Account.AccountNumber = Savings.AccountNumber
ORDER BY AccountType, CurrentBalance DESC
;

GO

-- Procedure 2: Lookup Customer Accounts With CustomerID Parameter "@CustomerID" --

-- Note: CustomerIDs start at 100 and must be entered with single qoutes. Ex: '101'

CREATE PROCEDURE CustomerAccountLookUp @CustomerID VARCHAR(10)
AS

SELECT CONCAT(FirstName, ' ', LastName) AS AccountHolder, AccountType, Balance AS CurrentBalance
FROM Customer 
	JOIN CustomerAccountBridge
		ON Customer.CustomerID = CustomerAccountBridge.CustomerID
	JOIN ACCOUNT 
		ON CustomerAccountBridge.AccountNumber = Account.AccountNumber
	JOIN AccountStatusCodes
		ON Account.AccountStatus = AccountStatusCodes.StatusCode
	JOIN Checking
		ON Account.AccountNumber = Checking.AccountNumber
WHERE Customer.CustomerID = @CustomerID

UNION

SELECT CONCAT(FirstName, ' ', LastName) AS AccountHolder, AccountType, CurrentBalance AS CurrentBalance
FROM Customer 
	JOIN CustomerAccountBridge
		ON Customer.CustomerID = CustomerAccountBridge.CustomerID
	JOIN ACCOUNT 
		ON CustomerAccountBridge.AccountNumber = Account.AccountNumber
	JOIN AccountStatusCodes
		ON Account.AccountStatus = AccountStatusCodes.StatusCode
	JOIN CreditCard
		ON Account.AccountNumber = CreditCard.AccountNumber
WHERE Customer.CustomerID = @CustomerID

UNION

SELECT CONCAT(FirstName, ' ', LastName) AS AccountHolder, AccountType, CurrentBalance AS CurrentBalance
FROM Customer 
	JOIN CustomerAccountBridge
		ON Customer.CustomerID = CustomerAccountBridge.CustomerID
	JOIN ACCOUNT 
		ON CustomerAccountBridge.AccountNumber = Account.AccountNumber
	JOIN AccountStatusCodes
		ON Account.AccountStatus = AccountStatusCodes.StatusCode
	JOIN Loan
		ON Account.AccountNumber = Loan.AccountNumber
WHERE Customer.CustomerID = @CustomerID

UNION

SELECT CONCAT(FirstName, ' ', LastName) AS AccountHolder, AccountType, Balance AS CurrentBalance
FROM Customer 
	JOIN CustomerAccountBridge
		ON Customer.CustomerID = CustomerAccountBridge.CustomerID
	JOIN ACCOUNT 
		ON CustomerAccountBridge.AccountNumber = Account.AccountNumber
	JOIN AccountStatusCodes
		ON Account.AccountStatus = AccountStatusCodes.StatusCode
	JOIN Savings
		ON Account.AccountNumber = Savings.AccountNumber
WHERE Customer.CustomerID = @CustomerID
ORDER BY AccountType, CurrentBalance DESC
; 

GO

-- Procedure 3: Lookup Credit Cards and Loans that are past due

CREATE PROCEDURE PastDueAccounts
AS

SELECT CONCAT(FirstName, ' ', LastName) AS AccountHolder, AccountType, StatusDescription, CurrentBalance AS CurrentBalance
FROM Customer 
	JOIN CustomerAccountBridge
		ON Customer.CustomerID = CustomerAccountBridge.CustomerID
	JOIN ACCOUNT 
		ON CustomerAccountBridge.AccountNumber = Account.AccountNumber
	JOIN AccountStatusCodes
		ON Account.AccountStatus = AccountStatusCodes.StatusCode
	JOIN CreditCard
		ON Account.AccountNumber = CreditCard.AccountNumber
WHERE AccountStatus = '71' OR AccountStatus = '78' OR AccountStatus = '80' OR AccountStatus = '82' OR AccountStatus = '83' OR AccountStatus = '84' OR AccountStatus = '93'

UNION

SELECT CONCAT(FirstName, ' ', LastName) AS AccountHolder, AccountType, StatusDescription, CurrentBalance AS CurrentBalance
FROM Customer 
	JOIN CustomerAccountBridge
		ON Customer.CustomerID = CustomerAccountBridge.CustomerID
	JOIN ACCOUNT 
		ON CustomerAccountBridge.AccountNumber = Account.AccountNumber
	JOIN AccountStatusCodes
		ON Account.AccountStatus = AccountStatusCodes.StatusCode
	JOIN Loan
		ON Account.AccountNumber = Loan.AccountNumber
WHERE AccountStatus = '71' OR AccountStatus = '78' OR AccountStatus = '80' OR AccountStatus = '82' OR AccountStatus = '83' OR AccountStatus = '84' OR AccountStatus = '93'
ORDER BY AccountType, CurrentBalance DESC;
GO

-- Procedure 4: View all transactions for a specific user between two specified dates Parameter: @CustomerID, @StartDate, @EndDate --

-- Note: CustomerIDs start at 100 and must be entered with single qoutes. Ex: '101'
-- Note: Dates must be in the format of 'YYYY-MM-DD'


CREATE PROCEDURE TransactionLookUp
@CustomerID VARCHAR(10), @StartDate VARCHAR(12), @EndDate VARCHAR(12)
AS 

SELECT CONCAT(FirstName, ' ', LastName) AS CustomerName, Account.AccountNumber, AccountType, TransactionDate, TransactionDescription, FORMAT(Amount, 'C') AS TransactionAmmount
FROM Customer 
	JOIN CustomerAccountBridge 
		ON Customer.CustomerID = CustomerAccountBridge.CustomerID
	JOIN Account 
		ON CustomerAccountBridge.AccountNumber = Account.AccountNumber
	JOIN AccountTransaction 
		ON Account.AccountNumber = AccountTransaction.AccountNumber
	JOIN TransactionTypeCodes 
		ON AccountTransaction.TransactionType = TransactionTypeCodes.TransactionTypeCode
WHERE Customer.CustomerID = @CustomerID AND TransactionDate BETWEEN @StartDate AND @EndDate;
GO

-- Example Execution Statements --

EXEC ViewAllBalances;

EXEC CustomerAccountLookUp @CustomerID = '101';

EXEC PastDueAccounts;

EXEC TransactionLookUp @CustomerID = '101', @StartDate = '2020-01-01', @EndDate = '2023-10-29';

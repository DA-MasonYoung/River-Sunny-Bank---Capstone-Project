-- PBSC Database Capstone Project --
-- River Sunny Bank Database Table Creation --




-- Ensure Database is created and uses the correct name. If needed, the line below will create the correct database. --
-- Open and run in a new querry and run it before executing the CREATE TABLE statements --
-- CREATE DATABASE RiverSunnyBank; --

USE RiverSunnyBank;


CREATE TABLE Customer (
	CustomerID		INT			PRIMARY KEY			IDENTITY(100,1),
	FirstName		VARCHAR(50)		NOT NULL,
	LastName		VARCHAR(50)		NOT NULL,
	DateOfBirth		DATE			NOT NULL,
	Street			VARCHAR(60)		NOT NULL,
	City			VARCHAR(45)		NOT NULL,
	StateCode		CHAR(2)			NOT NULL,
	Zip			CHAR(5)			NOT NULL,
	PhoneNumber		CHAR(10)		NOT NULL,
	Email			VARCHAR(100)		NOT NULL,

	CONSTRAINT CK_Customer_StateCode CHECK(StateCode IN(	'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA',
								'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD',
								'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ',
								'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC',
								'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'))

								-- Check Constraint State includes all 50 States in the United States --
);


CREATE TABLE Branch (
	BranchID		INT			PRIMARY KEY			IDENTITY(1,1),
	BranchName		VARCHAR(100)		NOT NULL,
	Street			VARCHAR(60)		NOT NULL,
	City			VARCHAR(50)		NOT NULL,
	StateCode		CHAR(2)			NOT NULL,
	Zip			CHAR(5)			NOT NULL,
	PhoneNumber		CHAR(10)		NOT NULL,

	CONSTRAINT CK_Branch_StateCode CHECK(StateCode IN(	'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA',
								'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MD',
								'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ',
								'NM', 'NY', 'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC',
								'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'))

								-- Check Constraint State includes all 50 States in the United States --
);


CREATE TABLE Account (
	AccountNumber		INT			PRIMARY KEY			IDENTITY(1000,1),
	BranchID		INT			NOT NULL,
	OpenDate		DATE			NOT NULL,
	AccountType		CHAR(2)			NOT NULL,
	AccountStatus		CHAR(2)			NOT NULL			DEFAULT('11'),

	CONSTRAINT FK_Account_BranchID FOREIGN KEY (BranchID) REFERENCES Branch(BranchID) ON DELETE CASCADE,
	CONSTRAINT CK_Account_AccountType CHECK (AccountType IN('CH', 'SS', 'LL', 'CL')),
	CONSTRAINT CK_Account_AccountStatus CHECK(AccountStatus IN(	'05', '11', '13', '61', '62', '63', '64', '65', '71', '78',
									'80', '82', '83', '84', '88', '89', '93', '94', '95', '96',
									'97', 'DA', 'DF'))

									/* Check Constraint AccountType Codes:
										- CH: Checking
										- SS: Savings
										- LL: Loan
										- CL: Credit Line (Credit Card)
									*/
															
															
									/* Check Cosntraint Status codes:
										- 05: Account transferred to another office.
										- 11: Current account.
										- 13: Paid or closed account/zero balance.
										- 61: Account paid in full was a voluntary surrender.
										- 62: Account paid in full was a collection account, insurance claim or government claim.
										- 63: Account paid in full was a repossession.
										- 64: Account paid in full was a charge-off.
										- 65: Account paid in full. A foreclosure was started.
										- 71: Account 30 days past the due date.
										- 78: Account 60 days past the due date.
										- 80: Account 90 days past the due date.
										- 82: Account 120 days past the due date.
										- 83: Account 150 days past the due date.
										- 84: Account 180 days or more past the due date.
										- 88: Claim filed with government for insured portion of balance on a defaulted loan.
										- 89: Deed received in lieu of foreclosure on a defaulted mortgage.
										- 93: Account seriously past due and/or assigned to internal or external collections.
										- 94: Foreclosure/credit grantor sold collateral to settle defaulted mortgage.
										- 95: Voluntary surrender.
										- 96: Merchandise was repossessed by credit grantor; there may be a balance due.
										- 97: Unpaid balance reported as a loss by credit grantor (charge-off).
										- DA: Delete entire account (for reasons other than fraud).
										- DF: Delete entire account due to confirmed fraud (fraud investigation completed).

										List generated using Credit Bureau Status Codes: https://help.cubase.org/cubase/crtburstatuscodes.htm 
									*/
);


CREATE TABLE CustomerAccountBridge(
	BridgeID		INT			PRIMARY KEY			IDENTITY(1,1),
	CustomerID		INT			NOT NULL,
	AccountNumber		INT			NOT NULL,

	CONSTRAINT FK_CustomerAccountBridge_CustomerID FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE,
	CONSTRAINT FK_CustomerAccountBridge_AccountNumber FOREIGN KEY(AccountNumber) References Account(AccountNumber) ON DELETE CASCADE
	

);


CREATE TABLE AccountTransaction (
	TransactionID		INT			PRIMARY KEY			IDENTITY(1000,1),
	AccountNumber		INT			NOT NULL,
	TransactionType		CHAR(2)			NOT NULL,
	Amount			DECIMAL(10, 2)		NOT NULL,
	TransactionDate		DATE			NOT NULL,

	CONSTRAINT FK_AccountTransaction_AccountNumber FOREIGN KEY (AccountNumber) REFERENCES Account(AccountNumber) ON DELETE CASCADE,
	CONSTRAINT CK_AccountTransaction_TransactionType 
		CHECK(TransactionType IN('IT', 'ET', 'CP', 'LP', 'WW', 'RD', 'DD', 'DC', 'CC', 'CF'))
								
								 /* Check Cosntraint TransactionType codes:
									- IT: Internal Transfer
									- ET: External Transfer
									- CP: Card Payment
									- LP: Loan Payment
									- WW: Withdrawl
									- RD: Regular Deposit
									- DD: Direct Deposit
									- DC: Debit Charge
									- CC: Credit Charge
									- CF: Charge Fee
								*/
);


CREATE TABLE CreditCard (
	CardNumber		CHAR(16)		PRIMARY KEY,
	AccountNumber		INT			NOT NULL,
	CustomerID		INT			NOT NULL,
	ExpirationDate		DATE			NOT NULL,
	CreditLimit		DECIMAL(15, 2)		NOT NULL,
	CurrentBalance		DECIMAL(15, 2)		NOT NULL,
	PaymentDueDate		DATE			NOT NULL,
	CardAPR			DECIMAL(5,2)		NOT NULL,
	PaymentDue		DECIMAL(10, 2)		NOT NULL,

	CONSTRAINT FK_CreditCard_AccountNumber FOREIGN KEY (AccountNumber) REFERENCES Account(AccountNumber) ON DELETE CASCADE,
	CONSTRAINT FK_CreditCard_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE
);


CREATE TABLE Loan (
	LoanID			INT			PRIMARY KEY			IDENTITY(1000,1),
	AccountNumber		INT			NOT NULL,
	LoanType		CHAR(2)			NOT NULL,
	LoanAmount		DECIMAL(15, 2)		NOT NULL,
	CurrentBalance		DECIMAL(15, 2)		NOT NULL,	-- NEW COLUMN!!
	InterestRate		DECIMAL(5, 2)		NOT NULL,
	LoanTerm		INT			NOT NULL,
	ApprovalDate		DATE			NOT NULL,
	PayOffDate		DATE			NOT NULL,

	CONSTRAINT FK_Loan_AccountNumber FOREIGN KEY (AccountNumber) REFERENCES Account(AccountNumber) ON DELETE CASCADE,
	CONSTRAINT CK_Loan_LoanType	CHECK(LoanType IN('AA', 'MM', 'BB', 'RV', 'HH', 'PP', 'SS'))

								/* Check Cosntraint LoanType codes:
									- AA: Auto
									- MM: Motorcycle
									- BB: Boat/Marine
									- RV: Recreational Vehicle
									- HH: Home
									- PP: Pesronal
									- SS: Student
								*/
);


CREATE TABLE Checking (
	AccountNumber		INT			PRIMARY KEY,
	Balance			DECIMAL(15,2)		NOT NULL,

	CONSTRAINT FK_Checking_AccountNumber FOREIGN KEY (AccountNumber) REFERENCES Account(AccountNumber) ON DELETE CASCADE
);


CREATE TABLE Savings (
	AccountNumber		INT			PRIMARY KEY,
	Balance			DECIMAL(15,2)		NOT NULL,

	CONSTRAINT FK_Savings_AccountNumber FOREIGN KEY (AccountNumber) REFERENCES Account(AccountNumber) ON DELETE CASCADE
);


CREATE TABLE Employee (
	EmployeeID		INT			PRIMARY KEY			IDENTITY(100,1),
	BranchID		INT			NOT NULL,
	FirstName		VARCHAR(50)		NOT NULL,
	LastName		VARCHAR(50)		NOT NULL,
	DateOfBirth		DATE			NOT NULL,
	Position		VARCHAR(50)		NOT NULL,
	Department		CHAR(2)			NOT NULL,
	Pay			DECIMAL(10, 2)		NOT NULL,
	PayType			CHAR(2)			NOT NULL,

	CONSTRAINT FK_Employee_BranchID FOREIGN KEY (BranchID) REFERENCES Branch(BranchID) ON DELETE CASCADE,
	CONSTRAINT CK_Employee_Department CHECK(Department IN(	'LO', 'CA', 'SS', 'MM', 'FO', 'ON', 'HR', 'IT', 'OO', 'RM',
								'MA', 'LE', 'AA', 'AU', 'DD', 'SE')),
	CONSTRAINT CK_Employee_PayType CHECK(PayType IN('SS', 'HH'))

								/* Check Constraint Department Codes:
									- LO: Loan
									- CA: Credit Aplication
									- SS: Customer Support Service
									- MM: Managment
									- FO: Front Office
									- ON: Onboarding
									- HR: Human Resources
									- IT: Information Technology
									- OO: Operations
									- RM: Risk Management
									- MA: Marketing
									- LE: Legal
									- AA: Accounting
									- AU: Auditing
									- DD: Digital/Online
									- SE: Security
								*/

								/* Check Constraint PayTpe Codes:
									- SS: Salary
									- HH: Hourly
								*/
);




CREATE TABLE AccountStatusCodes (
	StatusCode				CHAR(2)		PRIMARY KEY,
	StatusDescription		VARCHAR(100)
);

CREATE TABLE StateCodes (
	StateCode				CHAR(2)		PRIMARY KEY,
	StateName				VARCHAR(50),
);

CREATE TABLE TransactionTypeCodes (
	TransactionTypeCode		CHAR(2)		PRIMARY KEY,
	TransactionDescription	VARCHAR(50),
);

CREATE TABLE LoanTypeCodes (
	LoanTypeCode			CHAR(2)		PRIMARY KEY,
	LoanType				VARCHAR(20)
);

CREATE TABLE DepartmentCodes (
	DepartmentCode			CHAR(2)		PRIMARY KEY,
	DepartmentDescription	VARCHAR(25)
);


INSERT INTO AccountStatusCodes
VALUES
('05', 'Account transferred to another office'),
('11', 'Current account'),
('13', 'Paid or closed account/zero balance'),
('61', 'Account paid in full was a voluntary surrender'),
('62', 'Account paid in full was a collection account, insurance claim or government claim'),
('63', 'Account paid in full was a repossession'),
('64', 'Account paid in full was a charge-off'),
('65', 'Account paid in full. A foreclosure was started'),
('71', 'Account 30 days past the due date'),
('78', 'Account 60 days past the due date'),
('80', 'Account 90 days past the due date'),
('82', 'Account 120 days past the due date'),
('83', 'Account 150 days past the due date'),
('84', 'Account 180 days or more past the due date'),
('88', 'Claim filed with government for insured portion of balance on a defaulted loan'),
('89', 'Deed received in lieu of foreclosure on a defaulted mortgage'),
('93', 'Account seriously past due and/or assigned to internal or external collections'),
('94', 'Foreclosure/credit grantor sold collateral to settle defaulted mortgage'),
('95', 'Voluntary surrender'),
('96', 'Merchandise was repossessed by credit grantor; there may be a balance due'),
('97', 'Unpaid balance reported as a loss by credit grantor (charge-off'),
('DA', 'Delete entire account (for reasons other than fraud'),
('DF', 'Delete entire account due to confirmed fraud (fraud investigation completed')
;

INSERT INTO StateCodes
VALUES
('AL', 'Alabama'),
('AK', 'Alaska'),
('AZ', 'Arizona'),
('AR', 'Arkansas'),
('CA', 'California'),
('CO', 'Colorado'),
('CT', 'Connecticut'),
('DE', 'Delaware'),
('FL', 'Florida'),
('GA', 'Georgia'),
('HI', 'Hawaii'),
('ID', 'Idaho'),
('IL', 'Illinois'),
('IN', 'Indiana'),
('IA', 'Iowa'),
('KS', 'Kansas'),
('KY', 'Kentucky'),
('LA', 'Louisiana'),
('ME', 'Maine'),
('MD', 'Maryland'),
('MA', 'Massachusetts'),
('MI', 'Michigan'),
('MN', 'Minnesota'),
('MS', 'Mississippi'),
('MO', 'Missouri'),
('MT', 'Montana'),
('NE', 'Nebraska'),
('NV', 'Nevada'),
('NH', 'New Hampshire'),
('NJ', 'New Jersey'),
('NM', 'New Mexico'),
('NY', 'New York'),
('NC', 'North Carolina'),
('ND', 'North Dakota'),
('OH', 'Ohio'),
('OK', 'Oklahoma'),
('OR', 'Oregon'),
('PA', 'Pennsylvania'),
('RI', 'Rhode Island'),
('SC', 'South Carolina'),
('SD', 'South Dakota'),
('TN', 'Tennessee'),
('TX', 'Texas'),
('UT', 'Utah'),
('VT', 'Vermont'),
('VA', 'Virginia'),
('WA', 'Washington'),
('WV', 'West Virginia'),
('WI', 'Wisconsin'),
('WY', 'Wyoming')
;

INSERT INTO TransactionTypeCodes
VALUES
('IT', 'Internal Transfer'),
('ET', 'External Transfer'),
('CP', 'Card Payment'),
('LP', 'Loan Payment'),
('WW', 'Withdrawal'),
('RD', 'Regular Deposit'),
('DD', 'Direct Deposit'),
('DC', 'Debit Charge'),
('CC', 'Credit Charge'),
('CF', 'Charge Fee')
;

INSERT INTO LoanTypeCodes
VALUES
('AA', 'Auto'),
('MM', 'Motorcycle'),
('BB', 'Boat/Marine'),
('RV', 'Recreational Vehicle'),
('HH', 'Home'),
('PP', 'Personal'),
('SS', 'Student')
;

INSERT INTO DepartmentCodes
Values
('LO', 'Loan'),
('CA', 'Credit Application'),
('SS', 'Customer Support Service'),
('MM', 'Management'),
('FO', 'Front Office'),
('ON', 'Onboarding'),
('HR', 'Human Resources'),
('IT', 'Information Technology'),
('OO', 'Operations'),
('RM', 'Risk Management'),
('MA', 'Marketing'),
('LE', 'Legal'),
('AA', 'Accounting'),
('AU', 'Auditing'),
('DD', 'Digital/Online'),
('SE', 'Security')
;



DROP TABLE Loan;

CREATE TABLE Loan (
	LoanID				INT				PRIMARY KEY			IDENTITY(1000,1),
	AccountNumber		INT				NOT NULL,
	LoanType			CHAR(2)			NOT NULL,
	LoanAmount			DECIMAL(15, 2)	NOT NULL,
	CurrentBalance		DECIMAL(15, 2)	NOT NULL,	-- NEW COLUMN!!
	InterestRate		DECIMAL(5, 2)	NOT NULL,
	LoanTerm			INT				NOT NULL,
	ApprovalDate		DATE			NOT NULL,
	PayOffDate			DATE			NOT NULL,

	CONSTRAINT FK_Loan_AccountNumber FOREIGN KEY (AccountNumber) REFERENCES Account(AccountNumber) ON DELETE CASCADE,
	CONSTRAINT CK_Loan_LoanType	CHECK(LoanType IN('AA', 'MM', 'BB', 'RV', 'HH', 'PP', 'SS'))
);

INSERT INTO Loan (AccountNumber, LoanType, LoanAmount, CurrentBalance, InterestRate, LoanTerm, ApprovalDate, PayOffDate) -- LoanID is auto generated and left out of INSERT statement intentionaly --
VALUES

(1420,'SS',78108,46864.8,21.49,96,'2021-11-10','2029-09-29'),
(1421,'RV',63235,37941,12.3,60,'2007-10-21','2012-09-24'),
(1422,'BB',264647,158788.2,5.8,48,'2017-10-04','2021-09-13'),
(1423,'AA',103682,62209.2,27.98,84,'2015-02-10','2022-01-04'),
(1424,'BB',239991,143994.6,14.26,60,'2007-08-05','2012-07-09'),
(1425,'BB',116150,69690,25.14,84,'2014-01-11','2020-12-05'),
(1426,'RV',151763,91057.8,14.85,36,'2015-03-24','2018-03-08'),
(1427,'HH',635023,381013.8,13.84,360,'2006-10-22','2036-05-17'),
(1428,'MM',10039,6023.4,6.69,48,'2002-07-11','2006-06-20'),
(1429,'SS',86862,52117.2,22.2,36,'2018-11-28','2021-11-12'),
(1430,'HH',216396,129837.6,19.26,180,'2012-04-16','2027-01-28'),
(1431,'MM',2954,1772.4,27.96,48,'2003-02-20','2007-01-30'),
(1432,'HH',644543,386725.8,27.78,360,'2018-06-10','2048-01-04'),
(1433,'SS',21712,13027.2,17.2,36,'2015-02-14','2018-01-29'),
(1434,'SS',37659,22595.4,8.78,36,'2010-04-10','2013-03-25'),
(1435,'MM',14801,8880.6,3.53,72,'2011-08-05','2017-07-04'),
(1436,'HH',525436,315261.6,11.42,360,'2011-04-16','2040-11-09'),
(1437,'AA',6579,3947.4,22.82,60,'2013-08-07','2018-07-12'),
(1438,'RV',179830,107898,28.5,36,'2009-04-10','2012-03-25'),
(1439,'MM',3767,2260.2,8.99,60,'2015-07-12','2020-06-15'),
(1440,'PP',6617,3970.2,2.92,84,'2015-11-07','2022-10-01'),
(1441,'HH',970255,582153,13.93,180,'2022-12-23','2037-10-05'),
(1442,'AA',143654,86192.4,16.83,48,'2010-03-16','2014-02-23'),
(1443,'RV',180137,108082.2,29.13,60,'2021-02-05','2026-01-10'),
(1444,'AA',73447,44068.2,19.61,48,'2004-06-10','2008-05-20'),
(1445,'SS',56696,34017.6,2.75,72,'2018-07-24','2024-06-22'),
(1446,'HH',199282,119569.2,25.3,180,'2015-09-24','2030-07-07'),
(1447,'AA',39927,23956.2,27.46,48,'2007-02-10','2011-01-20'),
(1448,'AA',164737,98842.2,21.35,36,'2023-11-08','2026-10-23'),
(1449,'HH',386096,231657.6,18.48,360,'2005-05-10','2034-12-04'),
(1450,'MM',20090,12054,18.09,48,'2001-08-08','2005-07-18'),
(1451,'MM',12555,7533,3.06,84,'2007-01-13','2013-12-07'),
(1452,'PP',4358,2614.8,26.77,84,'2001-03-26','2008-02-18'),
(1453,'RV',168040,100824,26.73,48,'2004-07-22','2008-07-01'),
(1454,'PP',2261,1356.6,14.33,84,'2014-06-22','2021-05-16'),
(1455,'HH',360581,216348.6,30.25,360,'2023-06-16','2053-01-09'),
(1456,'SS',79692,47815.2,3.56,60,'2014-03-10','2019-02-12'),
(1457,'AA',122135,73281,11.15,60,'2016-02-03','2021-01-07'),
(1458,'BB',517352,310411.2,11.28,84,'2003-05-01','2010-03-25'),
(1459,'HH',735233,441139.8,16.42,360,'2005-08-03','2035-02-27'),
(1460,'AA',57151,34290.6,10.47,72,'2011-04-12','2017-03-11'),
(1461,'HH',699413,419647.8,25.4,180,'2016-03-08','2030-12-20'),
(1462,'RV',189416,113649.6,11.87,84,'2015-02-05','2021-12-30'),
(1463,'BB',163130,97878,1.22,96,'2008-03-23','2016-02-10'),
(1464,'AA',92415,55449,12.69,96,'2003-02-15','2011-01-04'),
(1465,'AA',6733,4039.8,17.94,96,'2005-07-05','2013-05-24'),
(1466,'MM',6199,3719.4,12.99,72,'2007-04-09','2013-03-08'),
(1467,'SS',93102,55861.2,21.49,72,'2019-06-17','2025-05-16'),
(1468,'SS',84634,50780.4,27.23,36,'2002-07-07','2005-06-21'),
(1469,'PP',1932,1159.2,19.83,36,'2006-12-15','2009-11-29'),
(1470,'AA',122160,73296,26.69,96,'2014-10-05','2022-08-24'),
(1471,'BB',89146,53487.6,2.85,60,'2020-05-10','2025-04-14'),
(1472,'BB',565389,339233.4,3.93,72,'2009-08-21','2015-07-21'),
(1473,'PP',4931,2958.6,2.2,60,'2002-07-10','2007-06-14'),
(1474,'MM',23951,14370.6,23.81,48,'2023-07-27','2027-07-06'),
(1475,'PP',5150,3090,30.46,84,'2004-10-25','2011-09-19'),
(1476,'RV',243157,145894.2,26.58,72,'2007-08-16','2013-07-15'),
(1477,'HH',474267,284560.2,23.97,180,'2007-12-08','2022-09-20'),
(1478,'RV',206148,123688.8,22.71,72,'2002-04-24','2008-03-23'),
(1479,'MM',3093,1855.8,13.72,60,'2018-06-09','2023-05-14'),
(1480,'RV',187525,112515,2.86,84,'2009-05-28','2016-04-21'),
(1481,'AA',59314,35588.4,23.18,96,'2023-09-11','2031-07-31'),
(1482,'MM',6672,4003.2,14.45,60,'2008-08-13','2013-07-18'),
(1483,'AA',53569,32141.4,4.88,48,'2012-09-04','2016-08-14'),
(1484,'RV',239619,143771.4,8.79,36,'2005-05-06','2008-04-20'),
(1485,'HH',643696,386217.6,4.89,180,'2006-04-05','2021-01-16'),
(1486,'PP',3632,2179.2,6.1,96,'2008-03-07','2016-01-25'),
(1487,'RV',219976,131985.6,22.52,60,'2006-10-15','2011-09-19'),
(1488,'HH',664264,398558.4,22.88,360,'2015-06-03','2044-12-27'),
(1489,'MM',5870,3522,2.19,72,'2011-11-08','2017-10-07'),
(1490,'AA',163312,97987.2,3.22,96,'2004-10-01','2012-08-20'),
(1491,'HH',817794,490676.4,10.06,180,'2007-04-14','2022-01-25'),
(1492,'PP',8769,5261.4,20.52,96,'2004-08-12','2012-07-01'),
(1493,'MM',16139,9683.4,28.4,36,'2012-07-17','2015-07-02'),
(1494,'PP',2910,1746,1.05,72,'2001-06-28','2007-05-28'),
(1495,'AA',125198,75118.8,8.39,84,'2021-04-07','2028-03-01'),
(1496,'BB',15163,9097.8,17.33,96,'2016-03-16','2024-02-03'),
(1497,'BB',214823,128893.8,3.4,60,'2013-02-27','2018-02-01'),
(1498,'HH',902683,541609.8,14.57,180,'2018-06-09','2033-03-22'),
(1499,'MM',8309,4985.4,29.34,96,'2009-11-02','2017-09-21'),
(1500,'MM',12071,7242.6,24.73,60,'2017-11-05','2022-10-10'),
(1501,'MM',7532,4519.2,18.65,48,'2016-05-27','2020-05-06'),
(1502,'SS',32476,19485.6,4.35,48,'2004-08-09','2008-07-19'),
(1503,'RV',231606,138963.6,13.05,60,'2016-03-14','2021-02-16'),
(1504,'RV',74178,44506.8,12.12,48,'2009-11-20','2013-10-30'),
(1505,'PP',7585,4551,16.6,84,'2013-06-19','2020-05-13'),
(1506,'BB',514548,308728.8,26.84,60,'2023-07-08','2028-06-11'),
(1507,'RV',204525,122715,28.54,60,'2014-02-11','2019-01-16'),
(1508,'PP',5436,3261.6,5.51,36,'2012-06-14','2015-05-30'),
(1509,'AA',157936,94761.6,24.04,72,'2008-03-18','2014-02-15'),
(1510,'MM',13731,8238.6,2.93,48,'2005-03-01','2009-02-08'),
(1511,'BB',188961,113376.6,10.51,48,'2021-11-18','2025-10-28'),
(1512,'RV',61711,37026.6,23.14,96,'2001-08-11','2009-06-30'),
(1513,'RV',221508,132904.8,8.11,72,'2021-01-01','2026-12-01'),
(1514,'HH',200517,120310.2,26.41,360,'2010-10-14','2040-05-09'),
(1515,'HH',468642,281185.2,6.76,180,'2004-03-15','2018-12-27'),
(1516,'AA',129002,77401.2,14.49,36,'2022-12-09','2025-11-23'),
(1517,'RV',138773,83263.8,8.16,96,'2020-03-27','2028-02-14'),
(1518,'AA',88435,53061,29.68,96,'2019-05-06','2027-03-25'),
(1519,'SS',31876,19125.6,18.9,84,'2014-05-12','2021-04-05'),
(1520,'RV',130581,78348.6,21.86,72,'2007-04-27','2013-03-26'),
(1521,'AA',78571,47142.6,30.88,48,'2010-12-12','2014-11-21'),
(1522,'RV',197418,118450.8,8.94,60,'2014-10-11','2019-09-15'),
(1523,'PP',6871,4122.6,28.2,96,'2017-01-24','2024-12-13'),
(1524,'BB',346680,208008,9.51,72,'2008-10-15','2014-09-14'),
(1525,'MM',7897,4738.2,5.15,84,'2007-02-13','2014-01-07'),
(1526,'PP',1451,870.6,1.81,60,'2010-07-03','2015-06-07'),
(1527,'PP',7918,4750.8,20.9,84,'2011-03-06','2018-01-28')
;

UPDATE Account
SET AccountStatus = '11'
WHERE AccountType = 'CH' OR AccountType = 'SS';
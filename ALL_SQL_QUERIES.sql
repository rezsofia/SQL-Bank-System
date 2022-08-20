-- Drop the database 'BRAINSTER_2'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Uncomment the ALTER DATABASE statement below to set the database to SINGLE_USER mode if the drop database command fails because the database is in use.
-- ALTER DATABASE BRAINSTER_2 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- Drop the database if it exists
IF EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'BRAINSTER_RECAP_DB1'
)
DROP DATABASE BRAINSTER_RECAP_DB1
GO

-- Create a new database called 'BRAINSTER_RECAP_1'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'BRAINSTER_RECAP_1'
)
CREATE DATABASE BRAINSTER_RECAP_1
GO

/* ----------------------------------------------------------------------- W1D1 --------------------------------------------------------------------------------------------------------------------------

-- Create employee table

CREATE TABLE [dbo].[Employee]
(
    [ID] [int] IDENTITY(1,1) NOT NULL,
    [FirstName] [nvarchar](100) NOT NULL,
    [LastName] [nvarchar](100) NOT NULL,
    [NationalIDNumber] [nvarchar](15) NULL,
    [JobTitle] [nvarchar](50) NULL,
    [DateOfBirth] [date] NULL,
    [MaritalStatus] [nchar](1) NULL,
    [Gender] [nchar](1) NULL,
    [HireDate] [date] NULL,
    CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
[ID] ASC
)
)
GO

-- Try select 
SELECT *
FROM Employee
WHERE FirstName = 'Aliz'

-- Update value
UPDATE dbo.Employee SET FirstName='Ali'
WHERE FirstName='Aliz'

-- Create constraint
ALTER TABLE dbo.Employee
Add CONSTRAINT My_Constraint
DEFAULT 'M' for Gender

-- Insert value to table 

INSERT INTO dbo.Employee
    (FirstName, LastName)
VALUES
    ('Test2', 'Elek2')

-- Create constraint with current date 
ALTER TABLE dbo.Employee
ADD CONSTRAINT DATE 
DEFAULT GETDATE() FOR HireDate

-- Drop constraint DATE_of_Birth

ALTER TABLE dbo.Employee DROP CONSTRAINT DATE_of_Birth

-- Create constraint with current date minus 30 years
ALTER TABLE dbo.Employee
ADD CONSTRAINT DATE_of_Birth 
DEFAULT dateadd(year, -30, getdate()) FOR DateOfBirth

-- Drop a column
ALTER TABLE dbo.Employee
DROP COLUMN NationalIDNumber

-- Add a column
ALTER TABLE dbo.Employee
ADD NationalIDNumber NVARCHAR(50)

-- Add unique id by default to a column
UPDATE dbo.Employee SET NationalIDNumber = newid() WHERE NationalIDNumber is null

-- Add unique constraint for NationalIDNumber column

ALTER TABLE dbo.Employee WITH CHECK
ADD CONSTRAINT UC_Employee_NationalId UNIQUE (NationalIDNumber) */

----------------------------------------------------------------------- W1D2 --------------------------------------------------------------------------------------------------------------------------

-- Bank personal accounts db 
-- Tables
        -- Employee
        -- Customer
        -- Account
        -- Transactions
        -- Currency
        -- Location


-- Drop a table called 'Employee' in schema 'dbo'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Employee]', 'U') IS NOT NULL
DROP TABLE [dbo].[Employee]
GO

CREATE TABLE [dbo].[Employee]
(
    Id int IDENTITY(1,1) NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    NationalIDNumber NVARCHAR(15) NULL,
    JobTitle NVARCHAR(50) NULL,
    DateOfBirth DATE NULL,
    MaritalStatus NVARCHAR(1) NULL,
    Gender NVARCHAR(1) NULL,
    HireDate DATE NULL,
    CONSTRAINT PK_Employee Primary Key Clustered (Id)
)

-- Create a new table called '[Customer]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Customer]', 'U') IS NOT NULL
DROP TABLE [dbo].[Customer]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Customer]
(
    [Id] INT IDENTITY(1,1) NOT NULL, -- Primary Key column
    [FirstName] NVARCHAR(50) NOT NULL,
    [LastName] NVARCHAR(50) NOT NULL,
    [Gender] NCHAR(1) NULL,
    [NationalIDNumber] NVARCHAR(15) NULL,
    [DateOfBirth] DATE NULL,
    [City] NVARCHAR(100) NULL,
    [RegionName] NVARCHAR(100) NULL,
    [PhoneNumber] NVARCHAR(20) NULL,
    [isActive] BIT NOT NULL,
    CONSTRAINT PK_Customer Primary Key Clustered (Id)
    -- Specify more columns here
);
GO

-- Create a new table called '[Currency]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Currency]', 'U') IS NOT NULL
DROP TABLE [dbo].[Currency]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Currency]
(
    [Id] INT IDENTITY(1,1) NOT NULL, -- Primary Key column
    [Code] NVARCHAR(50) NULL,
    [Name] NVARCHAR(100) NULL, 
    [ShortName] NVARCHAR(20) NULL,
    [CountryName] NVARCHAR(100) NULL,
    CONSTRAINT PK_Currency Primary Key Clustered (Id)
);
GO

-- Create a new table called '[Location]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[LocationType]', 'U') IS NOT NULL
DROP TABLE [dbo].[LocationType]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[LocationType]
(
    [Id] INT IDENTITY(1,1) NOT NULL , -- Primary Key column
    [Name] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(50) NULL
    CONSTRAINT PK_LocationType Primary Key Clustered (Id)
);
GO

-- Create a new table called '[Account]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Account]', 'U') IS NOT NULL
DROP TABLE [dbo].[Account]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Account]
(
    [Id] INT IDENTITY(1,1) NOT NULL, -- Primary Key column
    [AccountNumber] NVARCHAR(20) NULL,
    [CustomerId] INT NOT NULL,
    [CurrencyId] INT NOT NULL,
    [AllowedOverdraft] DECIMAL(18,2) NULL,
    [CurrentBalance] DECIMAL(18,2) NULL,
    [EmployeeId] INT NOT NULL,
    CONSTRAINT PK_Account Primary Key Clustered (Id)
);
GO

-- Create a new table called '[AccountDetails]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[AccountDetails]', 'U') IS NOT NULL
DROP TABLE [dbo].[AccountDetails]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[AccountDetails]
(
    [Id] INT IDENTITY(1,1) NOT NULL, -- Primary Key column
    [AccountId] INT NOT NULL,
    [LocationId] INT NOT NULL,
    [EmployeeId] INT NULL,
    [TransactionDate] DATETIME NOT NULL,
    [Amount] DECIMAL(18,2) NOT NULL,
    [PurposeCode] SMALLINT NULL,
    [PurposeDescription] NVARCHAR(100) NULL
    CONSTRAINT PK_AccountDetails Primary Key Clustered (Id)
);
GO

-- Create a new table called '[LocationType]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Location]', 'U') IS NOT NULL
DROP TABLE [dbo].[Location]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Location]
(
    [Id] INT IDENTITY(1,1) NOT NULL , -- Primary Key column
    [LocationTypeId] INT NOT NULL,
    [Name] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(50) NULL
    CONSTRAINT PK_Location Primary Key Clustered (Id)
);
GO

----------------------------------------------------------------------- W1D3 --------------------------------------------------------------------------------------------------------------------------

--Foreign Keys

ALTER TABLE dbo.Account WITH CHECK 
ADD CONSTRAINT FK_Account_Employee FOREIGN KEY (EmployeeId)
REFERENCES dbo.Employee

ALTER TABLE dbo.Account WITH CHECK 
ADD CONSTRAINT FK_Currency_Account FOREIGN KEY (CurrencyId)
REFERENCES dbo.Currency
GO

ALTER TABLE [dbo].[Location]  WITH CHECK ADD  CONSTRAINT [FK_Location_LocationType] FOREIGN KEY([LocationTypeId])
REFERENCES [dbo].[LocationType] ([Id])
GO

ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Currency] FOREIGN KEY([CurrencyId])
REFERENCES [dbo].[Currency] ([id])
GO

ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Customer]

GO
ALTER TABLE [dbo].[AccountDetails]  WITH CHECK ADD  CONSTRAINT [FK_AccountDetails_Account] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Account] ([Id])
GO
ALTER TABLE [dbo].[AccountDetails] CHECK CONSTRAINT [FK_AccountDetails_Account]
GO


ALTER TABLE [dbo].[AccountDetails]  WITH CHECK ADD  CONSTRAINT [FK_AccountDetails_Location] FOREIGN KEY([LocationId])
REFERENCES [dbo].[Location] ([Id])
GO

-- Populate the tables used for the USECASE

DROP TABLE IF EXISTS #City;
DROP TABLE IF EXISTS #nums;

CREATE TABLE #City (Name nvarchar(100))
INSERT INTO #City values ('Vienna'),('Graz'),('Linz'),('Salzburg'),('Innsbruck'),('Bregenz'),('Sankt Polten'),('Klagenfurt'),('Wels')
GO

Create table #nums (id int, idText nvarchar(100))
insert into #nums
select top 100 row_Number() OVER (Order by (select 0)) as id, cast(row_Number() OVER (Order by (select 0)) as nvarchar(100)) as idText
FROM sys.objects


delete from dbo.AccountDetails where 1=1;
delete from dbo.Account where 1=1;
delete from dbo.Location where 1=1;
delete from dbo.LocationType where 1=1;
DELETE from dbo.Customer where 1=1;
DELETE from dbo.Currency where 1=1;
delete from dbo.Employee where 1=1;
GO

------ add rest of tables
--DBCC CHECKIDENT ('Employee', RESEED, 0)
--DBCC CHECKIDENT ('LocationType', RESEED, 0)
--DBCC CHECKIDENT ('Location', RESEED, 0)
--DBCC CHECKIDENT ('Currency', RESEED, 0)
--DBCC CHECKIDENT ('AccountDetails', RESEED, 0)
--DBCC CHECKIDENT ('Account', RESEED, 0)
--DBCC CHECKIDENT ('Customer', RESEED, 0)
--GO

insert into dbo.LocationType (Name,Description)
values ('Region Branch','Regional office')
GO


insert into dbo.LocationType (Name,Description)
values ('City Branch','City branch office')
GO

insert into dbo.LocationType (Name,Description)
values ('Internet','Internet from e-bank')
GO

insert into dbo.LocationType (Name,Description)
values ('ATM','ATM cash')
GO

insert into dbo.LocationType (Name,Description)
values ('Clearing House','Clearing House')
GO

--select * from dbo.locationType

-- location
insert into dbo.Location (LocationTypeId,Name)
values (1,'Bregenz branch office'), (1,'Innsbruck branch office'), (1,'Salzburg branch office'), (1,'St.Polten branch office'), (1,'St.Polten branch office'), 
(1,'Graz branch office'),(1,'Klagenfurt branch office'),(1,'Eisenstadt branch office')
GO

insert into dbo.Location (LocationTypeId,Name)
values (2,'Leonding city branch office'), (2,'Baden bei Wien city branch office'), (2,'Wolfsberg city branch office'), (2,'Steyr city branch office')
GO

insert into dbo.Location (LocationTypeId,Name)
values (3,'E-bank'), (3,'M-bank')
GO

insert into dbo.Location (LocationTypeId,Name)
select 4 as LocationTypeId , 'ATM ' + c.Name + ' ' + n.idText
from #City c 
cross apply #nums n 
where n.id <= 10
order by c.Name

insert into dbo.Location (LocationTypeId,Name)
values (5,'Daily clearing'), (5,'Fast clearing')
GO

--select * from dbo.locationtype
--select * from Location

-- Employee

-- Employee table
declare @FirstName table (FirstName nvarchar(50))
insert into @FirstName values ('Daniel'),('Dominik'),('David'),('Gerhard'),('Bianca'),('Clara'),('Lara'),('Lena'),('Lisa'),('Josef')

declare @LastName table (LastName nvarchar(50))
insert into @LastName values ('Eder'),('Fischer'),('Schmid'),('Winkler'),('Weber'),('Maier'),('Schneider'),('Wimmer'),('Lang'),('Wolf')

insert into dbo.Employee (FirstName,LastName,DateOfBirth,Gender,HireDate,NationalIdNumber)
select f.FirstName, l.LastName,'1900.01.01' as date, case when FirstName in ('Bianca','Clara','Lara','Lena','Lisa') then 'F' else 'M' end as Gender,'2015.01.01' as HireDate,1 as IdNumber
from @FirstName f
CROSS JOIN @LastName l
GO


update e set DateOfBirth = dateadd(MM,Id,DateOfBirth),  
			 HireDate = dateadd(MM,2*Id,'1990.01.01'), 
			 NationalIdNumber =  id + cast(10000000 * rand(id*10) as int)
from dbo.Employee e
GO


-- Customer data
DECLARE @WomanName table (FirstName nvarchar(50))
declare @FirstName table (FirstName nvarchar(50))
insert into @FirstName values ('Emilia'),('Sophia'),('Emma'),('Mia'),('Lily'),('Anna'),('Victoria'),('Maria'),('Luisa'),('Clara'),('Lea'),('Monika'),('Angela'),('Tea'),('Nora')

INSERT INTO @WomanName 
select * from @FirstName
-- males
insert into @FirstName values ('Matetheo'),('Elias'),('Alexander'),('Fin'),('Julian'),('Jacob'),('Lucas'),('Teo'),('Jordan'),('Maximilian'),('Jonas'),('Oliver'),('Anton'),('Jonathan'),('Felix')

declare @LastName table (LastName nvarchar(50))
insert into @LastName values ('Gruber'),('Huber'),('Bauer'),('Wagner'),('Miller'),('Pichler'),('Moser'),('Mayer'),('Hofer'),('Berger')


insert into dbo.customer (FirstName,LastName,DateOfBirth,Gender,NationalIdNumber, isActive)
select f.FirstName, l.LastName,'1900.01.01' as date, case when FirstName in (select FirstName from @WomanName) then 'F' else 'M' end as Gender,
1 as IdNumber, 1 as isActive
from @FirstName f
CROSS JOIN @LastName l

update e set DateOfBirth = dateadd(MM,Id,DateOfBirth),  
			 NationalIdNumber =  id + cast(10000000 * rand(id*10) as int),
			 City = case when id % 6 = 0 then 'Vienna' 
						 when id % 6 = 1 then 'Graz' 
						 when id % 6 = 2 then 'Linz' 
						 when id % 6 = 3 then 'Salzburg' 
						 when id % 6 = 4 then 'Innsbruck' 
						 when id % 6 = 5 then 'Bregenz' end
from dbo.customer e
GO

-- Currency rates
insert into dbo.Currency (code, Name, ShortName, CountryName) values ('978','Euro','EUR','European union')
insert into dbo.Currency (code, Name, ShortName, CountryName) values ('840','US Dollar','USD','UNITED STATES OF AMERICA')
insert into dbo.Currency (code, Name, ShortName, CountryName) values ('191','Kuna','HRK','CROATIA')
insert into dbo.Currency (code, Name, ShortName, CountryName) values ('807','Denar','MKD','MACEDONIA')
insert into dbo.Currency (code, Name, ShortName, CountryName) values ('752','Swedish Krona','SEK','SWEDEN')
insert into dbo.Currency (code, Name, ShortName, CountryName) values ('941','Serbian Dinar','RSD','SERBIA')
GO

-- Account

-- usd and eur accounts
insert into dbo.Account (AccountNumber,CustomerId,CurrencyId,AllowedOverdraft,CurrentBalance,EmployeeId)
select '210123456789012' as AcctNum, c.id, e.id as CurrencyId, 10000 as AllowedOverDraft, 0 as CurrentBalance, 1 AS EmployeeId
from dbo.Customer c
cross apply dbo.Currency e
where e.code in ('840','978')

update A set AccountNumber = CAST((cast(AccountNumber AS BIGINT) + id) AS nvarchar(20)) ,
AllowedOverdraft = a.AllowedOverdraft + 100*id ,
EmployeeId = (select top 1 id from dbo.Employee e where e.id%100 = a.id%100)
from dbo.Account A



-- Monthly salary
insert into dbo.AccountDetails
select a.id as AcctId, l.id as LocationId, null as EmployeeId,'2019.01.01' as TransactionDate,40000 + 25*a.id as Amount, '101' as purposeCode,'Salary inflow' as PurposeDescription
from dbo.Account a
cross apply dbo.Location l 
where l.name = 'Fast clearing'
and a.CurrencyId = 1

--(5,'Daily clearing'), (5,'Fast clearing')

-- Cash inflow transactions (USD)
insert into dbo.AccountDetails
select a.id as AcctId, l.id as LocationId, null as EmployeeId,'2019.01.01' as TransactionDate,1000 + l.Id*25 as Amount, '930' as purposeCode,'cash inflow' as PurposeDescription
from dbo.Account a
cross apply dbo.Location l 
where l.id %10 = a.id %100
and a.CurrencyId = 5

-- outflow transactions
insert into dbo.AccountDetails
select a.id as AcctId, l.id as LocationId, 
case when l.name like '%branch%' then (select top 1 id from dbo.Employee e where e.id%100 =  a.id %100) else null end as EmployeeId,
dateadd(dd,(a.id % 20 + l.id % 100),'2019.01.15')  as TransactionDate,- (972 + 13*l.Id) as Amount, '930' as purposeCode,'outflow' as PurposeDescription
from dbo.Account a
cross apply dbo.Location l 
where l.id %10 = a.id %10
and a.CurrencyId = 1


-- fine tuning of numbers
update d set Amount = Amount/10
from dbo.AccountDetails d


select * from dbo.Employee
select * from dbo.Currency
select * from dbo.Customer
select * from dbo.Location
select * from dbo.LocationType
select * from dbo.Account
select * from dbo.AccountDetails


-- Date formats

SELECT GETDATE() -- YYYY-MM-DD

SELECT CONVERT(varchar, GETDATE(),104) 

----------------------------------------------------------------------- W2D1 --------------------------------------------------------------------------------------------------------------------------

--Exercises:
    -- Add default constraint with value=930 on Purposecode in AccountDetails

    ALTER TABLE dbo.AccountDetails
    ADD CONSTRAINT PK_PurposeCode 
    DEFAULT 930 FOR PurposeCode

    -- Add Unique Constraint on NameColumn in Location table
        -- Add unique id by default to a column
        UPDATE dbo.Location SET Name = newid() WHERE Name is null
    
        -- See duplicates
            SELECT Name,
                COUNT(*) AS CNT
            FROM [dbo].[Location]
            GROUP BY [Name]
            HAVING COUNT(*) > 1;    

        --Delete duplicate with lowerid
            DELETE FROM [dbo].[Location]
                WHERE Id NOT IN
                (
                    SELECT MAX(Id) AS MaxRecordID
            FROM [dbo].[Location]
            GROUP BY [Name]
                );

        -- Create Constraint
        
            ALTER TABLE dbo.Location -- WITH CHECK
            ADD CONSTRAINT PK_Name_Unique
            UNIQUE (Name)

    -- Add check constraint on Account table to prevent inserting negative values in AllowedOverdraft column

        ALTER TABLE dbo.Account 
        ADD CONSTRAINT PK_NotNegative CHECK (AllowedOverdraft > 0) -- all should be in brakets

    
    -- List all Customers with FirstName = ‘Mia’


        SELECT *
        FROM dbo.Customer
        WHERE FirstName= 'Mia'

    -- List all Customers with FirstName = ‘Mia’ and LastName starting with letter G and Order the results by the LastName


        SELECT *
        FROM dbo.Customer
        WHERE FirstName= 'Mia' AND LastName LIKE 'G%' 
        ORDER BY LastName DESC

    -- Provide information about the total number of Customers with FirstName = ‘Mia’ OR LastName starting with G;

        SELECT COUNT(*)
        FROM dbo.Customer
        WHERE FirstName= 'Mia' OR LastName LIKE 'G%' 

    -- List all Customers that are born in February (any year)

  
        SELECT *
        FROM dbo.Customer
        WHERE MONTH(DateOfBirth)='02' 

    -- List all Customers that are born in February (any year) or their last name starts with G

    
        SELECT *
        FROM dbo.Customer
        WHERE MONTH(DateOfBirth)='02' OR LastName LIKE 'G%' 

    -- Provide total number of Female customers from Vienna

        SELECT COUNT(*) FROM dbo.Customer WHERE City='Vienna'
    -- Provide total number of customers born in Odd months in any year

        SELECT COUNT(*) FROM dbo.Customer WHERE MONTH(DateOfBirth)%2<>0

    -- Calculate how many customers from each city are there in the system

        SELECT City, COUNT(*)
        FROM dbo.Customer
        GROUP BY City

    -- Calculate how many customers from each city are in the system 

        SELECT City,Gender, COUNT(*)
        FROM dbo.Customer
        GROUP BY City, Gender

    -- List only cities having more then 25 Female customers 

        SELECT City,Gender,  COUNT(*) AS Num_of_F
        FROM dbo.Customer
        WHERE Gender='F' 
        GROUP BY City, Gender
        HAVING COUNT(*)>25

    -- Joins

        -- 1. Inner Join --> Contains inner section, present in both 
        -- Example

        CREATE TABLE dbo.TableA (idA int)

        CREATE TABLE dbo.TableB (idB int)

        ALTER TABLE dbo.TableB add NewColumn INT NULL

        INSERT INTO dbo.TableA values (1),(2),(5),(6),(7)
        INSERT INTO dbo.TableB values (2),(3),(7)

        SELECT * FROM dbo.TableA
        SELECT * FROM dbo.TableB

        SELECT *
        FROM dbo.TableA as A
        INNER JOIN dbo.TableB as B on A.idA = B.idB

        -- Example 2

        SELECT * from dbo.Account
        SELECT * from dbo.Currency


        SELECT AccountNumber,AllowedOverdraft,ShortName
        FROM dbo.Account as a
        INNER JOIN dbo.Currency as c on a.CurrencyId = c.Id
        WHERE a.AccountNumber = '210123456789025'

        -- List all information for acc and gender of customer

        SELECT *, c.Gender
        FROM dbo.Account as a
        INNER JOIN dbo.Customer as c on a.CustomerId = c.Id

        -- 2. LEFT OUTER Join --> Contains ALL FROM LEFT AND MATCHING FROM the Other table 

        select * from dbo.Account
        select * from dbo.Currency

        -- find all curencies for which we dont have any open accounts

        select ShortName 
        from dbo.Currency as c 
        left join dbo.Account as a on a.CurrencyId = c.id
        where a.CurrencyId is NOT null

        -- 3. FUll JOINS
        
        select  a.*,b.*
        from dbo.TableB as b
        FULL join dbo.Tablea as a on a.idA = b.idB

        -- 4. Cross join

        SELECT a.*, b.*
        from dbo.TableA as a
        cross join dbo.TableB as b

----------------------------------------------------------------------- W2D2 --------------------------------------------------------------------------------------------------------------------------

    --List all acoounts in the system. Show the data for AccountNumber, CustomerName and CurrentBalance

    SELECT COUNT(*)
    FROM dbo.Account as A
    LEFT JOIN dbo.Customer as C ON A.CustomerId=C.Id

    SELECT COUNT(*)
    FROM dbo.Account as A
    INNER JOIN dbo.Customer as C ON A.CustomerId=C.Id

    -- Extend the previous query to show also CurrencyName

    SELECT A.AccountNumber, C.FirstName, C.LastName, A.CurrentBalance, Cu.Name
    FROM dbo.Account as A
    LEFT JOIN dbo.Customer as C ON A.CustomerId=C.Id
    LEFT JOIN dbo.Currency  as Cu ON Cu.Id=A.CurrencyId

    SELECT A.AccountNumber, C.FirstName, C.LastName, A.CurrentBalance, Cu.Name
    FROM dbo.Account as A
    INNER JOIN dbo.Customer as C ON A.CustomerId=C.Id
    INNER JOIN dbo.Currency  as Cu ON Cu.Id=A.CurrencyId

    -- Extend previous with Firstname, Lastname and HireDate of Employee that opened the account

    SELECT A.AccountNumber, C.FirstName, C.LastName, A.CurrentBalance, Cu.Name AS CurrencyName, E.FirstName, E.LastName, E.HireDate
    FROM dbo.Account as A
    LEFT JOIN dbo.Customer as C ON A.CustomerId=C.Id
    LEFT JOIN dbo.Currency  as Cu ON Cu.Id=A.CurrencyId
    LEFT JOIN dbo.Employee  as E ON E.Id=A.EmployeeId    --Inner join have to be used in case the employee id can be null in the firt table


    -- Insert one new customer, don't insert an account for it

    -- Try inner and left join
        --First table to be account
        --First table to be customer
        --Where statement to filter just the new customer
    
    --Compare the differences
    --Insert account for the new customer


    SELECT * FROM dbo.Customer
    WHERE FirstName='Kiss'

    INSERT INTO dbo.Customer (FirstName, LastName, Gender, NationalIDNumber, DateOfBirth, isActive)
    VALUES ('Kiss', 'Hanna', 'F', cast(8999999*rand() as int)+1000000, (DATEADD(day, (ABS(CHECKSUM(NEWID())) % 65530), 0)), 1)



    SELECT *
    FROM dbo.Account AS A
    INNER JOIN dbo.Customer AS C ON C.Id=A.CustomerId
    WHERE C.Id=301

    SELECT *
    FROM dbo.Account AS A
    LEFT JOIN dbo.Customer AS C ON C.Id=A.CustomerId
    WHERE C.Id=301

    SELECT *
    FROM dbo.Customer AS C
    INNER JOIN dbo.Account AS A ON C.Id=A.CustomerId
    WHERE C.Id=301

    SELECT *
    FROM dbo.Customer AS C
    LEFT JOIN dbo.Account AS A ON C.Id=A.CustomerId
    WHERE C.Id=301


    SELECT * FROM dbo.Account

    INSERT INTO dbo.Account (AccountNumber, CustomerId,CurrencyId, AllowedOverdraft, CurrentBalance, EmployeeId) 
    VALUES (cast(8999999*rand() as int)+100000000000, 301, 1, 100000, 0, 12)


    -- List all Employee first names
        -- Remove duplicate first name

    -- List all emoloyee first names and customer first names in single resultset (with duplicates)
        -- Remove duplicate first names on previous list (without duplicates)

    SELECT distinct  FirstName    FROM dbo.Employee

    SELECT FirstName
    FROM dbo.Employee
    GROUP BY FirstName

    SELECT FirstName
    FROM dbo.Employee
    UNION ALL
    SELECT FirstName
    FROM dbo.Employee
    
    SELECT FirstName
    FROM dbo.Employee 
    UNION  
    SELECT FirstName
    FROM dbo.Customer 

    -- List all Accounts in the system show data for AccountNummber, CustomerName and CurrentBalance

    SELECT * FROM dbo.Account
    SELECT * FROM dbo.Customer
    SELECT * FROM dbo.Employee

    SELECT A.AccountNumber, C.FirstName, A.CurrentBalance, E.LastName, Cu.ShortName
    FROM dbo.Account AS A
    INNER JOIN dbo.Customer as C ON C.Id=A.CustomerId
    INNER JOIN dbo.Employee AS E ON E.Id=A.EmployeeId
    INNER JOIN dbo.Currency AS Cu ON Cu.Id=A.CustomerId
    WHERE E.LastName='Eder' and Cu.ShortName LIKE 'USD'

    --Find all Currencies for which there are open accounts in the system

    SELECT DISTINCT Cu.Name 
    FROM dbo.Currency AS Cu
    LEFT JOIN dbo.Account AS A ON A.CurrencyId=Cu.Id
    WHERE A.Id is NOT NULL
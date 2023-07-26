CREATE DATABASE BuyHere
GO
USE BuyHere
GO


IF OBJECT_ID('CardDetails')  IS NOT NULL
DROP TABLE CardDetails
GO
IF OBJECT_ID('PurchaseDetails')  IS NOT NULL
DROP TABLE PurchaseDetails
GO
IF OBJECT_ID('Products')  IS NOT NULL
DROP TABLE Products
GO
IF OBJECT_ID('Categories')  IS NOT NULL
DROP TABLE Categories
GO
IF OBJECT_ID('Users')  IS NOT NULL
DROP TABLE Users
GO
IF OBJECT_ID('Roles')  IS NOT NULL
DROP TABLE Roles
GO


CREATE TABLE Roles
(
	[RoleId] TINYINT CONSTRAINT pk_RoleId PRIMARY KEY IDENTITY,
	[RoleName] VARCHAR(20) CONSTRAINT uq_RoleName UNIQUE
)
GO 

CREATE TABLE Users
(
	[EmailId] VARCHAR(50) CONSTRAINT pk_EmailId PRIMARY KEY,
	[UserPassword] VARCHAR(15) NOT NULL,
	[RoleId] TINYINT CONSTRAINT fk_RoleId REFERENCES Roles(RoleId),
	[Gender] CHAR CONSTRAINT chk_Gender CHECK(Gender='F' OR Gender='M') NOT NULL,
	[DateOfBirth] DATE CONSTRAINT chk_DateOfBirth CHECK(DateOfBirth<GETDATE()) NOT NULL,
	[Address] VARCHAR(200) NOT NULL
)
GO

CREATE TABLE Categories
(
	[CategoryId] TINYINT CONSTRAINT pk_CategoryId PRIMARY KEY IDENTITY,
	[CategoryName] VARCHAR(20) CONSTRAINT uq_CategoryName UNIQUE NOT NULL 
)
GO

CREATE TABLE Products
(
	[ProductId] CHAR(4) CONSTRAINT pk_ProductId PRIMARY KEY CONSTRAINT chk_ProductId CHECK(ProductId LIKE 'P%'),
	[ProductName] VARCHAR(50) CONSTRAINT uq_ProductName UNIQUE NOT NULL,
	[CategoryId] TINYINT CONSTRAINT fk_CategoryId REFERENCES Categories(CategoryId),
	[Price] NUMERIC(8) CONSTRAINT chk_Price CHECK(Price>0) NOT NULL,
	[QuantityAvailable] INT CONSTRAINT chk_QuantityAvailable CHECK (QuantityAvailable>=0) NOT NULL
)
GO

CREATE TABLE PurchaseDetails
(
	[PurchaseId] BIGINT CONSTRAINT pk_PurchaseId PRIMARY KEY IDENTITY(1000,1),
	[EmailId] VARCHAR(50) CONSTRAINT fk_EmailId REFERENCES Users(EmailId),
	[ProductId] CHAR(4) CONSTRAINT fk_ProductId REFERENCES Products(ProductId),
	[QuantityPurchased] SMALLINT CONSTRAINT chk_QuantityPurchased CHECK(QuantityPurchased>0) NOT NULL,
	[DateOfPurchase] SMALLDATETIME CONSTRAINT chk_DateOfPurchase CHECK(DateOfPurchase<=GETDATE()) DEFAULT GETDATE() NOT NULL,
)
GO

CREATE TABLE CardDetails
(
	[CardNumber] NUMERIC(16) CONSTRAINT pk_CardNumber PRIMARY KEY,
	[NameOnCard] VARCHAR(40) NOT NULL,
	[CardType] CHAR(6) NOT NULL CONSTRAINT chk_CardType CHECK (CardType IN ('A','M','V')),
	[CVVNumber] NUMERIC(3) NOT NULL,
	[ExpiryDate] DATE NOT NULL CONSTRAINT chk_ExpiryDate CHECK(ExpiryDate>=GETDATE()),
	[Balance] DECIMAL(10,2) CONSTRAINT chk_Balance CHECK([Balance]>=0)
)
GO


CREATE INDEX ix_RoleId ON Users(RoleId)
CREATE INDEX ix_CategoryId ON Products(CategoryId)
CREATE INDEX ix_EmailId ON PurchaseDetails(EmailId)
CREATE INDEX ix_ProductId ON PurchaseDetails(ProductId)
GO


--insertion scripts for roles
SET IDENTITY_INSERT Roles ON
INSERT INTO Roles (RoleId, RoleName) VALUES (1, 'Admin')
INSERT INTO Roles (RoleId, RoleName) VALUES (2, 'Customer')
SET IDENTITY_INSERT Roles OFF

--insertion scripts for Users

INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Nagy@gmail.com','FRANS@1234',2,'F','1978-02-05','Via Monte Bianco 34')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Rourke@gmail.com','FURIB@1234',2,'F','1967-10-24','Jardim das rosas n. 32')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Ottlieb@gmail.com','GALED@1234',2,'F','1960-05-26','Rambla de Cataluña, 23')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Paolino@gmail.com','GODOS@1234',2,'M','1961-08-29','C/ Romero, 33')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Parente@gmail.com','GOURL@1234',2,'F','1963-04-25','Av. Brasil, 442')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Pontes@gmail.com','GROSR@1234',2,'M','1962-09-29','5ª Ave. Los Palos Grandes')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Rance@gmail.com','HANAR@1234',2,'M','1986-04-30','Rua do Paço, 67')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Roel@gmail.com','HILAA@1234',2,'M','1983-12-28','Carrera 22 con Ave. Carlos Soublette #8-35')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Roulet@gmail.com','HUNGC@1234',2,'M','1981-04-14','City Center Plaza 516 Main St.')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Saveley@gmail.com','HUNGO@1234',2,'F','1970-11-07','8 Johnstown Road')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Schmitt@gmail.com','ISLAT@1234',2,'F','1974-09-19','Garden House Crowther Way')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Rine_Jamwal@yahoo.com','spacejet',2,'F','1991-07-20','R S Puram, Coimbatore')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Smith@gmail.com','KOENE@1234',2,'M','1985-05-08','Maubelstr. 90')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Snyder@gmail.com','LACOR@1234',2,'M','1985-11-03','67, avenue de l Europe')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Sommer@gmail.com','LAMAI@1234',2,'F','1968-09-08','1 rue Alsace-Lorraine')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Thomas@gmail.com','LAUGB@1234',2,'M','1986-11-15','1900 Oak St.')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Tonini@gmail.com','LAZYK@1234',2,'M','1988-11-11','12 Orchestra Terrace')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Mess@gmail.com','LEHMS@1234',2,'F','1964-07-30','Magazinweg 7')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Jai@gmail.com','LETSS@1234',2,'F','1971-01-21','87 Polk St. Suite 5')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Janine@gmail.com','RATTC@1234',2,'F','1964-12-12','2817 Milton Dr.')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Maria@gmail.com','REGGC@1234',2,'M','1980-04-11','Strada Provinciale 124')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Yoshi@gmail.com','RICAR@1234',2,'F','1961-08-28','Av. Copacabana, 267')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Paula@gmail.com','THEBI@1234',2,'M','1980-08-05','89 Jefferson Way Suite 2')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Manuel@gmail.com','THECR@1234',2,'M','1988-10-15','55 Grizzly Peak Rd.')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Mariaa@gmail.com','TOMSP@1234',2,'F','1987-11-29','Luisenstr. 48')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Martine@gmail.com','TORTU@1234',2,'M','1985-05-08','Avda. Azteca 123')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Diego@gmail.com','TRADH@1234',2,'F','1983-02-16','Av. Inês de Castro, 414')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Annette@gmail.com','TRAIH@1234',2,'M','1981-05-03','722 DaVinci Blvd.')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Mary@gmail.com','VAFFE@1234',2,'F','1977-10-09','Smagsloget 45')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Carine@gmail.com','VICTE@1234',2,'F','1982-12-27','2, rue du Commerce')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Margaret@gmail.com','VINET@1234',2,'M','1979-08-16','59 rue de l Abbaye')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Howard@gmail.com','WANDK@1234',2,'F','1982-06-02','Adenauerallee 900')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Martin@gmail.com','WARTH@1234',2,'M','1989-12-15','Torikatu 38')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Gary@gmail.com','WELLI@1234',2,'F','1968-12-27','Rua do Mercado, 12')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Daniel@gmail.com','WHITC@1234',2,'M','1978-05-22','305 - 14th Ave. S. Suite 3B')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('mat@gmail.com','WILMK@1234',2,'M','1977-01-13','Keskuskatu 45')
INSERT INTO Users( EmailId,UserPassword,RoleId,Gender, DateOfBirth,Address) VALUES('Davis@gmail.com','WOLZA@1234',2,'M','1982-01-09','ul. Filtrowa 68')

-- insertion script for Categories
SET IDENTITY_INSERT Categories ON
INSERT INTO Categories (CategoryId, CategoryName) VALUES (1, 'Motors')
INSERT INTO Categories (CategoryId, CategoryName) VALUES (2, 'Fashion')
INSERT INTO Categories (CategoryId, CategoryName) VALUES (3, 'Electronics')
INSERT INTO Categories (CategoryId, CategoryName) VALUES (4, 'Arts')
INSERT INTO Categories (CategoryId, CategoryName) VALUES (5, 'Home')
INSERT INTO Categories (CategoryId, CategoryName) VALUES (6, 'Sporting Goods')
INSERT INTO Categories (CategoryId, CategoryName) VALUES (7, 'Toys')
SET IDENTITY_INSERT Categories OFF

GO
-- insertion script for products
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P101','Lamborghini Gallardo Spyder',1,18000000.00,10)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P102','BMW X1',1,3390000.00,10)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P103','BMW Z4',1,6890000.00,10)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P104','Harley Davidson Iron 883 ',1,700000.00,10)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P105','Ducati Multistrada',1,2256000.00,10)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P106','Honda CBR 250R',1,193000.00,100)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P107','Kenneth Cole Black & White Leather Reversible Belt',2,2500.00,50)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P108','Classic Brooks Brothers 346 Wool Black Sport Coat',2,3078.63,10)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P109','Ben Sherman Mens Necktie Silk Tie',2,1847.18,20)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P126','Tanjore Painting of Ganesha',4,8000.00,20)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P127','Marble Elephants statue',4,9056.00,50)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P128','Wooden photo frame',4,150.00,200)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P129','Gold plated dancing peacock',4,350.00,100)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P130','Kundan jewellery set',4,2000.00,30)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P131','Marble chess board','4','3000.00','20')
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P132','German Folk Art Wood Carvings Shy Boy and Girl',4,6122.20,100)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P133','Modern Abstract Metal Art Wall Sculpture',5,5494.55,100)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P134','Bean Bag Chair Love Seat',5,5754.55,100)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P135','Scented rose candles',5,200.00,50)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P136','Digital bell chime',5,800.00,10)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P141','Turner Sultan 29er Large',6,147612.60,100)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P142','BAMBOO BACKED HICKORY LONGBOW ',6,5291.66,100)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P151','Baby Einstein Hand Puppets',7,1229.41,100)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P152','fire godzilla toy',7,614.09,100)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P153','Remote car',7,1000.00,100)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P154','Barbie doll set',7,500.00,100)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P155','Teddy bear',7,300.00,100)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P156','Clever sticks',7,400.00,100)
INSERT INTO Products(ProductId,ProductName,CategoryId,Price,QuantityAvailable) VALUES('P157','See and Say',7,200.00,50)

GO

--insertion scripts for PurchaseDetails
SET IDENTITY_INSERT PurchaseDetails ON
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1001,'Franken@gmail.com','P101',2,'Jan 12 2014 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1002,'Franken@gmail.com','P143',1,'Jan 13 2014 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1003,'Franken@gmail.com','P112',3,'Jan 14 2014 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1004,'Franken@gmail.com','P148',2,'Jan 15 2014 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1005,'Franken@gmail.com','P150',1,'Jan 16 2014 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1006,'Franken@gmail.com','P134',3,'Jan 16 2014 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1007,'SamRocks@gmail.com','P120',4,'Nov 17 2013 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1112,'Timothy@gmail.com','P148',1,'Nov 21 2013 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1114,'Timothy@gmail.com','P150',5,'Dec 22 2013 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1115,'Timothy@gmail.com','P134',1,'Jan 12 2014 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1116,'Timothy@gmail.com','P101',3,'Jan 13 2014 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1145,'Helvetius@gmail.com','P112',2,'Jan 17 2014 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1146,'Mathew_Edmar@yahoo.com','P114',3,'Jan 19 2014 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1147,'Mathew_Edmar@yahoo.com','P101',1,'Jan 21 2014 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1148,'Mathew_Edmar@yahoo.com','P143',5,'Jan 22 2014 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1149,'Mathew_Edmar@yahoo.com','P112',2,'Jan 23 2014 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1150,'Mathew_Edmar@yahoo.com','P148',5,'Jan 14 2014 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1151,'Mathew_Edmar@yahoo.com','P150',4,'Jan 15 2014 12:00AM')
INSERT INTO PurchaseDetails(PurchaseId,EmailId,ProductId,QuantityPurchased,DateOfPurchase) VALUES(1152,'Mathew_Edmar@yahoo.com','P134',5,'Jan 17 2014 12:00AM')
SET IDENTITY_INSERT PurchaseDetails OFF

GO

--insertion scripts for CardDetails 
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1146665296881890,'Manuel','M',137,'2025-03-18',7282.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1164283045453550,'Renate Messner','V  ',133,'2028-01-08',14538.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1164916976389880,'Rita','M',588,'2025-07-28',18570.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1172583365804160,'McKenna','V  ',777,'2028-04-05',7972.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1190676541467400,'Brown','V  ',390,'2029-09-10',9049.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1201253053391160,'Patricia','M',501,'2029-06-24',19092.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1209611246778470,'Cruz','V  ',879,'2026-12-25',13645.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1224920265219560,'Pirkko','M',771,'2027-09-18',14620.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1229664582982800,'Helen','M',402,'2025-06-28',16932.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1245674190696670,'Mary','M',828,'2029-01-04',14078.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1258975792010020,'Annette','M',606,'2025-10-24',15889.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1770791472481120,'Accorti','V  ',855,'2025-08-16',17423.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1770826010361760,'Koskitalo','V  ',874,'2029-09-11',15892.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1774070025907600,'Miguel','M',444,'2025-06-18',10058.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1780797319715350,'Helvetius','M',869,'2027-05-03',12015.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1787045046296090,'Domingues','V  ',335,'2028-11-03',6683.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1803781319458280,'Diego','M',744,'2026-01-14',15762.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(1825594516343200,'Nagy','V  ',705,'2025-04-11',7712.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(2121785955299770,'Palle','M',261,'2027-07-05',3655.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(2122490035590690,'Margaret','M',875,'2025-01-16',18000.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(2127803726103060,'Afonso','V  ',858,'2029-10-09',11726.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(2136141552371090,'Rance','V  ',434,'2025-10-05',17813.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(2139581656416670,'Francisco','M',727,'2029-01-30',15845.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(2155938900697450,'Labrune','V  ',400,'2028-02-10',2455.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(2157326961005880,'Daniel','M',827,'2029-03-07',2145.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(2175932867933100,'Gary','M',635,'2028-05-31',14526.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(2175974386401880,'Devon','V  ',270,'2025-11-20',3463.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(2208687402112480,'Josephs','V  ',640,'2023-12-29',15794.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(2210444662985580,'Paul','M',710,'2025-04-29',16523.00)
INSERT INTO CardDetails(CardNumber,NameOnCard,CardType,CVVNumber,ExpiryDate,Balance) VALUES(2219617013139190,'Roland','M',719,'2025-08-31',2537.00)
GO





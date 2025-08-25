CREATE TABLE DimCategory (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255) NOT NULL
);

CREATE TABLE DimBrand (
    BrandID INT PRIMARY KEY,
    BrandName VARCHAR(255) NOT NULL,
    CategoryID INT NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES DimCategory(CategoryID)
);

CREATE TABLE DimPromotionType (
    PromotionTypeID INT PRIMARY KEY,
    PromotionTypeName VARCHAR(255) NOT NULL
);

CREATE TABLE DimPromotion (
    PromotionID INT PRIMARY KEY,
    PromotionName VARCHAR(255) NOT NULL,
    PromotionTypeID INT NOT NULL,
    DiscountPercent DECIMAL(5,2),
    FOREIGN KEY (PromotionTypeID) REFERENCES DimPromotionType(PromotionTypeID)
);

CREATE TABLE DimProduct (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    BrandID INT NOT NULL,
    Price DECIMAL(10,2),
    FOREIGN KEY (BrandID) REFERENCES DimBrand(BrandID)
);

CREATE TABLE DimRegion (
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(255) NOT NULL
);

CREATE TABLE DimStore (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(255) NOT NULL,
    StoreType VARCHAR(100),
    RegionID INT,
    FOREIGN KEY (RegionID) REFERENCES DimRegion(RegionID)
);

CREATE TABLE DimYear (
    YearID INT PRIMARY KEY,
    Year INT NOT NULL
);

CREATE TABLE DimMonth (
    MonthID INT PRIMARY KEY,
    Month INT NOT NULL,
    YearID INT NOT NULL,
    FOREIGN KEY (YearID) REFERENCES DimYear(YearID)
);

CREATE TABLE DimDate (
    DateID INT PRIMARY KEY,
    Date DATE NOT NULL,
    Day INT NOT NULL,
    MonthID INT NOT NULL,
    FOREIGN KEY (MonthID) REFERENCES DimMonth(MonthID)
);

CREATE TABLE DimCountry (
    CountryID INT PRIMARY KEY,
    CountryName VARCHAR(255) NOT NULL
);

CREATE TABLE DimState (
    StateID INT PRIMARY KEY,
    StateName VARCHAR(255) NOT NULL,
    CountryID INT NOT NULL,
    FOREIGN KEY (CountryID) REFERENCES DimCountry(CountryID)
);

CREATE TABLE DimCity (
    CityID INT PRIMARY KEY,
    CityName VARCHAR(255) NOT NULL,
    StateID INT NOT NULL,
    FOREIGN KEY (StateID) REFERENCES DimState(StateID)
);

CREATE TABLE DimStreet (
    StreetID INT PRIMARY KEY,
    StreetName VARCHAR(255) NOT NULL,
    CityID INT NOT NULL,
    FOREIGN KEY (CityID) REFERENCES DimCity(CityID)
);

CREATE TABLE DimAddress (
    AddressID INT PRIMARY KEY,
    HouseNo VARCHAR(50),
    AddressType VARCHAR(50),
    StreetID INT NOT NULL,
    FOREIGN KEY (StreetID) REFERENCES DimStreet(StreetID)
);

CREATE TABLE DimCustomer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255) NOT NULL,
    Gender VARCHAR(10),
    DOB DATE,
    MaritalStatus VARCHAR(50),
    Email VARCHAR(255),
    Phone VARCHAR(50),
    AddressID INT,
    FOREIGN KEY (AddressID) REFERENCES DimAddress(AddressID)
);

CREATE TABLE CustomerAddressBridge (
    CustomerAddressID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    AddressID INT NOT NULL,
    AddressRole VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID),
    FOREIGN KEY (AddressID) REFERENCES DimAddress(AddressID)
);

CREATE TABLE FactProductSales_Agg (
    ProductID INT NOT NULL,
    MonthID INT NOT NULL,
    UnitsSold INT,
    Revenue DECIMAL(15,2),
    AvgPrice DECIMAL(10,2),
    DiscountImpact DECIMAL(10,2),
    PRIMARY KEY (ProductID, MonthID),
    FOREIGN KEY (ProductID) REFERENCES DimProduct(ProductID),
    FOREIGN KEY (MonthID) REFERENCES DimMonth(MonthID)
);

CREATE TABLE FactCustomerSales_Agg (
    CustomerID INT NOT NULL,
    MonthID INT NOT NULL,
    TotalSpend DECIMAL(15,2),
    TotalOrders INT,
    AvgOrderValue DECIMAL(10,2),
    PRIMARY KEY (CustomerID, MonthID),
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID),
    FOREIGN KEY (MonthID) REFERENCES DimMonth(MonthID)
);

CREATE TABLE FactSales (
    SaleID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    OrderDateID INT NOT NULL,
    ShipDateID INT NOT NULL,
    DeliveryDateID INT NOT NULL,
    PromotionID INT,
    StoreID INT NOT NULL,
    CustomerID INT NOT NULL,
    QuantitySold INT,
    Discount DECIMAL(10,2),
    TaxAmount DECIMAL(10,2),
    SalesAmount DECIMAL(15,2),
    InvoiceNumber VARCHAR(50),
    OrderStatus VARCHAR(50),
    FOREIGN KEY (ProductID) REFERENCES DimProduct(ProductID),
    FOREIGN KEY (OrderDateID) REFERENCES DimDate(DateID),
    FOREIGN KEY (ShipDateID) REFERENCES DimDate(DateID),
    FOREIGN KEY (DeliveryDateID) REFERENCES DimDate(DateID),
    FOREIGN KEY (PromotionID) REFERENCES DimPromotion(PromotionID),
    FOREIGN KEY (StoreID) REFERENCES DimStore(StoreID),
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID)
);

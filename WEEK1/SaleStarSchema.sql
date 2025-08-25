CREATE TABLE DimProduct (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Category VARCHAR(100),
    Brand VARCHAR(100),
    Price DECIMAL(10, 2)
);

CREATE TABLE DimPromotion (
    PromotionID INT PRIMARY KEY,
    PromotionName VARCHAR(255),
    PromotionType VARCHAR(100),
    DiscountPercent DECIMAL(5, 2)
);

CREATE TABLE DimDate (
    DateID INT PRIMARY KEY,
    Date DATE,
    Day INT,
    Quarter INT,
    Month INT,
    Year INT,
    MonthID VARCHAR(10) -- Format like 'MMYYYY' or similar
);

CREATE TABLE DimStore (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(255),
    StoreType VARCHAR(100),
    Region VARCHAR(100)
);

CREATE TABLE DimCustomer (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    Gender VARCHAR(10),
    DOB DATE,
    MaritalStatus VARCHAR(50),
    Email VARCHAR(255),
    Phone VARCHAR(50),
    ShippingAddress VARCHAR(500),
    BillingAddress VARCHAR(500)
);

CREATE TABLE FactProductSales_Agg (
    ProductID INT,
    MonthID VARCHAR(10), -- FK references DimDate.MonthID
    UnitsSold INT,
    Revenue DECIMAL(15, 2),
    AvgPrice DECIMAL(10, 2),
    PRIMARY KEY (ProductID, MonthID),
    FOREIGN KEY (ProductID) REFERENCES DimProduct(ProductID),
    FOREIGN KEY (MonthID) REFERENCES DimDate(MonthID)
);

CREATE TABLE FactCustomerSales_Agg (
    CustomerID INT,
    MonthID VARCHAR(10),
    TotalSpend DECIMAL(15, 2),
    TotalOrders INT,
    AvgOrderValue DECIMAL(10, 2),
    PRIMARY KEY (CustomerID, MonthID),
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID),
    FOREIGN KEY (MonthID) REFERENCES DimDate(MonthID)
);

CREATE TABLE FactSales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    OrderDateID INT,
    ShipDateID INT,
    DeliveryDateID INT,
    PromotionID INT,
    StoreID INT,
    CustomerID INT,
    QuantitySold INT,
    Discount DECIMAL(10, 2),
    TaxAmount DECIMAL(10, 2),
    SalesAmount DECIMAL(15, 2),
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

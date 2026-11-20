use company;
DELIMITER $$
CREATE procedure SelectCustomerByCountry(IN c VARCHAR(45))
BEGIN 
	SELECT * FROM Customers
    where Country = c;
END $$
DELIMITER ;

SET @country = 'Spain';
SELECT @country;
CALL SelectCustomerByCountry(@country);
SELECT @country;

DELIMITER $$
CREATE procedure GetOrderCountByShipper(IN shipper varchar(45), OUT count INT)
BEGIN
	SELECT COUNT(OrderID) INTO count
    FROM Orders
    join Shippers ON Orders.ShipperID = Shippers.ShipperID
    where ShipperName = shipper;
END
DELIMITER ;

select ShipperName from Shippers;
SET @order_cnt = 0;
SELECT @order_cnt;
CALL GetOrderCountByShipper('United Package', @order_cnt);
SELECT @order_cnt;

DELIMITER $$
CREATE procedure GetCustomerSalesOut(
	IN inCustomerID INT,
    OUT outName VARCHAR(255),
    OUT outSales FLOAT)
BEGIN
	Select CustomerName into outName
    FROM Customers
    Where CustomerID = inCustomerID;
    
    Select IFNULL(SUM(p.Price * od.Quantity), 0) INTO outSales
    From Orders o
    JOIN orderdetails od on  o.OrderID = od.OrderID
    JOIN Products p on p.ProductID = od.ProductID
    WHERE o.CustomerID = inCustomerID;
END $$
DELIMITER ;

CALL GetCustomerSalesOut(5, @name, @sales); SELECT @name, @sales;
CALL GetCustomerSalesOut(2, @name, @sales); SELECT @name, @sales;





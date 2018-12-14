/* exercise*/


/* DDL */
-- 创建名为Northwind1的数据库
create database Northwind1

-- 删除数据库Northwind1
drop database Northwind1

-- 为Customers表增加一列‘tmp’，数据类型为整数

use Northwind
alter table Customers add tmp int 
-- 删除刚创建的tmp列
alter table Customers drop column tmp 




/* DML*/

-- 查询订购日期在1996年7月1日至1996年7月15日之间的订单的订购日期、订单ID、客户ID和雇员ID等字段的值
select OrderDate,OrderID,CustomerID,EmployeeID
from Orders
where  OrderDate <='1996-07-15'  and OrderDate >='1996-07-01'
 
--查询“10248”和“10254”号订单的订单ID、运货商的公司名称、订单上所订购的产品的名称(订单明细表名称有空格，用[Order Details]表示)
select Orders.OrderID,ShipName,ProductName
from [Order Details],Orders,Products
where [Order Details].OrderID=Orders.OrderID and 
[Order Details].ProductID=Products.ProductID and Orders.OrderID in (10248,10254)

--查询“10248”和“10254”号订单的订单ID、订单上所订购的产品的名称、数量、单价和折扣
select Orders.OrderID,ProductName,Quantity,[Order Details].UnitPrice,Discount
from [Order Details],Orders,Products
where [Order Details].OrderID=Orders.OrderID and 
[Order Details].ProductID=Products.ProductID and Orders.OrderID in (10248,10254)


--查询“10248”和“10254”号订单的订单ID、订单上所订购的产品的名称及其销售金额
select O.OrderID,P.ProductName,
((O.UnitPrice)-(O.UnitPrice*O.Discount))*(O.Quantity) SaleNUM
from [Order Details] O,Products P
where O.ProductID=P.ProductID  and O.OrderID in (10248,10254)


--查询所有运货商的公司名称和电话
select CompanyName,Phone
from Shippers

--查询所有客户的公司名称、电话、传真、地址、联系人姓名和联系人头衔
select CompanyName,Phone,Fax,Address,ContactName,ContactTitle
from Customers

--查询单价介于10至30元的所有产品的产品ID、产品名称和库存量
select ProductID,ProductName,UnitsInStock
from Products
where UnitPrice between 10 and 30

--查询单价大于20元的所有产品的产品名称、单价以及供应商的公司名称、电话
select ProductName,UnitPrice,CompanyName,Phone
from Products P,Suppliers S
where P.SupplierID=S.SupplierID and P.UnitPrice>20

--按运货商公司名称，统计1997年由各个运货商承运的订单的总数量
select count(*) OrderNUM,CompanyName
from Orders O,Shippers S
where O.ShipVia=S.ShipperID and (ShippedDate between '1997-01-01' and '1997-12-31')
group by CompanyName

--统计各类产品的平均价格
select AVG(UnitPrice) UnitPriceAVG,CategoryID
from Products
group by CategoryID

--统计各地区客户的总数量
select count(*) CustomerNUM,Region
from Customers
group by Region

-- 查询由Exotic Liquids, Grandma Kelly's Homestead, Tokyo Traders这三个供应商提供的商品的产品编号、产品名称、供应商id、供应商名称
select ProductID,ProductName,S.SupplierID,CompanyName
from Products P,Suppliers S
where P.SupplierID=S.SupplierID and S.CompanyName 
in('Exotic Liquids', 'Grandma Kelly''s Homestead', 'Tokyo Traders')

-- 查询Seafood类的产品id、产品名称、类别id、类别名称
select ProductID,ProductName,C.CategoryID,CategoryName
from Products P,Categories C
where P.CategoryID=C.CategoryID and CategoryName='Seafood'

-- 查询提供CategoryID=8的产品的供应商名称及各公司的CategoryID为8的产品的个数
select S.CompanyName,COUNT(S.CompanyName) ProductNUM
from Categories C,Products P,Suppliers S
where C.CategoryID=P.CategoryID and S.SupplierID=P.SupplierID and C.CategoryID=8
group by S.CompanyName

-- 查询供应Seafood类的产品的供应商名称
select S.CompanyName
from Categories C,Products P,Suppliers S
where C.CategoryID=P.CategoryID and S.SupplierID=P.SupplierID 
and C.CategoryName='Seafood'

-- 查询所有产品名称及其对应的供应商名称
select ProductName, S.CompanyName
from Products P,Suppliers S
where S.SupplierID=P.SupplierID 

-- 查询销售总额超过10000美元的订单编号、供应商名称
-- hint:销售总额=((unitprice)-(unitprice*discount))*(quantity)
select O.OrderID,S.CompanyName
from [Order Details] O,Products P,Suppliers S
where O.ProductID=P.ProductID and S.SupplierID=P.SupplierID and 
((O.UnitPrice)-(O.UnitPrice*O.Discount))*(O.Quantity)>10000

-- 查询既有员工又有客户的城市的员工数目和客户数
select COUNT(distinct CustomerID ) CustomerNUM,
Count(distinct EmployeeID) EmployeeNUM,C.City
from Customers C,Employees E
where C.City=E.City
group by C.City

select CustomerID ,EmployeeID,C.City
from Customers C,Employees E
where C.City=E.City


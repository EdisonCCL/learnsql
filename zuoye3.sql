/* exercise*/


/* DDL */
-- ������ΪNorthwind1�����ݿ�
create database Northwind1

-- ɾ�����ݿ�Northwind1
drop database Northwind1

-- ΪCustomers������һ�С�tmp������������Ϊ����

use Northwind
alter table Customers add tmp int 
-- ɾ���մ�����tmp��
alter table Customers drop column tmp 




/* DML*/

-- ��ѯ����������1996��7��1����1996��7��15��֮��Ķ����Ķ������ڡ�����ID���ͻ�ID�͹�ԱID���ֶε�ֵ
select OrderDate,OrderID,CustomerID,EmployeeID
from Orders
where  OrderDate <='1996-07-15'  and OrderDate >='1996-07-01'
 
--��ѯ��10248���͡�10254���Ŷ����Ķ���ID���˻��̵Ĺ�˾���ơ��������������Ĳ�Ʒ������(������ϸ�������пո���[Order Details]��ʾ)
select Orders.OrderID,ShipName,ProductName
from [Order Details],Orders,Products
where [Order Details].OrderID=Orders.OrderID and 
[Order Details].ProductID=Products.ProductID and Orders.OrderID in (10248,10254)

--��ѯ��10248���͡�10254���Ŷ����Ķ���ID���������������Ĳ�Ʒ�����ơ����������ۺ��ۿ�
select Orders.OrderID,ProductName,Quantity,[Order Details].UnitPrice,Discount
from [Order Details],Orders,Products
where [Order Details].OrderID=Orders.OrderID and 
[Order Details].ProductID=Products.ProductID and Orders.OrderID in (10248,10254)


--��ѯ��10248���͡�10254���Ŷ����Ķ���ID���������������Ĳ�Ʒ�����Ƽ������۽��
select O.OrderID,P.ProductName,
((O.UnitPrice)-(O.UnitPrice*O.Discount))*(O.Quantity) SaleNUM
from [Order Details] O,Products P
where O.ProductID=P.ProductID  and O.OrderID in (10248,10254)


--��ѯ�����˻��̵Ĺ�˾���ƺ͵绰
select CompanyName,Phone
from Shippers

--��ѯ���пͻ��Ĺ�˾���ơ��绰�����桢��ַ����ϵ����������ϵ��ͷ��
select CompanyName,Phone,Fax,Address,ContactName,ContactTitle
from Customers

--��ѯ���۽���10��30Ԫ�����в�Ʒ�Ĳ�ƷID����Ʒ���ƺͿ����
select ProductID,ProductName,UnitsInStock
from Products
where UnitPrice between 10 and 30

--��ѯ���۴���20Ԫ�����в�Ʒ�Ĳ�Ʒ���ơ������Լ���Ӧ�̵Ĺ�˾���ơ��绰
select ProductName,UnitPrice,CompanyName,Phone
from Products P,Suppliers S
where P.SupplierID=S.SupplierID and P.UnitPrice>20

--���˻��̹�˾���ƣ�ͳ��1997���ɸ����˻��̳��˵Ķ�����������
select count(*) OrderNUM,CompanyName
from Orders O,Shippers S
where O.ShipVia=S.ShipperID and (ShippedDate between '1997-01-01' and '1997-12-31')
group by CompanyName

--ͳ�Ƹ����Ʒ��ƽ���۸�
select AVG(UnitPrice) UnitPriceAVG,CategoryID
from Products
group by CategoryID

--ͳ�Ƹ������ͻ���������
select count(*) CustomerNUM,Region
from Customers
group by Region

-- ��ѯ��Exotic Liquids, Grandma Kelly's Homestead, Tokyo Traders��������Ӧ���ṩ����Ʒ�Ĳ�Ʒ��š���Ʒ���ơ���Ӧ��id����Ӧ������
select ProductID,ProductName,S.SupplierID,CompanyName
from Products P,Suppliers S
where P.SupplierID=S.SupplierID and S.CompanyName 
in('Exotic Liquids', 'Grandma Kelly''s Homestead', 'Tokyo Traders')

-- ��ѯSeafood��Ĳ�Ʒid����Ʒ���ơ����id���������
select ProductID,ProductName,C.CategoryID,CategoryName
from Products P,Categories C
where P.CategoryID=C.CategoryID and CategoryName='Seafood'

-- ��ѯ�ṩCategoryID=8�Ĳ�Ʒ�Ĺ�Ӧ�����Ƽ�����˾��CategoryIDΪ8�Ĳ�Ʒ�ĸ���
select S.CompanyName,COUNT(S.CompanyName) ProductNUM
from Categories C,Products P,Suppliers S
where C.CategoryID=P.CategoryID and S.SupplierID=P.SupplierID and C.CategoryID=8
group by S.CompanyName

-- ��ѯ��ӦSeafood��Ĳ�Ʒ�Ĺ�Ӧ������
select S.CompanyName
from Categories C,Products P,Suppliers S
where C.CategoryID=P.CategoryID and S.SupplierID=P.SupplierID 
and C.CategoryName='Seafood'

-- ��ѯ���в�Ʒ���Ƽ����Ӧ�Ĺ�Ӧ������
select ProductName, S.CompanyName
from Products P,Suppliers S
where S.SupplierID=P.SupplierID 

-- ��ѯ�����ܶ��10000��Ԫ�Ķ�����š���Ӧ������
-- hint:�����ܶ�=((unitprice)-(unitprice*discount))*(quantity)
select O.OrderID,S.CompanyName
from [Order Details] O,Products P,Suppliers S
where O.ProductID=P.ProductID and S.SupplierID=P.SupplierID and 
((O.UnitPrice)-(O.UnitPrice*O.Discount))*(O.Quantity)>10000

-- ��ѯ����Ա�����пͻ��ĳ��е�Ա����Ŀ�Ϳͻ���
select COUNT(distinct CustomerID ) CustomerNUM,
Count(distinct EmployeeID) EmployeeNUM,C.City
from Customers C,Employees E
where C.City=E.City
group by C.City

select CustomerID ,EmployeeID,C.City
from Customers C,Employees E
where C.City=E.City


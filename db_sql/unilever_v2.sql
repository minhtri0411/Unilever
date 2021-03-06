﻿use master 
go
drop database Unilever
go
create database Unilever
go
use Unilever
go
create table Distributors
(
	ID int identity primary key,
	Name nvarchar(100),
	Email nvarchar(300),
	Phone char(15),
	[Addr] nvarchar(500)
)
go
create table Products
(
	ID int identity primary key,
	Name nvarchar(100),
	CatID int,
	Price int, 
	ImportDate date, -- ngày nhập
	RemainingAmount int, -- tồn kho
	Descript nvarchar(2000)
)
go
create table Categories
 (
	ID int identity primary key,
	Name nvarchar(150)
)
go
create table Orders
(
	ID int identity primary key,
	OrderDate datetime,
	DistributorID int,
	OrderTypeId int -- loại hóa đơn: định kỳ - không định kỳ
)
go
create table OrderDetails
(
	ID int identity primary key,
	ProID int, 
	OrderID int,
	Quantity int,
	Price int,
	TotalAmount int -- = quantity * price
)
go
create table DefferredLiabilities -- nợ
(
	ID int identity primary key,
	OrderID int unique,
	DebtDate date, -- ngày bắt đầu nợ
	PeriodOfDebt int -- thời gian được phép nợ (đơn vị: ngày)
)
go
create table InterestRate -- lãi suất
(
	ID int identity primary key,
	OutOfPeriod int, -- quá hạn (đơn vị: ngày)
	InterestPayable float -- lãi phải trả (đơn vị: % trên tổng giá trị đơn hàng)
)
go
create table Inventories -- hàng tồn kho
(
	ID int identity primary key,
	DistributorID int, -- nhà phân phối
	ProID int,
	OrderedQuantity int,
	SoldQuantity int,
	OrderDate date -- ngày nhập hàng
)
go
create table OrderType
(
	ID int primary key,
	OrderType nvarchar(100)
)
go
create table SaleRevenues -- doanh số bán hàng
(
	ID int identity primary key,
	DistributorID int,
	ProId int unique,
	SoldQuantity int,
	TotalCash int, -- tồng tiền 
	StatisDate date -- ngày thống kê
)
go
alter table inventories add constraint uq_distrib_pro unique (DistributorID, ProID)
go
/************ db 2  *************/
go
use master 
go
create database UnileverDMS_SaleMans
go
use UnileverDMS_Distributors
go
create table SaleMans
(
	ID int identity primary key,
	Name nvarchar(100),
	Addr nvarchar(300),
	Email nvarchar(300),
	Phone nvarchar(15),
	SaleAreaId int
)	
go
create table SaleAreas
(
	ID int identity primary key,
	Area nvarchar(200)
)
go
create table Products
(
	ID int identity primary key,
	Name nvarchar(100),
	CatID int,
	Price int, 
	ImportDate date, -- ngày nhập
	RemainingAmount int, -- tồn kho
	Descript nvarchar(2000)
)
go
create table Categories
 (
	ID int identity primary key,
	Name nvarchar(150)
)
go
create table Orders
(
	ID int identity primary key,
	OrderDate datetime,
	SaleManId int
)
go
create table OrderDetails
(
	ID int identity primary key,
	ProID int, 
	OrderID int,
	Quantity int,
	Price int,
	TotalAmount int -- = quantity * price
)
go
create table DefferredLiabilities  -- công nợ
(
	ID int identity primary key,
	OrderId int unique,
	SaleManId int,
	DebtDate date,
	unique (OrderId, SaleManId)
)
go
create table SaleRevenues -- doanh số
(
	ID int identity primary key,
	SaleManId int,
	ProId int,
	SoldQuantity int,
	TotalCash int,
	StatisDate date
)
go
use master
go
create database UnileverDMS_Customers
go
use UnileverDMS_SaleMans
go
create table Customers
(
	ID int identity primary key,
	Name nvarchar(100),
	Addr nvarchar(300),
	Email nvarchar(300),
	Phone nvarchar(15),
	CustomerTypeId int
)
go
create table CustomerType
(
	ID int primary key,
	Details nvarchar(100),
)
go
create table Products
(
	ID int identity primary key,
	Name nvarchar(100),
	CatID int,
	Price int, 
	ImportDate date, -- ngày nhập
	RemainingAmount int, -- tồn kho
	Descript nvarchar(2000)
)
go
create table Categories
 (
	ID int identity primary key,
	Name nvarchar(150)
)
go
create table Orders
(
	ID int identity primary key,
	OrderDate datetime,
	CustomerId int
)
go
create table OrderDetails
(
	ID int identity primary key,
	ProID int, 
	OrderID int,
	Quantity int,
	Price int,
	TotalAmount int -- = quantity * price
)
go
create table DefferredLiabilities  -- công nợ
(
	ID int identity primary key,
	OrderId int unique,
	CustomerId int,
	DebtDate date,
	unique (OrderId, CustomerId)
)
go
create table SaleAreas
(
	ID int identity primary key,
	Area nvarchar(200)
)
go
create table SaleRevenues -- doanh số
(
	ID int identity primary key,
	SaleAreaId int,
	ProId int,
	SoldQuantity int,
	TotalCash int,
	StatisDate date
)

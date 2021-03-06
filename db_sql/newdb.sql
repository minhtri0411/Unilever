USE [master]
GO
/****** Object:  Database [Unilever]    Script Date: 6/23/2015 3:41:26 AM ******/
CREATE DATABASE [Unilever]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Unilever', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLSERVER2K12\MSSQL\DATA\Unilever.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Unilever_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLSERVER2K12\MSSQL\DATA\Unilever_log.ldf' , SIZE = 832KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Unilever] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Unilever].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Unilever] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Unilever] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Unilever] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Unilever] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Unilever] SET ARITHABORT OFF 
GO
ALTER DATABASE [Unilever] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Unilever] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Unilever] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Unilever] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Unilever] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Unilever] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Unilever] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Unilever] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Unilever] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Unilever] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Unilever] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Unilever] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Unilever] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Unilever] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Unilever] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Unilever] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Unilever] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Unilever] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Unilever] SET RECOVERY FULL 
GO
ALTER DATABASE [Unilever] SET  MULTI_USER 
GO
ALTER DATABASE [Unilever] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Unilever] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Unilever] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Unilever] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Unilever', N'ON'
GO
USE [Unilever]
GO
/****** Object:  StoredProcedure [dbo].[sp_getDistributorLiabilitiesSumary]    Script Date: 6/23/2015 3:41:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[sp_getDistributorLiabilitiesSumary]
@distribid int
as
begin
		declare @tbl table 
		(
			DistributorId int,
			OrderId int,
			OrderType nvarchar(100),	-- loại hóa đơn 
			Total int,					-- tổng hóa đơn : tiền
			DebtDate date,				-- ngày nợ
			PeriodOfDebt int,			-- chu kì nợ (thời gian tối đa được phép nợ mà không bị tính lãi)
			OutOfPeriod int,			-- quá hạn : đơn vị ngày
			InterestRate float,			-- lãi suất
			ToMoney int					-- quy thành tiền : 
		)
		declare curorder cursor for select id from Orders where Orders.DistributorID = @distribid
		open curorder
		declare @orid int
		fetch next from curorder into @orid
		while @@FETCH_STATUS = 0
		begin

		declare cur cursor for select DefferredLiabilities.ID, DefferredLiabilities.OrderID,
		 DefferredLiabilities.debtdate, DefferredLiabilities.periodofdebt 
		from DefferredLiabilities where DefferredLiabilities.OrderID = @orid
			open cur
			declare @dlid int
			declare @orderid int
			declare @debtdate date
			declare @prioddebt int

			fetch next from cur into @dlid, @orderid, @debtdate, @prioddebt

		while @@FETCH_STATUS = 0
				begin
					declare @ordertype nvarchar(100)
					declare @outofperid int
					declare @inrate float
					declare @total int
					declare @tomoney int

					select @ordertype = ordertype.OrdType 
					from Orders, ordertype
					where Orders.ID = @orderid and Orders.OrderTypeid = ordertype.id

					set @outofperid = datediff(day,dateadd(day,@prioddebt, @debtdate), getdate())

					select @inrate = max(interestpayable) 
					from InterestRate ir
					where @outofperid >= ir.OutOfPeriod

					set @total = (select sum (od.TotalAmount)
					from OrderDetails od, Orders o
					where od.OrderID = o.ID and od.OrderID = @orderid)

					set @tomoney = (@inrate * @total)/100

					insert into @tbl(DistributorId,OrderId,OrderType,DebtDate, PeriodOfDebt, Total,OutOfPeriod,InterestRate,ToMoney)
					values (@distribid, @orderid, @ordertype, @debtdate,@prioddebt, @total, @outofperid, @inrate, @tomoney)

					fetch next from cur into @dlid, @orderid, @debtdate, @prioddebt	
				end
			close cur
			deallocate cur
			fetch next from curorder into @orid
			end
		close curorder 
		deallocate curorder
		select * from @tbl
end

GO
/****** Object:  Table [dbo].[Categories]    Script Date: 6/23/2015 3:41:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DefferredLiabilities]    Script Date: 6/23/2015 3:41:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DefferredLiabilities](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[DebtDate] [date] NULL,
	[PeriodOfDebt] [int] NULL,
 CONSTRAINT [fk_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Distributors]    Script Date: 6/23/2015 3:41:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Distributors](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Email] [nvarchar](300) NULL,
	[Phone] [char](15) NULL,
	[Addr] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InterestRate]    Script Date: 6/23/2015 3:41:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InterestRate](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OutOfPeriod] [int] NULL,
	[InterestPayable] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inventories]    Script Date: 6/23/2015 3:41:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventories](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DistributorID] [int] NULL,
	[ProID] [int] NOT NULL,
	[OrderedQuantity] [int] NULL,
	[SoldQuantity] [int] NULL,
	[OrderDate] [date] NULL,
 CONSTRAINT [PK__Inventor__3214EC2796339FFE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 6/23/2015 3:41:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [int] NOT NULL,
	[TotalAmount] [int] NOT NULL,
 CONSTRAINT [PK__OrderDet__3214EC270843C88A] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 6/23/2015 3:41:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderDate] [datetime] NULL,
	[DistributorID] [int] NOT NULL,
	[OrderTypeId] [int] NOT NULL,
 CONSTRAINT [PK__Orders__3214EC275401D361] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderType]    Script Date: 6/23/2015 3:41:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderType](
	[ID] [int] NOT NULL,
	[OrdType] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 6/23/2015 3:41:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[CatID] [int] NOT NULL,
	[Price] [int] NULL,
	[ImportDate] [date] NULL,
	[RemainingAmount] [int] NULL,
	[Descript] [nvarchar](2000) NULL,
 CONSTRAINT [PK__Products__3214EC27EBEE0279] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SaleRevenues]    Script Date: 6/23/2015 3:41:27 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaleRevenues](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DistributorID] [int] NULL,
	[ProId] [int] NULL,
	[SoldQuantity] [int] NULL,
	[TotalCash] [int] NULL,
	[StatisDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([ID], [Name]) VALUES (1, N'Bột giặt OMO')
INSERT [dbo].[Categories] ([ID], [Name]) VALUES (2, N'Dầu gội đầu ')
INSERT [dbo].[Categories] ([ID], [Name]) VALUES (3, N'Kem')
INSERT [dbo].[Categories] ([ID], [Name]) VALUES (4, N'Kem dưỡng da')
INSERT [dbo].[Categories] ([ID], [Name]) VALUES (5, N'Xà bông Lifebuoy')
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[DefferredLiabilities] ON 

INSERT [dbo].[DefferredLiabilities] ([ID], [OrderID], [DebtDate], [PeriodOfDebt]) VALUES (15, 2, CAST(0x163A0B00 AS Date), 5)
INSERT [dbo].[DefferredLiabilities] ([ID], [OrderID], [DebtDate], [PeriodOfDebt]) VALUES (20, 5, CAST(0x013A0B00 AS Date), 13)
INSERT [dbo].[DefferredLiabilities] ([ID], [OrderID], [DebtDate], [PeriodOfDebt]) VALUES (21, 8, CAST(0x023A0B00 AS Date), 17)
INSERT [dbo].[DefferredLiabilities] ([ID], [OrderID], [DebtDate], [PeriodOfDebt]) VALUES (25, 6, CAST(0xFB390B00 AS Date), 7)
INSERT [dbo].[DefferredLiabilities] ([ID], [OrderID], [DebtDate], [PeriodOfDebt]) VALUES (27, 3, CAST(0x0E3A0B00 AS Date), 4)
SET IDENTITY_INSERT [dbo].[DefferredLiabilities] OFF
SET IDENTITY_INSERT [dbo].[Distributors] ON 

INSERT [dbo].[Distributors] ([ID], [Name], [Email], [Phone], [Addr]) VALUES (1, N'VẠN THỊNH PHÁT - CTY TNHH MTV TM VẠN THỊNH PHÁT', N'VTP@gmail.com', N'(08)39675812   ', N'279 TRẦN VĂN KIỂU, P.3, Q.6, TP. HCM')
INSERT [dbo].[Distributors] ([ID], [Name], [Email], [Phone], [Addr]) VALUES (2, N'UNILEVER VIỆT NAM - CTY LD UNILEVER VIỆT NAM', N'Unilerver@gmail.com', N'(08)54135600   ', N'156 NGUYỄN LƯƠNG BẰNG, P.TÂN PHÚ, Q.7, TP. HCM')
INSERT [dbo].[Distributors] ([ID], [Name], [Email], [Phone], [Addr]) VALUES (3, N'KIM HUÊ - ĐẠI LÝ BỘT GIẶT OMO KIM HUÊ', N'KimHue@gmail.com', N'(0650)38242    ', N'137 BÁC SĨ YERSIN, P.PHÚ CƯỜNG, TX.THỦ DẦU MỘT, BÌNH DƯƠNG')
INSERT [dbo].[Distributors] ([ID], [Name], [Email], [Phone], [Addr]) VALUES (1001, N'OMO VN - CÔNG TY CHUYÊN SẢN XUẤT DÀUĂN', N'omo@unilever.com', N'(08)09010011012', N'227 NGUYỄN VĂN CỪ - Q5 - TPHCM')
INSERT [dbo].[Distributors] ([ID], [Name], [Email], [Phone], [Addr]) VALUES (2001, N'OMO US - CÔNG TY CHUYÊN SẢN XUẤT NƯỚC MẮM', N'omous@unilever.com', N'(08)09010011012', N'227 NGUYỄN VĂN CỪ Q5 - TPHCM')
SET IDENTITY_INSERT [dbo].[Distributors] OFF
SET IDENTITY_INSERT [dbo].[InterestRate] ON 

INSERT [dbo].[InterestRate] ([ID], [OutOfPeriod], [InterestPayable]) VALUES (1, 7, 2.5)
INSERT [dbo].[InterestRate] ([ID], [OutOfPeriod], [InterestPayable]) VALUES (2, 14, 5)
INSERT [dbo].[InterestRate] ([ID], [OutOfPeriod], [InterestPayable]) VALUES (3, 21, 7.5)
INSERT [dbo].[InterestRate] ([ID], [OutOfPeriod], [InterestPayable]) VALUES (4, 30, 15)
SET IDENTITY_INSERT [dbo].[InterestRate] OFF
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([ID], [OrderID], [ProID], [Quantity], [Price], [TotalAmount]) VALUES (1, 1, 2, 122, 100, 12200)
INSERT [dbo].[OrderDetails] ([ID], [OrderID], [ProID], [Quantity], [Price], [TotalAmount]) VALUES (2, 2, 3, 1, 1000, 1000)
INSERT [dbo].[OrderDetails] ([ID], [OrderID], [ProID], [Quantity], [Price], [TotalAmount]) VALUES (3, 3, 1, 1, 1000, 1000)
INSERT [dbo].[OrderDetails] ([ID], [OrderID], [ProID], [Quantity], [Price], [TotalAmount]) VALUES (4, 4, 2, 3, 1000, 3000)
INSERT [dbo].[OrderDetails] ([ID], [OrderID], [ProID], [Quantity], [Price], [TotalAmount]) VALUES (5, 5, 3, 3, 1000, 3000)
INSERT [dbo].[OrderDetails] ([ID], [OrderID], [ProID], [Quantity], [Price], [TotalAmount]) VALUES (6, 6, 1, 1, 1000, 1000)
INSERT [dbo].[OrderDetails] ([ID], [OrderID], [ProID], [Quantity], [Price], [TotalAmount]) VALUES (7, 7, 1, 1, 1000, 1000)
INSERT [dbo].[OrderDetails] ([ID], [OrderID], [ProID], [Quantity], [Price], [TotalAmount]) VALUES (8, 8, 1, 1, 1000, 1000)
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([ID], [OrderDate], [DistributorID], [OrderTypeId]) VALUES (1, CAST(0x0000A4BF0028BBC4 AS DateTime), 1, 1)
INSERT [dbo].[Orders] ([ID], [OrderDate], [DistributorID], [OrderTypeId]) VALUES (2, CAST(0x0000A4BF0028BBC4 AS DateTime), 2, 2)
INSERT [dbo].[Orders] ([ID], [OrderDate], [DistributorID], [OrderTypeId]) VALUES (3, CAST(0x0000A4BF0028BBC4 AS DateTime), 1, 2)
INSERT [dbo].[Orders] ([ID], [OrderDate], [DistributorID], [OrderTypeId]) VALUES (4, CAST(0x0000A4BF0028BBC4 AS DateTime), 3, 1)
INSERT [dbo].[Orders] ([ID], [OrderDate], [DistributorID], [OrderTypeId]) VALUES (5, CAST(0x0000A4BF0028BBC4 AS DateTime), 2, 1)
INSERT [dbo].[Orders] ([ID], [OrderDate], [DistributorID], [OrderTypeId]) VALUES (6, CAST(0x0000A4BF0028BBC4 AS DateTime), 2, 1)
INSERT [dbo].[Orders] ([ID], [OrderDate], [DistributorID], [OrderTypeId]) VALUES (7, CAST(0x0000A4BF0028BBC4 AS DateTime), 3, 2)
INSERT [dbo].[Orders] ([ID], [OrderDate], [DistributorID], [OrderTypeId]) VALUES (8, CAST(0x0000A4BF0028BBC4 AS DateTime), 2, 2)
INSERT [dbo].[Orders] ([ID], [OrderDate], [DistributorID], [OrderTypeId]) VALUES (9, CAST(0x0000A4BF0028BBC4 AS DateTime), 1, 1)
INSERT [dbo].[Orders] ([ID], [OrderDate], [DistributorID], [OrderTypeId]) VALUES (10, CAST(0x0000A4BF0028BBC4 AS DateTime), 3, 1)
INSERT [dbo].[Orders] ([ID], [OrderDate], [DistributorID], [OrderTypeId]) VALUES (11, CAST(0x0000A4BF0028BBC4 AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[Orders] OFF
INSERT [dbo].[OrderType] ([ID], [OrdType]) VALUES (1, N'Thường kỳ')
INSERT [dbo].[OrderType] ([ID], [OrdType]) VALUES (2, N'Không thường kỳ')
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ID], [Name], [CatID], [Price], [ImportDate], [RemainingAmount], [Descript]) VALUES (1, N'Bột giặt OMO Comfort Hương Ban Mai', 4, 119000, CAST(0x183A0B00 AS Date), 100, N'Bột giặt OMO Comfort tinh dầu thơm mới kết hợp sức mạnh xoáy bay vết bẩn cứng đầu nhanh hơn và ngát hương thơm Comfort Hương ban mai

Hạt Năng Lượng Xoáy hòa tan, thấm sâu thật nhanh vào sợi vải, giúp xoáy bay các bết bẩn cứng đầu chỉ trong 1 lần giặt.
Hương thơm ban mai của Comfort giúp quần áo thơm mát dài lâu.
Sản phẩm có các loại trọng lượng: 360g, 720g, 2.7kg, 4.1kg, 5.5kg.')
INSERT [dbo].[Products] ([ID], [Name], [CatID], [Price], [ImportDate], [RemainingAmount], [Descript]) VALUES (2, N'Bột giặt OMO Comfort Tinh Dầu Thơm', 3, 118000, CAST(0x183A0B00 AS Date), 100, N'OMO Comfort tinh dầu thơm mới kết hợp sức mạnh xoáy bay vết bẩn cứng đầu nhanh hơn và ngát hương thơm Comfort tinh dầu thơm tinh tế

Hạt Năng Lượng Xoáy hòa tan, thấm sâu thật nhanh vào sợi vải, giúp xoáy bay các bết bẩn cứng đầu chỉ trong 1 lần giặt.
Hương tinh dầu thơm của Comfort Tinh dầu thơm tinh tế giúp quần áo thơm mát dài lâu.
Sản phẩm có các loại trọng lượng: 360g, 720g, 2.7kg, 4.1kg, 5.5kg.')
INSERT [dbo].[Products] ([ID], [Name], [CatID], [Price], [ImportDate], [RemainingAmount], [Descript]) VALUES (1003, N'Bột giặt OMO Comfort Hương Ban Mai', 4, 119000, CAST(0xA1390B00 AS Date), 100, N'Bột giặt OMO Comfort tinh dầu thơm mới kết hợp sức mạnh xoáy bay vết bẩn cứng đầu nhanh hơn và ngát hương thơm Comfort Hương ban mai

Hạt Năng Lượng Xoáy hòa tan, thấm sâu thật nhanh vào sợi vải, giúp xoáy bay các bết bẩn cứng đầu chỉ trong 1 lần giặt.
Hương thơm ban mai của Comfort giúp quần áo thơm mát dài lâu.
Sản phẩm có các loại trọng lượng: 360g, 720g, 2.7kg, 4.1kg, 5.5kg.')
SET IDENTITY_INSERT [dbo].[Products] OFF
/****** Object:  Index [uq_Orderid]    Script Date: 6/23/2015 3:41:27 AM ******/
ALTER TABLE [dbo].[DefferredLiabilities] ADD  CONSTRAINT [uq_Orderid] UNIQUE NONCLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [Unilever] SET  READ_WRITE 
GO	
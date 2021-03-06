USE [master]
GO
/****** Object:  Database [SportsItemsStore]    Script Date: 10/1/2015 7:39:19 PM ******/
CREATE DATABASE [SportsItemsStore]
  ON  PRIMARY 
( NAME = N'SportsItemsStore', FILENAME = N'D:\Database\MSSQL\DATA\SportsItemsStore.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SportsItemsStore_log', FILENAME = N'D:\Database\MSSQL\DATA\SportsItemsStore_log.ldf' , SIZE = 4224KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SportsItemsStore] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SportsItemsStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SportsItemsStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SportsItemsStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SportsItemsStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SportsItemsStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SportsItemsStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [SportsItemsStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SportsItemsStore] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SportsItemsStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SportsItemsStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SportsItemsStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SportsItemsStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SportsItemsStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SportsItemsStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SportsItemsStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SportsItemsStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SportsItemsStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SportsItemsStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SportsItemsStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SportsItemsStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SportsItemsStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SportsItemsStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SportsItemsStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SportsItemsStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SportsItemsStore] SET RECOVERY FULL 
GO
ALTER DATABASE [SportsItemsStore] SET  MULTI_USER 
GO
ALTER DATABASE [SportsItemsStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SportsItemsStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SportsItemsStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SportsItemsStore] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [SportsItemsStore]
GO
/****** Object:  Table [dbo].[Addresses]    Script Date: 10/1/2015 7:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Addresses](
	[AddressID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](400) NOT NULL,
	[Line1] [nvarchar](400) NOT NULL,
	[Line2] [nvarchar](400) NULL,
	[Line3] [nvarchar](400) NULL,
	[City] [nvarchar](100) NOT NULL,
	[State] [nvarchar](500) NOT NULL,
	[Zip] [nvarchar](50) NOT NULL,
	[Country] [nvarchar](100) NOT NULL,
	[UserId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AddressID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Categories]    Script Date: 10/1/2015 7:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryCode] [nchar](4) NULL,
	[CategoryName] [nvarchar](50) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Colors]    Script Date: 10/1/2015 7:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Colors](
	[ColorID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[IsActive] [nvarchar](500) NULL,
	[Order] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Manufacturers]    Script Date: 10/1/2015 7:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturers](
	[ManufacturerID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[IsActive] [nvarchar](500) NULL,
	[Order] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ManufacturerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 10/1/2015 7:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailId] [int] IDENTITY(1,1) NOT NULL,
	[Order_OrderId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[SizeId] [int] NOT NULL,
	[ColorId] [int] NULL,
	[ManufacturerId] [int] NULL,
	[Quantity] [int] NOT NULL,
	[SubTotal] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 10/1/2015 7:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[AddressId] [int] NULL,
	[UserId] [int] NULL,
	[OrderTotal] [decimal](18, 2) NOT NULL,
	[OrderDate] [datetime] NULL,
	[ShipmentDate] [datetime] NULL,
	[DeliveryDate] [datetime] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductColors]    Script Date: 10/1/2015 7:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductColors](
	[ProductColorID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ColorID] [int] NOT NULL,
	[Order] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductColorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductManufacturers]    Script Date: 10/1/2015 7:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductManufacturers](
	[ProductManufacturerID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ManufacturerID] [int] NOT NULL,
	[Order] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductManufacturerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 10/1/2015 7:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
	[CategoryId] [int] NULL,
	[Price] [decimal](16, 2) NOT NULL,
	[ProductImageUrl] [nvarchar](max) NULL,
	[ThumbnailUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK__Products__B40CC6ED7F60ED59] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductSizes]    Script Date: 10/1/2015 7:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSizes](
	[ProductSizeID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[SizeID] [int] NOT NULL,
	[Order] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductSizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sizes]    Script Date: 10/1/2015 7:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sizes](
	[SizeID] [int] IDENTITY(1,1) NOT NULL,
	[ShortName] [nvarchar](100) NOT NULL,
	[FullName] [nvarchar](100) NULL,
	[IsActive] [nvarchar](500) NULL,
	[Order] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[SizeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 10/1/2015 7:39:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](100) NOT NULL,
	[Email] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Addresses] ON 

INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (10, N'Receiver1', N'100', N'ABC Dr', NULL, N'New York City', N'NY', N'06417', N'USA', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (11, N'Receiver2', N'100', N'ABC Dr', NULL, N'New York City', N'NY', N'06416', N'USA', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (15, N'test', N'test', N'test', N'test', N'test', N'TX', N'2423', N'usa', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (16, N'test', N'test', N'test', N'test', N'test', N'TX', N'3455', N'US', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (22, N't', N't', N't', N't', N'dalas', N'TX', N'4546', N'USA', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (23, N't', N't', N't', N't', N'dalas', N'TX', N'4546', N'USA', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (24, N't', N't', N't', N't', N'dalas', N'TX', N'4546', N'USA', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (25, N't', N't', N't', N't', N'dalas', N'TX', N'4546', N'USA', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (26, N't', N't', N't', N't', N'dalas', N'TX', N'4546', N'USA', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (27, N't', N't', N't', N't', N'dalas', N'TX', N'4546', N'USA', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (28, N't', N't', N't', N't', N'dalas', N'TX', N'4546', N'USA', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (29, N't', N't', N't', N't', N'dalas', N'TX', N'4546', N'USA', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (30, N't', N't', N't', N't', N'dalas', N'TX', N'4546', N'USA', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (31, N't', N't', N't', N't', N'dalas', N'TX', N'4546', N'USA', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (32, N't', N't', N't', N't', N'dalas', N'TX', N'4546', N'USA', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (34, N'uy', N'u', N'uu', N'u', N'down town', N'TX', N'3455', N'USA', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (35, N'test', N'test', N'test', N'test', N'test', N'test', N'13456', N'india', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (37, N'test', N'test', N'test', N'test', N'test', N'test', N'13412341', N'india', 28)
INSERT [dbo].[Addresses] ([AddressID], [Name], [Line1], [Line2], [Line3], [City], [State], [Zip], [Country], [UserId]) VALUES (38, N'rrdrsr', N'srsr', N'sdfsd', N'sfsf', N't', N't', N'65748', N'xfsffs', 28)
SET IDENTITY_INSERT [dbo].[Addresses] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryId], [CategoryCode], [CategoryName]) VALUES (1, N'WS  ', N'Watersports')
INSERT [dbo].[Categories] ([CategoryId], [CategoryCode], [CategoryName]) VALUES (2, N'S   ', N'Soccer')
INSERT [dbo].[Categories] ([CategoryId], [CategoryCode], [CategoryName]) VALUES (3, N'C   ', N'Chess')
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Colors] ON 

INSERT [dbo].[Colors] ([ColorID], [Name], [IsActive], [Order]) VALUES (1, N'Red', N'Yes', NULL)
INSERT [dbo].[Colors] ([ColorID], [Name], [IsActive], [Order]) VALUES (2, N'Green', N'Yes', NULL)
INSERT [dbo].[Colors] ([ColorID], [Name], [IsActive], [Order]) VALUES (3, N'Blue', N'Yes', NULL)
INSERT [dbo].[Colors] ([ColorID], [Name], [IsActive], [Order]) VALUES (4, N'White', N'Yes', NULL)
SET IDENTITY_INSERT [dbo].[Colors] OFF
SET IDENTITY_INSERT [dbo].[Manufacturers] ON 

INSERT [dbo].[Manufacturers] ([ManufacturerID], [Name], [IsActive], [Order]) VALUES (1, N'Nike', NULL, NULL)
INSERT [dbo].[Manufacturers] ([ManufacturerID], [Name], [IsActive], [Order]) VALUES (2, N'Reebok', NULL, NULL)
INSERT [dbo].[Manufacturers] ([ManufacturerID], [Name], [IsActive], [Order]) VALUES (3, N'Puma', NULL, NULL)
INSERT [dbo].[Manufacturers] ([ManufacturerID], [Name], [IsActive], [Order]) VALUES (4, N'Adidas', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Manufacturers] OFF
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([OrderDetailId], [Order_OrderId], [ProductId], [SizeId], [ColorId], [ManufacturerId], [Quantity], [SubTotal]) VALUES (1, 1, 2, 1, 1, 1, 3, CAST(1502.85 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailId], [Order_OrderId], [ProductId], [SizeId], [ColorId], [ManufacturerId], [Quantity], [SubTotal]) VALUES (2, 2, 2, 2, 1, 1, 1, CAST(500.95 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailId], [Order_OrderId], [ProductId], [SizeId], [ColorId], [ManufacturerId], [Quantity], [SubTotal]) VALUES (3, 2, 4, 2, 1, 2, 1, CAST(34.95 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailId], [Order_OrderId], [ProductId], [SizeId], [ColorId], [ManufacturerId], [Quantity], [SubTotal]) VALUES (4, 2, 8, 2, 4, 0, 1, CAST(20000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailId], [Order_OrderId], [ProductId], [SizeId], [ColorId], [ManufacturerId], [Quantity], [SubTotal]) VALUES (5, 2, 2, 1, 1, 1, 1, CAST(500.95 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailId], [Order_OrderId], [ProductId], [SizeId], [ColorId], [ManufacturerId], [Quantity], [SubTotal]) VALUES (6, 3, 1, 0, 0, 0, 1, CAST(275.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailId], [Order_OrderId], [ProductId], [SizeId], [ColorId], [ManufacturerId], [Quantity], [SubTotal]) VALUES (7, 3, 3, 0, 0, 0, 1, CAST(1000.50 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailId], [Order_OrderId], [ProductId], [SizeId], [ColorId], [ManufacturerId], [Quantity], [SubTotal]) VALUES (8, 4, 4, 1, 1, 2, 1, CAST(34.95 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailId], [Order_OrderId], [ProductId], [SizeId], [ColorId], [ManufacturerId], [Quantity], [SubTotal]) VALUES (9, 4, 2, 2, 4, 1, 1, CAST(500.95 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailId], [Order_OrderId], [ProductId], [SizeId], [ColorId], [ManufacturerId], [Quantity], [SubTotal]) VALUES (10, 5, 1, 2, 2, 2, 1, CAST(275.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailId], [Order_OrderId], [ProductId], [SizeId], [ColorId], [ManufacturerId], [Quantity], [SubTotal]) VALUES (11, 5, 4, 2, 0, 3, 1, CAST(34.95 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailId], [Order_OrderId], [ProductId], [SizeId], [ColorId], [ManufacturerId], [Quantity], [SubTotal]) VALUES (12, 5, 1, 2, 1, 1, 1, CAST(275.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailId], [Order_OrderId], [ProductId], [SizeId], [ColorId], [ManufacturerId], [Quantity], [SubTotal]) VALUES (13, 6, 1, 1, 1, 2, 1, CAST(275.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderId], [AddressId], [UserId], [OrderTotal], [OrderDate], [ShipmentDate], [DeliveryDate]) VALUES (1, 31, 28, CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A489013A4F4A AS DateTime), NULL, NULL)
INSERT [dbo].[Orders] ([OrderId], [AddressId], [UserId], [OrderTotal], [OrderDate], [ShipmentDate], [DeliveryDate]) VALUES (2, 32, 28, CAST(0.00 AS Decimal(18, 2)), CAST(0x0000A48A00CEE799 AS DateTime), NULL, NULL)
INSERT [dbo].[Orders] ([OrderId], [AddressId], [UserId], [OrderTotal], [OrderDate], [ShipmentDate], [DeliveryDate]) VALUES (3, 34, 28, CAST(1275.50 AS Decimal(18, 2)), CAST(0x0000A48A00D9D902 AS DateTime), NULL, NULL)
INSERT [dbo].[Orders] ([OrderId], [AddressId], [UserId], [OrderTotal], [OrderDate], [ShipmentDate], [DeliveryDate]) VALUES (4, 35, 28, CAST(535.90 AS Decimal(18, 2)), CAST(0x0000A4A400F5D445 AS DateTime), NULL, NULL)
INSERT [dbo].[Orders] ([OrderId], [AddressId], [UserId], [OrderTotal], [OrderDate], [ShipmentDate], [DeliveryDate]) VALUES (5, 37, 28, CAST(584.95 AS Decimal(18, 2)), CAST(0x0000A4A400FA90F7 AS DateTime), NULL, NULL)
INSERT [dbo].[Orders] ([OrderId], [AddressId], [UserId], [OrderTotal], [OrderDate], [ShipmentDate], [DeliveryDate]) VALUES (6, 38, 28, CAST(275.00 AS Decimal(18, 2)), CAST(0x0000A4C1011B92B5 AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Orders] OFF
SET IDENTITY_INSERT [dbo].[ProductColors] ON 

INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (1, 1, 1, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (2, 1, 2, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (3, 2, 1, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (4, 2, 4, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (5, 3, 2, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (6, 3, 4, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (7, 4, 1, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (8, 4, 4, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (9, 6, 1, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (10, 6, 2, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (11, 6, 3, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (12, 6, 4, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (13, 7, 1, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (14, 7, 4, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (15, 8, 4, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (16, 9, 4, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (17, 10, 1, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (18, 10, 2, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (19, 10, 3, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (20, 10, 4, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (21, 12, 1, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (22, 12, 2, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (23, 12, 3, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (24, 14, 1, NULL)
INSERT [dbo].[ProductColors] ([ProductColorID], [ProductID], [ColorID], [Order]) VALUES (25, 14, 4, NULL)
SET IDENTITY_INSERT [dbo].[ProductColors] OFF
SET IDENTITY_INSERT [dbo].[ProductManufacturers] ON 

INSERT [dbo].[ProductManufacturers] ([ProductManufacturerID], [ProductID], [ManufacturerID], [Order]) VALUES (1, 1, 1, NULL)
INSERT [dbo].[ProductManufacturers] ([ProductManufacturerID], [ProductID], [ManufacturerID], [Order]) VALUES (2, 1, 2, NULL)
INSERT [dbo].[ProductManufacturers] ([ProductManufacturerID], [ProductID], [ManufacturerID], [Order]) VALUES (3, 2, 1, NULL)
INSERT [dbo].[ProductManufacturers] ([ProductManufacturerID], [ProductID], [ManufacturerID], [Order]) VALUES (4, 2, 2, NULL)
INSERT [dbo].[ProductManufacturers] ([ProductManufacturerID], [ProductID], [ManufacturerID], [Order]) VALUES (5, 2, 3, NULL)
INSERT [dbo].[ProductManufacturers] ([ProductManufacturerID], [ProductID], [ManufacturerID], [Order]) VALUES (6, 3, 1, NULL)
INSERT [dbo].[ProductManufacturers] ([ProductManufacturerID], [ProductID], [ManufacturerID], [Order]) VALUES (7, 3, 4, NULL)
INSERT [dbo].[ProductManufacturers] ([ProductManufacturerID], [ProductID], [ManufacturerID], [Order]) VALUES (8, 4, 2, NULL)
INSERT [dbo].[ProductManufacturers] ([ProductManufacturerID], [ProductID], [ManufacturerID], [Order]) VALUES (9, 4, 3, NULL)
INSERT [dbo].[ProductManufacturers] ([ProductManufacturerID], [ProductID], [ManufacturerID], [Order]) VALUES (10, 6, 1, NULL)
INSERT [dbo].[ProductManufacturers] ([ProductManufacturerID], [ProductID], [ManufacturerID], [Order]) VALUES (11, 6, 4, NULL)
SET IDENTITY_INSERT [dbo].[ProductManufacturers] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [Name], [Description], [CategoryId], [Price], [ProductImageUrl], [ThumbnailUrl]) VALUES (1, N'Kayak', N'A boat for one person', 1, CAST(275.00 AS Decimal(16, 2)), N'Kayak.jpg', N'Kayak.jpg')
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [CategoryId], [Price], [ProductImageUrl], [ThumbnailUrl]) VALUES (2, N'Lifejacket', N'Protective and fashionable', 1, CAST(500.95 AS Decimal(16, 2)), N'Lifejacket.jpg', N'Lifejacket.jpg')
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [CategoryId], [Price], [ProductImageUrl], [ThumbnailUrl]) VALUES (3, N'Soccer Ball', N'FIFA approved size and weight', 2, CAST(1000.50 AS Decimal(16, 2)), N'soccer.jpg', N'soccer.jpg')
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [CategoryId], [Price], [ProductImageUrl], [ThumbnailUrl]) VALUES (4, N'Corner Flags', N'Give your playing field a professional touch', 2, CAST(34.95 AS Decimal(16, 2)), N'CornerFlags.jpg', N'CornerFlags.jpg')
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [CategoryId], [Price], [ProductImageUrl], [ThumbnailUrl]) VALUES (5, N'Stadium', N'Flat-packed 35000-seat stadium', 2, CAST(79500.00 AS Decimal(16, 2)), N'Stadium.jpg', N'Stadium.jpg')
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [CategoryId], [Price], [ProductImageUrl], [ThumbnailUrl]) VALUES (6, N'Thinking Cap', N'Improves your brain efficiency by 75%', 3, CAST(2000.00 AS Decimal(16, 2)), N'ThinkingCap.jpg', N'ThinkingCap.jpg')
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [CategoryId], [Price], [ProductImageUrl], [ThumbnailUrl]) VALUES (7, N'Unsteady Chair', N'Secretly give your opponent a disadvantage', 3, CAST(4500.95 AS Decimal(16, 2)), N'UnsteadyChair.jpg', N'UnsteadyChair.jpg')
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [CategoryId], [Price], [ProductImageUrl], [ThumbnailUrl]) VALUES (8, N'Human Chess Board', N'A fun game for the family', 3, CAST(20000.00 AS Decimal(16, 2)), N'HumanChessBoard.jpg', N'HumanChessBoard.jpg')
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [CategoryId], [Price], [ProductImageUrl], [ThumbnailUrl]) VALUES (9, N'Bling-Bling King', N'Gold-plated diamond studded king', 3, CAST(1200.00 AS Decimal(16, 2)), N'Bling-BlingKing.jpg', N'Bling-BlingKing.jpg')
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [CategoryId], [Price], [ProductImageUrl], [ThumbnailUrl]) VALUES (10, N'Soccer Jersy', N'Good quality fabric', 2, CAST(6000.00 AS Decimal(16, 2)), N'SoccerJersy.jpg', N'SoccerJersy.jpg')
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [CategoryId], [Price], [ProductImageUrl], [ThumbnailUrl]) VALUES (12, N'Lifeboat', N'Your safety is our concern', 1, CAST(60000.00 AS Decimal(16, 2)), N'Lifeboat.jpg', N'Lifeboat.jpg')
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [CategoryId], [Price], [ProductImageUrl], [ThumbnailUrl]) VALUES (13, N'Chess Sets', N'High in quality', 3, CAST(1000.00 AS Decimal(16, 2)), N'ChessSets.jpg', N'ChessSets.png')
INSERT [dbo].[Products] ([ProductID], [Name], [Description], [CategoryId], [Price], [ProductImageUrl], [ThumbnailUrl]) VALUES (14, N'Chess Pieces', N'Shiney material', 3, CAST(10000.00 AS Decimal(16, 2)), N'ChessPieces.jpg', N'ChessPieces.png')
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[ProductSizes] ON 

INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (1, 1, 1, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (2, 1, 2, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (3, 2, 1, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (4, 2, 2, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (5, 2, 3, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (6, 2, 4, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (7, 3, 2, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (8, 3, 3, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (9, 4, 1, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (10, 4, 2, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (11, 6, 1, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (13, 6, 2, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (14, 6, 3, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (15, 6, 4, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (16, 7, 1, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (17, 7, 2, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (18, 7, 4, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (19, 7, 3, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (20, 8, 2, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (21, 8, 3, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (22, 9, 1, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (24, 9, 3, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (25, 10, 1, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (26, 10, 2, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (27, 10, 3, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (28, 10, 4, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (31, 12, 2, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (32, 12, 3, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (33, 13, 1, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (34, 13, 2, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (35, 14, 2, NULL)
INSERT [dbo].[ProductSizes] ([ProductSizeID], [ProductID], [SizeID], [Order]) VALUES (36, 14, 3, NULL)
SET IDENTITY_INSERT [dbo].[ProductSizes] OFF
SET IDENTITY_INSERT [dbo].[Sizes] ON 

INSERT [dbo].[Sizes] ([SizeID], [ShortName], [FullName], [IsActive], [Order]) VALUES (1, N'S', N'Small', NULL, NULL)
INSERT [dbo].[Sizes] ([SizeID], [ShortName], [FullName], [IsActive], [Order]) VALUES (2, N'M', N'Medium', NULL, NULL)
INSERT [dbo].[Sizes] ([SizeID], [ShortName], [FullName], [IsActive], [Order]) VALUES (3, N'L', N'Large', NULL, NULL)
INSERT [dbo].[Sizes] ([SizeID], [ShortName], [FullName], [IsActive], [Order]) VALUES (4, N'XL', N'Extra Large', NULL, NULL)
SET IDENTITY_INSERT [dbo].[Sizes] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([ID], [Username], [Password], [Email]) VALUES (28, N'TestUser1', N'test@123', N'testuser1@email.com')
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[Addresses]  WITH CHECK ADD FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([Order_OrderId])
REFERENCES [dbo].[OrderDetails] ([OrderDetailId])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[ProductColors]  WITH CHECK ADD  CONSTRAINT [fk_Col_PC] FOREIGN KEY([ColorID])
REFERENCES [dbo].[Colors] ([ColorID])
GO
ALTER TABLE [dbo].[ProductColors] CHECK CONSTRAINT [fk_Col_PC]
GO
ALTER TABLE [dbo].[ProductColors]  WITH CHECK ADD  CONSTRAINT [fk_Pd_PC] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductColors] CHECK CONSTRAINT [fk_Pd_PC]
GO
ALTER TABLE [dbo].[ProductManufacturers]  WITH CHECK ADD  CONSTRAINT [fk_Manfc_PM] FOREIGN KEY([ManufacturerID])
REFERENCES [dbo].[Manufacturers] ([ManufacturerID])
GO
ALTER TABLE [dbo].[ProductManufacturers] CHECK CONSTRAINT [fk_Manfc_PM]
GO
ALTER TABLE [dbo].[ProductManufacturers]  WITH CHECK ADD  CONSTRAINT [fk_Pd_PM] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductManufacturers] CHECK CONSTRAINT [fk_Pd_PM]
GO
ALTER TABLE [dbo].[ProductSizes]  WITH CHECK ADD  CONSTRAINT [fk_Pd_PS] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[ProductSizes] CHECK CONSTRAINT [fk_Pd_PS]
GO
ALTER TABLE [dbo].[ProductSizes]  WITH CHECK ADD  CONSTRAINT [fk_Sz_PS] FOREIGN KEY([SizeID])
REFERENCES [dbo].[Sizes] ([SizeID])
GO
ALTER TABLE [dbo].[ProductSizes] CHECK CONSTRAINT [fk_Sz_PS]
GO
USE [master]
GO
ALTER DATABASE [SportsItemsStore] SET  READ_WRITE 
GO

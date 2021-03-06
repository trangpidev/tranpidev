USE [master]
GO
/****** Object:  Database [QL_BTS]    Script Date: 9/11/2021 11:10:41 PM ******/
CREATE DATABASE [QL_BTS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QL_BTS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QL_BTS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'QL_BTS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\QL_BTS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [QL_BTS] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QL_BTS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QL_BTS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QL_BTS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QL_BTS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QL_BTS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QL_BTS] SET ARITHABORT OFF 
GO
ALTER DATABASE [QL_BTS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QL_BTS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QL_BTS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QL_BTS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QL_BTS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QL_BTS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QL_BTS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QL_BTS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QL_BTS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QL_BTS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QL_BTS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QL_BTS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QL_BTS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QL_BTS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QL_BTS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QL_BTS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QL_BTS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QL_BTS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QL_BTS] SET  MULTI_USER 
GO
ALTER DATABASE [QL_BTS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QL_BTS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QL_BTS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QL_BTS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QL_BTS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QL_BTS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [QL_BTS] SET QUERY_STORE = OFF
GO
USE [QL_BTS]
GO
/****** Object:  Table [dbo].[tb_sanpham]    Script Date: 9/11/2021 11:10:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_sanpham](
	[masp] [int] IDENTITY(1,1) NOT NULL,
	[maloaisp] [int] NULL,
	[tensp] [nvarchar](50) NULL,
	[giasp] [int] NULL,
	[thanhphan] [nvarchar](50) NULL,
 CONSTRAINT [PK_tb_sanpham] PRIMARY KEY CLUSTERED 
(
	[masp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_chitiethoadon]    Script Date: 9/11/2021 11:10:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_chitiethoadon](
	[mahoadon] [int] NULL,
	[masp] [int] NULL,
	[soluong] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_hoadon]    Script Date: 9/11/2021 11:10:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_hoadon](
	[mahoadon] [int] IDENTITY(1,1) NOT NULL,
	[sdtkhachhang] [nvarchar](50) NULL,
	[thoigian] [datetime] NULL,
 CONSTRAINT [PK_tb_hoadon] PRIMARY KEY CLUSTERED 
(
	[mahoadon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[hoadonbanhang]    Script Date: 9/11/2021 11:10:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create View [dbo].[hoadonbanhang] As
	Select tb_hoadon.mahoadon, tb_sanpham.tensp,tb_sanpham.giasp,tb_chitiethoadon.soluong from tb_hoadon INNER JOIN tb_chitiethoadon ON tb_hoadon.mahoadon =tb_chitiethoadon.mahoadon 
	INNER JOIN tb_sanpham ON tb_chitiethoadon.masp = tb_sanpham.masp 
GO
/****** Object:  View [dbo].[v_tongtien]    Script Date: 9/11/2021 11:10:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  view [dbo].[v_tongtien] as
Select tb_chitiethoadon.mahoadon, Sum(tb_sanpham.giasp* tb_chitiethoadon.soluong) as tongtien 
From tb_sanpham INNER JOIN tb_chitiethoadon ON tb_sanpham.masp=tb_chitiethoadon.masp 
Group by tb_chitiethoadon.mahoadon
GO
/****** Object:  View [dbo].[v_xuathoadon]    Script Date: 9/11/2021 11:10:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create view [dbo].[v_xuathoadon] as
Select tb_hoadon.mahoadon, tb_hoadon.sdtkhachhang, tb_hoadon.thoigian, tb_sanpham.tensp,tb_sanpham.giasp,tb_chitiethoadon.soluong, tb_sanpham.giasp* tb_chitiethoadon.soluong as thanhtien,
		v_tongtien.tongtien 

		
From tb_hoadon INNER JOIN tb_chitiethoadon ON tb_hoadon.mahoadon= tb_chitiethoadon.mahoadon
				Inner Join tb_sanpham ON tb_sanpham.masp=tb_chitiethoadon.masp 
				INNer JOIN  v_tongtien ON tb_hoadon.mahoadon = v_tongtien.mahoadon
GO
/****** Object:  Table [dbo].[tb_ban]    Script Date: 9/11/2021 11:10:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_ban](
	[maban] [int] IDENTITY(1,1) NOT NULL,
	[tinhtrang] [int] NULL,
 CONSTRAINT [PK_tb_ban] PRIMARY KEY CLUSTERED 
(
	[maban] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_khachhang]    Script Date: 9/11/2021 11:10:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_khachhang](
	[sdtkhachhang] [nvarchar](50) NOT NULL,
	[tenkhachhang] [nvarchar](50) NULL,
 CONSTRAINT [PK_tb_khachhang] PRIMARY KEY CLUSTERED 
(
	[sdtkhachhang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_loaisp]    Script Date: 9/11/2021 11:10:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_loaisp](
	[maloaisp] [int] IDENTITY(1,1) NOT NULL,
	[tenloaisp] [nvarchar](50) NULL,
 CONSTRAINT [PK_tb_loaisp] PRIMARY KEY CLUSTERED 
(
	[maloaisp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_taikhoan]    Script Date: 9/11/2021 11:10:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_taikhoan](
	[tentk] [nvarchar](50) NULL,
	[matkhau] [nvarchar](50) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tb_chitiethoadon]  WITH CHECK ADD  CONSTRAINT [FK_tb_chitiethoadon_tb_hoadon] FOREIGN KEY([mahoadon])
REFERENCES [dbo].[tb_hoadon] ([mahoadon])
GO
ALTER TABLE [dbo].[tb_chitiethoadon] CHECK CONSTRAINT [FK_tb_chitiethoadon_tb_hoadon]
GO
ALTER TABLE [dbo].[tb_chitiethoadon]  WITH CHECK ADD  CONSTRAINT [FK_tb_chitiethoadon_tb_sanpham] FOREIGN KEY([masp])
REFERENCES [dbo].[tb_sanpham] ([masp])
GO
ALTER TABLE [dbo].[tb_chitiethoadon] CHECK CONSTRAINT [FK_tb_chitiethoadon_tb_sanpham]
GO
ALTER TABLE [dbo].[tb_hoadon]  WITH CHECK ADD  CONSTRAINT [FK_tb_hoadon_tb_khachhang] FOREIGN KEY([sdtkhachhang])
REFERENCES [dbo].[tb_khachhang] ([sdtkhachhang])
GO
ALTER TABLE [dbo].[tb_hoadon] CHECK CONSTRAINT [FK_tb_hoadon_tb_khachhang]
GO
ALTER TABLE [dbo].[tb_sanpham]  WITH CHECK ADD  CONSTRAINT [FK_tb_sanpham_tb_loaisp] FOREIGN KEY([maloaisp])
REFERENCES [dbo].[tb_loaisp] ([maloaisp])
GO
ALTER TABLE [dbo].[tb_sanpham] CHECK CONSTRAINT [FK_tb_sanpham_tb_loaisp]
GO
USE [master]
GO
ALTER DATABASE [QL_BTS] SET  READ_WRITE 
GO

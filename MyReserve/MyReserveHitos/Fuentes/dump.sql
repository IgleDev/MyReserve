USE [master]
GO
/****** Object:  Database [MyReserve]    Script Date: 27/08/2024 14:56:21 ******/
CREATE DATABASE [MyReserve]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MyReserve', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER02\MSSQL\DATA\MyReserve.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MyReserve_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER02\MSSQL\DATA\MyReserve_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [MyReserve] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MyReserve].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MyReserve] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MyReserve] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MyReserve] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MyReserve] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MyReserve] SET ARITHABORT OFF 
GO
ALTER DATABASE [MyReserve] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MyReserve] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MyReserve] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MyReserve] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MyReserve] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MyReserve] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MyReserve] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MyReserve] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MyReserve] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MyReserve] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MyReserve] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MyReserve] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MyReserve] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MyReserve] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MyReserve] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MyReserve] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MyReserve] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MyReserve] SET RECOVERY FULL 
GO
ALTER DATABASE [MyReserve] SET  MULTI_USER 
GO
ALTER DATABASE [MyReserve] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MyReserve] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MyReserve] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MyReserve] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MyReserve] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MyReserve] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MyReserve', N'ON'
GO
ALTER DATABASE [MyReserve] SET QUERY_STORE = ON
GO
ALTER DATABASE [MyReserve] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [MyReserve]
GO
/****** Object:  Table [dbo].[Categoria]    Script Date: 27/08/2024 14:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categoria](
	[cat_id] [int] NOT NULL,
	[cat_nombre] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[cat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Citas]    Script Date: 27/08/2024 14:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Citas](
	[cita_id] [int] IDENTITY(1,1) NOT NULL,
	[cita_usu_id_fk] [int] NOT NULL,
	[cita_pel_id_fk] [int] NOT NULL,
	[cita_pelu_id_fk] [int] NOT NULL,
	[cita_hora_id_fk] [int] NOT NULL,
	[cita_fecha] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cita_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CitasServicios]    Script Date: 27/08/2024 14:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CitasServicios](
	[citas_ser_cita_id_fk] [int] NOT NULL,
	[citas_ser_ser_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[citas_ser_cita_id_fk] ASC,
	[citas_ser_ser_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GrupoPeluqueria]    Script Date: 27/08/2024 14:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GrupoPeluqueria](
	[gp_id] [int] IDENTITY(1,1) NOT NULL,
	[gp_nombre] [varchar](255) NOT NULL,
	[gp_correo_electronico] [varchar](255) NOT NULL,
	[gp_contrasenha] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[gp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Horarios]    Script Date: 27/08/2024 14:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Horarios](
	[hora_id] [int] NOT NULL,
	[hora_fecha] [time](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[hora_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Paises]    Script Date: 27/08/2024 14:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paises](
	[pai_id] [int] NOT NULL,
	[pai_nombre] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pai_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Peluqueria]    Script Date: 27/08/2024 14:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peluqueria](
	[pelu_id] [int] IDENTITY(1,1) NOT NULL,
	[pelu_nombre] [varchar](255) NOT NULL,
	[pelu_correo_electronico] [varchar](255) NOT NULL,
	[pelu_contrasenha] [varchar](255) NOT NULL,
	[pelu_pais] [varchar](255) NOT NULL,
	[pelu_region] [varchar](255) NOT NULL,
	[pelu_ciudad] [varchar](255) NOT NULL,
	[pelu_direccion] [varchar](255) NOT NULL,
	[pelu_telefono] [varchar](255) NOT NULL,
	[pelu_gp_id_fk] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pelu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PeluqueriaHorarios]    Script Date: 27/08/2024 14:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PeluqueriaHorarios](
	[pelu_hora_pelu_id_fk] [int] NOT NULL,
	[pelu_hora_hora_id_fk] [int] NOT NULL,
	[hora_reservado] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[pelu_hora_pelu_id_fk] ASC,
	[pelu_hora_hora_id_fk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PeluqueriaServicios]    Script Date: 27/08/2024 14:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PeluqueriaServicios](
	[pelu_ser_pelu_id_fk] [int] NOT NULL,
	[pelu_ser_ser_id_fk] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[pelu_ser_pelu_id_fk] ASC,
	[pelu_ser_ser_id_fk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Peluquero]    Script Date: 27/08/2024 14:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peluquero](
	[pel_id] [int] IDENTITY(1,1) NOT NULL,
	[pel_nombre] [varchar](255) NOT NULL,
	[pel_correo_electronico] [varchar](255) NOT NULL,
	[pel_contrasenha] [varchar](255) NOT NULL,
	[pel_descripcion] [varchar](255) NULL,
	[pel_experiencia] [int] NOT NULL,
	[pel_instagram] [varchar](255) NULL,
	[pel_pelu_id_fk] [int] NOT NULL,
	[pel_grupo_id_fk] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[pel_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Region]    Script Date: 27/08/2024 14:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Region](
	[reg_id] [int] NOT NULL,
	[reg_pai_id_fk] [int] NOT NULL,
	[reg_nombre] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[reg_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Servicios]    Script Date: 27/08/2024 14:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Servicios](
	[ser_id] [int] IDENTITY(1,1) NOT NULL,
	[ser_nombre] [varchar](255) NOT NULL,
	[ser_precio] [int] NOT NULL,
	[ser_cat_id_fk] [int] NOT NULL,
	[ser_pelu_id_fk] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ser_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 27/08/2024 14:56:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[usu_id] [int] IDENTITY(1,1) NOT NULL,
	[usu_nombre] [varchar](255) NOT NULL,
	[usu_correo_electronico] [varchar](255) NOT NULL,
	[usu_contrasenha] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[usu_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Categoria] ([cat_id], [cat_nombre]) VALUES (1, N'Corte de Pelo')
GO
INSERT [dbo].[Categoria] ([cat_id], [cat_nombre]) VALUES (2, N'Barba')
GO
INSERT [dbo].[Categoria] ([cat_id], [cat_nombre]) VALUES (3, N'Color')
GO
INSERT [dbo].[Categoria] ([cat_id], [cat_nombre]) VALUES (4, N'Manicura')
GO
INSERT [dbo].[Categoria] ([cat_id], [cat_nombre]) VALUES (5, N'Depilaciones')
GO
INSERT [dbo].[Categoria] ([cat_id], [cat_nombre]) VALUES (6, N'Mechas')
GO
INSERT [dbo].[Categoria] ([cat_id], [cat_nombre]) VALUES (7, N'Pedicura')
GO
INSERT [dbo].[Categoria] ([cat_id], [cat_nombre]) VALUES (8, N'Otros')
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (1, CAST(N'08:30:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (2, CAST(N'09:00:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (3, CAST(N'09:30:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (4, CAST(N'10:00:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (5, CAST(N'10:30:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (6, CAST(N'11:00:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (7, CAST(N'11:30:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (8, CAST(N'12:00:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (9, CAST(N'12:30:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (10, CAST(N'13:00:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (11, CAST(N'13:30:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (12, CAST(N'14:00:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (13, CAST(N'14:30:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (14, CAST(N'15:00:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (15, CAST(N'15:30:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (16, CAST(N'16:00:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (17, CAST(N'16:30:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (18, CAST(N'17:00:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (19, CAST(N'17:30:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (20, CAST(N'18:00:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (21, CAST(N'18:30:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (22, CAST(N'19:00:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (23, CAST(N'19:30:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (24, CAST(N'20:00:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (25, CAST(N'20:30:00' AS Time))
GO
INSERT [dbo].[Horarios] ([hora_id], [hora_fecha]) VALUES (26, CAST(N'21:00:00' AS Time))
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (1, N'Australia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (2, N'Austria')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (3, N'Azerbaiy·n')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (4, N'Anguilla')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (5, N'Argentina')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (6, N'Armenia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (7, N'Bielorrusia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (8, N'Belice')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (9, N'BÈlgica')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (10, N'Bermudas')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (11, N'Bulgaria')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (12, N'Brasil')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (13, N'Reino Unido')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (14, N'HungrÌa')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (15, N'Vietnam')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (16, N'Haiti')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (17, N'Guadalupe')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (18, N'Alemania')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (19, N'PaÌses Bajos, Holanda')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (20, N'Grecia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (21, N'Georgia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (22, N'Dinamarca')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (23, N'Egipto')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (24, N'Israel')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (25, N'India')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (26, N'Ir·n')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (27, N'Irlanda')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (28, N'EspaÒa')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (29, N'Italia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (30, N'Kazajst·n')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (31, N'Camer˙n')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (32, N'Canad·')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (33, N'Chipre')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (34, N'Kirguist·n')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (35, N'China')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (36, N'Costa Rica')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (37, N'Kuwait')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (38, N'Letonia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (39, N'Libia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (40, N'Lituania')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (41, N'Luxemburgo')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (42, N'MÈxico')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (43, N'Moldavia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (44, N'MÛnaco')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (45, N'Nueva Zelanda')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (46, N'Noruega')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (47, N'Polonia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (48, N'Portugal')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (49, N'ReuniÛn')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (50, N'Rusia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (51, N'El Salvador')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (52, N'Eslovaquia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (53, N'Eslovenia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (54, N'Surinam')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (55, N'Estados Unidos')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (56, N'Tadjikistan')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (57, N'Turkmenistan')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (58, N'Islas Turcas y Caicos')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (59, N'TurquÌa')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (60, N'Uganda')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (61, N'Uzbekist·n')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (62, N'Ucrania')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (63, N'Finlandia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (64, N'Francia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (65, N'Rep˙blica Checa')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (66, N'Suiza')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (67, N'Suecia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (68, N'Estonia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (69, N'Corea del Sur')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (70, N'JapÛn')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (71, N'Croacia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (72, N'RumanÌa')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (73, N'Hong Kong')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (74, N'Indonesia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (75, N'Jordania')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (76, N'Malasia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (77, N'Singapur')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (78, N'Taiwan')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (79, N'Bosnia y Herzegovina')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (80, N'Bahamas')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (81, N'Chile')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (82, N'Colombia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (83, N'Islandia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (84, N'Corea del Norte')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (85, N'Macedonia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (86, N'Malta')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (87, N'Pakist·n')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (88, N'Pap˙a-Nueva Guinea')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (89, N'Per˙')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (90, N'Filipinas')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (91, N'Arabia Saudita')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (92, N'Tailandia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (93, N'Emiratos ¡rabes Unidos')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (94, N'Groenlandia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (95, N'Venezuela')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (96, N'Zimbabwe')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (97, N'Kenia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (98, N'Algeria')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (99, N'LÌbano')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (100, N'Botsuana')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (101, N'Tanzania')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (102, N'Namibia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (103, N'Ecuador')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (104, N'Marruecos')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (105, N'Ghana')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (106, N'Siria')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (107, N'Nepal')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (108, N'Mauritania')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (109, N'Seychelles')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (110, N'Paraguay')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (111, N'Uruguay')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (112, N'Congo (Brazzaville)')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (113, N'Cuba')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (114, N'Albania')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (115, N'Nigeria')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (116, N'Zambia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (117, N'Mozambique')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (119, N'Angola')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (120, N'Sri Lanka')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (121, N'EtiopÌa')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (122, N'T˙nez')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (123, N'Bolivia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (124, N'Panam·')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (125, N'Malawi')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (126, N'Liechtenstein')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (127, N'Bahrein')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (128, N'Barbados')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (130, N'Chad')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (131, N'Man, Isla de')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (132, N'Jamaica')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (133, N'MalÌ')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (134, N'Madagascar')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (135, N'Senegal')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (136, N'Togo')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (137, N'Honduras')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (138, N'Rep˙blica Dominicana')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (139, N'Mongolia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (140, N'Irak')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (141, N'Sud·frica')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (142, N'Aruba')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (143, N'Gibraltar')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (144, N'Afganist·n')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (145, N'Andorra')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (147, N'Antigua y Barbuda')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (149, N'Bangladesh')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (151, N'BenÌn')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (152, N'But·n')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (154, N'Islas Virgenes Brit·nicas')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (155, N'BrunÈi')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (156, N'Burkina Faso')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (157, N'Burundi')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (158, N'Camboya')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (159, N'Cabo Verde')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (164, N'Comores')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (165, N'Congo (Kinshasa)')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (166, N'Cook, Islas')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (168, N'Costa de Marfil')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (169, N'Djibouti, Yibuti')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (171, N'Timor Oriental')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (172, N'Guinea Ecuatorial')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (173, N'Eritrea')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (175, N'Feroe, Islas')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (176, N'Fiyi')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (178, N'Polinesia Francesa')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (180, N'GabÛn')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (181, N'Gambia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (184, N'Granada')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (185, N'Guatemala')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (186, N'Guernsey')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (187, N'Guinea')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (188, N'Guinea-Bissau')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (189, N'Guyana')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (193, N'Jersey')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (195, N'Kiribati')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (196, N'Laos')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (197, N'Lesotho')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (198, N'Liberia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (200, N'Maldivas')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (201, N'Martinica')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (202, N'Mauricio')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (205, N'Myanmar')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (206, N'Nauru')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (207, N'Antillas Holandesas')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (208, N'Nueva Caledonia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (209, N'Nicaragua')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (210, N'NÌger')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (212, N'Norfolk Island')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (213, N'Om·n')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (215, N'Isla Pitcairn')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (216, N'Qatar')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (217, N'Ruanda')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (218, N'Santa Elena')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (219, N'San Cristobal y Nevis')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (220, N'Santa LucÌa')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (221, N'San Pedro y MiquelÛn')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (222, N'San Vincente y Granadinas')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (223, N'Samoa')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (224, N'San Marino')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (225, N'San TomÈ y PrÌncipe')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (226, N'Serbia y Montenegro')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (227, N'Sierra Leona')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (228, N'Islas SalomÛn')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (229, N'Somalia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (232, N'Sud·n')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (234, N'Swazilandia')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (235, N'Tokelau')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (236, N'Tonga')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (237, N'Trinidad y Tobago')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (239, N'Tuvalu')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (240, N'Vanuatu')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (241, N'Wallis y Futuna')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (242, N'S·hara Occidental')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (243, N'Yemen')
GO
INSERT [dbo].[Paises] ([pai_id], [pai_nombre]) VALUES (246, N'Puerto Rico')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1, 3, N'Azerbaijan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2, 3, N'Nargorni Karabakh')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (3, 3, N'Nakhichevanskaya Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (4, 4, N'Anguilla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (5, 7, N'Brestskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (6, 7, N'Vitebskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (7, 7, N'Gomelskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (8, 7, N'Grodnenskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (9, 7, N'Minskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (10, 7, N'Mogilevskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (11, 8, N'Belize')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (12, 10, N'Hamilton')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (13, 15, N'Dong Bang Song Cuu Long')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (14, 15, N'Dong Bang Song Hong')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (15, 15, N'Dong Nam Bo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (16, 15, N'Duyen Hai Mien Trung')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (17, 15, N'Khu Bon Cu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (18, 15, N'Mien Nui Va Trung Du')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (19, 15, N'Thai Nguyen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (20, 16, N'Artibonite')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (21, 16, N'GrandAnse')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (22, 16, N'North West')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (23, 16, N'West')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (24, 16, N'South')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (25, 16, N'South East')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (26, 17, N'Grande-Terre')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (27, 17, N'Basse-Terre')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (28, 21, N'Abkhazia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (29, 21, N'Ajaria')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (30, 21, N'Georgia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (31, 21, N'South Ossetia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (32, 23, N'Al Q√Ñ¬Åhira')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (33, 23, N'Aswan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (34, 23, N'Asyut')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (35, 23, N'Beni Suef')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (36, 23, N'Gharbia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (37, 23, N'Damietta')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (38, 24, N'Southern District')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (39, 24, N'Central District')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (40, 24, N'Northern District')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (41, 24, N'Haifa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (42, 24, N'Tel Aviv')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (43, 24, N'Jerusalem')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (44, 25, N'Bangala')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (45, 25, N'Chhattisgarh')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (46, 25, N'Karnataka')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (47, 25, N'Uttaranchal')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (48, 25, N'Andhara Pradesh')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (49, 25, N'Assam')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (50, 25, N'Bihar')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (51, 25, N'Gujarat')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (52, 25, N'Jammu and Kashmir')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (53, 25, N'Kerala')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (54, 25, N'Madhya Pradesh')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (55, 25, N'Manipur')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (56, 25, N'Maharashtra')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (57, 25, N'Megahalaya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (58, 25, N'Orissa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (59, 25, N'Punjab')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (60, 25, N'Pondisheri')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (61, 25, N'Rajasthan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (62, 25, N'Tamil Nadu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (63, 25, N'Tripura')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (64, 25, N'Uttar Pradesh')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (65, 25, N'Haryana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (66, 25, N'Chandigarh')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (67, 26, N'Azarbayjan-e Khavari')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (68, 26, N'Esfahan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (69, 26, N'Hamadan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (70, 26, N'Kordestan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (71, 26, N'Markazi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (72, 26, N'Sistan-e Baluches')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (73, 26, N'Yazd')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (74, 26, N'Kerman')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (75, 26, N'Kermanshakhan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (76, 26, N'Mazenderan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (77, 26, N'Tehran')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (78, 26, N'Fars')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (79, 26, N'Horasan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (80, 26, N'Husistan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (81, 30, N'Aktyubinskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (82, 30, N'Alma-Atinskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (83, 30, N'Vostochno-Kazahstanskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (84, 30, N'Gurevskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (85, 30, N'Zhambylskaya obl. (Dzhambulskaya obl.)')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (86, 30, N'Dzhezkazganskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (87, 30, N'Karagandinskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (88, 30, N'Kzyl-Ordinskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (89, 30, N'Kokchetavskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (90, 30, N'Kustanaiskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (91, 30, N'Mangystauskaya (Mangyshlakskaya obl.)')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (92, 30, N'Pavlodarskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (93, 30, N'Severo-Kazahstanskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (94, 30, N'Taldy-Kurganskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (95, 30, N'Turgaiskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (96, 30, N'Akmolinskaya obl. (Tselinogradskaya obl.)')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (97, 30, N'Chimkentskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (98, 31, N'Littoral')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (99, 31, N'Southwest Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (100, 31, N'North')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (101, 31, N'Central')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (102, 33, N'Government controlled area')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (103, 33, N'Turkish controlled area')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (104, 34, N'Issik Kulskaya Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (105, 34, N'Kyrgyzstan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (106, 34, N'Narinskaya Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (107, 34, N'Oshskaya Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (108, 34, N'Tallaskaya Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (109, 37, N'al-Jahra')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (110, 37, N'al-Kuwait')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (111, 38, N'Latviya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (112, 39, N'Tarabulus')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (113, 39, N'Bengasi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (114, 40, N'Litva')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (115, 43, N'Moldova')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (116, 45, N'Auckland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (117, 45, N'Bay of Plenty')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (118, 45, N'Canterbury')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (119, 45, N'Gisborne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (120, 45, N'Hawkes Bay')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (121, 45, N'Manawatu-Wanganui')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (122, 45, N'Marlborough')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (123, 45, N'Nelson')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (124, 45, N'Northland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (125, 45, N'Otago')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (126, 45, N'Southland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (127, 45, N'Taranaki')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (128, 45, N'Tasman')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (129, 45, N'Waikato')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (130, 45, N'Wellington')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (131, 45, N'West Coast')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (132, 49, N'Saint-Denis')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (133, 50, N'Altaiskii krai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (134, 50, N'Amurskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (135, 50, N'Arhangelskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (136, 50, N'Astrahanskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (137, 50, N'Bashkiriya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (138, 50, N'Belgorodskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (139, 50, N'Bryanskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (140, 50, N'Buryatiya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (141, 50, N'Vladimirskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (142, 50, N'Volgogradskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (143, 50, N'Vologodskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (144, 50, N'Voronezhskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (145, 50, N'Nizhegorodskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (146, 50, N'Dagestan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (147, 50, N'Evreiskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (148, 50, N'Ivanovskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (149, 50, N'Irkutskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (150, 50, N'Kabardino-Balkariya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (151, 50, N'Kaliningradskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (152, 50, N'Tverskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (153, 50, N'Kalmykiya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (154, 50, N'Kaluzhskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (155, 50, N'Kamchatskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (156, 50, N'Kareliya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (157, 50, N'Kemerovskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (158, 50, N'Kirovskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (159, 50, N'Komi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (160, 50, N'Kostromskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (161, 50, N'Krasnodarskii krai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (162, 50, N'Krasnoyarskii krai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (163, 50, N'Kurganskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (164, 50, N'Kurskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (165, 50, N'Lipetskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (166, 50, N'Magadanskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (167, 50, N'Marii El')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (168, 50, N'Mordoviya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (169, 50, N'Moscow Y Moscow Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (170, 50, N'Murmanskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (171, 50, N'Novgorodskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (172, 50, N'Novosibirskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (173, 50, N'Omskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (174, 50, N'Orenburgskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (175, 50, N'Orlovskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (176, 50, N'Penzenskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (177, 50, N'Permskiy krai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (178, 50, N'Primorskii krai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (179, 50, N'Pskovskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (180, 50, N'Rostovskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (181, 50, N'Ryazanskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (182, 50, N'Samarskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (183, 50, N'Saint-Petersburg and Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (184, 50, N'Saratovskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (185, 50, N'Saha (Yakutiya)')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (186, 50, N'Sahalin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (187, 50, N'Sverdlovskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (188, 50, N'Severnaya Osetiya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (189, 50, N'Smolenskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (190, 50, N'Stavropolskii krai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (191, 50, N'Tambovskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (192, 50, N'Tatarstan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (193, 50, N'Tomskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (195, 50, N'Tulskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (196, 50, N'Tyumenskaya obl. i Hanty-Mansiiskii AO')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (197, 50, N'Udmurtiya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (198, 50, N'Ulyanovskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (199, 50, N'Uralskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (200, 50, N'Habarovskii krai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (201, 50, N'Chelyabinskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (202, 50, N'Checheno-Ingushetiya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (203, 50, N'Chitinskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (204, 50, N'Chuvashiya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (205, 50, N'Yaroslavskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (206, 51, N'Ahuachap·n')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (207, 51, N'Cuscatl·n')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (208, 51, N'La Libertad')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (209, 51, N'La Paz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (210, 51, N'La UniÛn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (211, 51, N'San Miguel')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (212, 51, N'San Salvador')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (213, 51, N'Santa Ana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (214, 51, N'Sonsonate')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (215, 54, N'Paramaribo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (216, 56, N'Gorno-Badakhshan Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (217, 56, N'Kuljabsk Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (218, 56, N'Kurgan-Tjube Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (219, 56, N'Sughd Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (220, 56, N'Tajikistan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (221, 57, N'Ashgabat Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (222, 57, N'Krasnovodsk Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (223, 57, N'Mary Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (224, 57, N'Tashauz Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (225, 57, N'Chardzhou Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (226, 58, N'Grand Turk')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (227, 59, N'Bartin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (228, 59, N'Bayburt')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (229, 59, N'Karabuk')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (230, 59, N'Adana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (231, 59, N'Aydin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (232, 59, N'Amasya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (233, 59, N'Ankara')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (234, 59, N'Antalya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (235, 59, N'Artvin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (236, 59, N'Afion')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (237, 59, N'Balikesir')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (238, 59, N'Bilecik')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (239, 59, N'Bursa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (240, 59, N'Gaziantep')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (241, 59, N'Denizli')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (242, 59, N'Izmir')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (243, 59, N'Isparta')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (244, 59, N'Icel')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (245, 59, N'Kayseri')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (246, 59, N'Kars')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (247, 59, N'Kodjaeli')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (248, 59, N'Konya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (249, 59, N'Kirklareli')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (250, 59, N'Kutahya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (251, 59, N'Malatya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (252, 59, N'Manisa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (253, 59, N'Sakarya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (254, 59, N'Samsun')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (255, 59, N'Sivas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (256, 59, N'Istanbul')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (257, 59, N'Trabzon')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (258, 59, N'Corum')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (259, 59, N'Edirne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (260, 59, N'Elazig')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (261, 59, N'Erzincan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (262, 59, N'Erzurum')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (263, 59, N'Eskisehir')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (264, 60, N'Jinja')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (265, 60, N'Kampala')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (266, 61, N'Andijon Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (267, 61, N'Buxoro Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (268, 61, N'Jizzac Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (269, 61, N'Qaraqalpaqstan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (270, 61, N'Qashqadaryo Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (271, 61, N'Navoiy Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (272, 61, N'Namangan Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (273, 61, N'Samarqand Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (274, 61, N'Surxondaryo Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (275, 61, N'Sirdaryo Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (276, 61, N'Tashkent Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (277, 61, N'Fergana Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (278, 61, N'Xorazm Region')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (279, 62, N'Vinnitskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (280, 62, N'Volynskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (281, 62, N'Dnepropetrovskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (282, 62, N'Donetskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (283, 62, N'Zhitomirskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (284, 62, N'Zakarpatskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (285, 62, N'Zaporozhskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (286, 62, N'Ivano-Frankovskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (287, 62, N'Kievskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (288, 62, N'Kirovogradskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (289, 62, N'Krymskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (290, 62, N'Luganskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (291, 62, N'Lvovskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (292, 62, N'Nikolaevskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (293, 62, N'Odesskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (294, 62, N'Poltavskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (295, 62, N'Rovenskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (296, 62, N'Sumskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (297, 62, N'Ternopolskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (298, 62, N'Harkovskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (299, 62, N'Hersonskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (300, 62, N'Hmelnitskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (301, 62, N'Cherkasskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (302, 62, N'Chernigovskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (303, 62, N'Chernovitskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (304, 68, N'Estoniya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (305, 69, N'Cheju')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (306, 69, N'Chollabuk')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (307, 69, N'Chollanam')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (308, 69, N'Chungcheongbuk')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (309, 69, N'Chungcheongnam')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (310, 69, N'Incheon')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (311, 69, N'Kangweon')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (312, 69, N'Kwangju')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (313, 69, N'Kyeonggi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (314, 69, N'Kyeongsangbuk')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (315, 69, N'Kyeongsangnam')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (316, 69, N'Pusan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (317, 69, N'Seoul')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (318, 69, N'Taegu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (319, 69, N'Taejeon')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (320, 69, N'Ulsan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (321, 70, N'Aichi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (322, 70, N'Akita')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (323, 70, N'Aomori')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (324, 70, N'Wakayama')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (325, 70, N'Gifu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (326, 70, N'Gunma')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (327, 70, N'Ibaraki')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (328, 70, N'Iwate')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (329, 70, N'Ishikawa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (330, 70, N'Kagawa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (331, 70, N'Kagoshima')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (332, 70, N'Kanagawa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (333, 70, N'Kyoto')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (334, 70, N'Kochi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (335, 70, N'Kumamoto')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (336, 70, N'Mie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (337, 70, N'Miyagi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (338, 70, N'Miyazaki')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (339, 70, N'Nagano')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (340, 70, N'Nagasaki')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (341, 70, N'Nara')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (342, 70, N'Niigata')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (343, 70, N'Okayama')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (344, 70, N'Okinawa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (345, 70, N'Osaka')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (346, 70, N'Saga')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (347, 70, N'Saitama')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (348, 70, N'Shiga')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (349, 70, N'Shizuoka')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (350, 70, N'Shimane')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (351, 70, N'Tiba')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (352, 70, N'Tokyo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (353, 70, N'Tokushima')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (354, 70, N'Tochigi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (355, 70, N'Tottori')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (356, 70, N'Toyama')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (357, 70, N'Fukui')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (358, 70, N'Fukuoka')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (359, 70, N'Fukushima')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (360, 70, N'Hiroshima')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (361, 70, N'Hokkaido')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (362, 70, N'Hyogo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (363, 70, N'Yoshimi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (364, 70, N'Yamagata')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (365, 70, N'Yamaguchi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (366, 70, N'Yamanashi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (368, 73, N'Hong Kong')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (369, 74, N'Indonesia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (370, 75, N'Jordan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (371, 76, N'Malaysia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (372, 77, N'Singapore')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (373, 78, N'Taiwan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (374, 30, N'Kazahstan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (375, 62, N'Ukraina')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (376, 25, N'India')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (377, 23, N'Egypt')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (378, 106, N'Damascus')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (379, 131, N'Isle of Man')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (380, 30, N'Zapadno-Kazahstanskaya obl.')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (381, 50, N'Adygeya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (382, 50, N'Hakasiya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (383, 93, N'Dubai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (384, 50, N'Chukotskii AO')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (385, 99, N'Beirut')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (386, 137, N'Tegucigalpa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (387, 138, N'Santo Domingo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (388, 139, N'Ulan Bator')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (389, 23, N'Sinai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (390, 140, N'Baghdad')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (391, 140, N'Basra')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (392, 140, N'Mosul')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (393, 141, N'Johannesburg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (394, 104, N'Morocco')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (395, 104, N'Tangier')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (396, 50, N'Yamalo-Nenetskii AO')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (397, 122, N'Tunisia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (398, 92, N'Thailand')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (399, 117, N'Mozambique')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (400, 84, N'Korea')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (401, 87, N'Pakistan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (402, 142, N'Aruba')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (403, 80, N'Bahamas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (404, 69, N'South Korea')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (405, 132, N'Jamaica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (406, 93, N'Sharjah')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (407, 93, N'Abu Dhabi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (409, 24, N'Ramat Hagolan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (410, 115, N'Nigeria')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (411, 64, N'Ain')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (412, 64, N'Haute-Savoie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (413, 64, N'Aisne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (414, 64, N'Allier')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (415, 64, N'Alpes-de-Haute-Provence')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (416, 64, N'Hautes-Alpes')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (417, 64, N'Alpes-Maritimes')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (418, 64, N'ArdËche')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (419, 64, N'Ardennes')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (420, 64, N'AriËge')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (421, 64, N'Aube')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (422, 64, N'Aude')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (423, 64, N'Aveyron')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (424, 64, N'Bouches-du-RhÙne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (425, 64, N'Calvados')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (426, 64, N'Cantal')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (427, 64, N'Charente')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (428, 64, N'Charente Maritime')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (429, 64, N'Cher')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (430, 64, N'CorrËze')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (431, 64, N'Dordogne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (432, 64, N'Corse')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (433, 64, N'CÙte dOr')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (434, 64, N'SaÙne et Loire')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (435, 64, N'CÙtes dArmor')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (436, 64, N'Creuse')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (437, 64, N'Doubs')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (438, 64, N'DrÙme')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (439, 64, N'Eure')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (440, 64, N'Eure-et-Loire')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (441, 64, N'FinistËre')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (442, 64, N'Gard')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (443, 64, N'Haute-Garonne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (444, 64, N'Gers')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (445, 64, N'Gironde')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (446, 64, N'HÈrault')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (447, 64, N'Ille et Vilaine')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (448, 64, N'Indre')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (449, 64, N'Indre-et-Loire')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (450, 64, N'IsËre')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (451, 64, N'Jura')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (452, 64, N'Landes')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (453, 64, N'Loir-et-Cher')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (454, 64, N'Loire')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (455, 64, N'RhÙne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (456, 64, N'Haute-Loire')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (457, 64, N'Loire Atlantique')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (458, 64, N'Loiret')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (459, 64, N'Lot')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (460, 64, N'Lot-et-Garonne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (461, 64, N'LozËre')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (462, 64, N'Maine et Loire')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (463, 64, N'Manche')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (464, 64, N'Marne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (465, 64, N'Haute-Marne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (466, 64, N'Mayenne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (467, 64, N'Meurthe-et-Moselle')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (468, 64, N'Meuse')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (469, 64, N'Morbihan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (470, 64, N'Moselle')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (471, 64, N'NiËvre')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (472, 64, N'Nord')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (473, 64, N'Oise')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (474, 64, N'Orne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (475, 64, N'Pas-de-Calais')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (476, 64, N'Puy-de-DÙme')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (477, 64, N'PyrÈnÈes-Atlantiques')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (478, 64, N'Hautes-PyrÈnÈes')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (479, 64, N'PyrÈnÈes-Orientales')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (480, 64, N'Bas Rhin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (481, 64, N'Haut Rhin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (482, 64, N'Haute-SaÙne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (483, 64, N'Sarthe')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (484, 64, N'Savoie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (485, 64, N'Paris')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (486, 64, N'Seine-Maritime')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (487, 64, N'Seine-et-Marne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (488, 64, N'Yvelines')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (489, 64, N'Deux-SËvres')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (490, 64, N'Somme')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (491, 64, N'Tarn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (492, 64, N'Tarn-et-Garonne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (493, 64, N'Var')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (494, 64, N'Vaucluse')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (495, 64, N'VendÈe')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (496, 64, N'Vienne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (497, 64, N'Haute-Vienne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (498, 64, N'Vosges')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (499, 64, N'Yonne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (500, 64, N'Territoire de Belfort')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (501, 64, N'Essonne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (502, 64, N'Hauts-de-Seine')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (503, 64, N'Seine-Saint-Denis')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (504, 64, N'Val-de-Marne')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (505, 64, N'Val-dOise')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (506, 29, N'Piemonte - Torino')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (507, 29, N'Piemonte - Alessandria')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (508, 29, N'Piemonte - Asti')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (509, 29, N'Piemonte - Biella')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (510, 29, N'Piemonte - Cuneo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (511, 29, N'Piemonte - Novara')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (512, 29, N'Piemonte - Verbania')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (513, 29, N'Piemonte - Vercelli')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (514, 29, N'Valle dAosta - Aosta')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (515, 29, N'Lombardia - Milano')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (516, 29, N'Lombardia - Bergamo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (517, 29, N'Lombardia - Brescia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (518, 29, N'Lombardia - Como')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (519, 29, N'Lombardia - Cremona')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (520, 29, N'Lombardia - Lecco')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (521, 29, N'Lombardia - Lodi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (522, 29, N'Lombardia - Mantova')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (523, 29, N'Lombardia - Pavia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (524, 29, N'Lombardia - Sondrio')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (525, 29, N'Lombardia - Varese')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (526, 29, N'Trentino Alto Adige - Trento')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (527, 29, N'Trentino Alto Adige - Bolzano')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (528, 29, N'Veneto - Venezia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (529, 29, N'Veneto - Belluno')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (530, 29, N'Veneto - Padova')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (531, 29, N'Veneto - Rovigo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (532, 29, N'Veneto - Treviso')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (533, 29, N'Veneto - Verona')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (534, 29, N'Veneto - Vicenza')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (535, 29, N'Friuli Venezia Giulia - Trieste')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (536, 29, N'Friuli Venezia Giulia - Gorizia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (537, 29, N'Friuli Venezia Giulia - Pordenone')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (538, 29, N'Friuli Venezia Giulia - Udine')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (539, 29, N'Liguria - Genova')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (540, 29, N'Liguria - Imperia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (541, 29, N'Liguria - La Spezia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (542, 29, N'Liguria - Savona')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (543, 29, N'Emilia Romagna - Bologna')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (544, 29, N'Emilia Romagna - Ferrara')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (545, 29, N'Emilia Romagna - ForlÏ-Cesena')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (546, 29, N'Emilia Romagna - Modena')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (547, 29, N'Emilia Romagna - Parma')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (548, 29, N'Emilia Romagna - Piacenza')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (549, 29, N'Emilia Romagna - Ravenna')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (550, 29, N'Emilia Romagna - Reggio Emilia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (551, 29, N'Emilia Romagna - Rimini')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (552, 29, N'Toscana - Firenze')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (553, 29, N'Toscana - Arezzo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (554, 29, N'Toscana - Grosseto')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (555, 29, N'Toscana - Livorno')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (556, 29, N'Toscana - Lucca')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (557, 29, N'Toscana - Massa Carrara')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (558, 29, N'Toscana - Pisa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (559, 29, N'Toscana - Pistoia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (560, 29, N'Toscana - Prato')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (561, 29, N'Toscana - Siena')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (562, 29, N'Umbria - Perugia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (563, 29, N'Umbria - Terni')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (564, 29, N'Marche - Ancona')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (565, 29, N'Marche - Ascoli Piceno')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (566, 29, N'Marche - Macerata')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (567, 29, N'Marche - Pesaro - Urbino')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (568, 29, N'Lazio - Roma')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (569, 29, N'Lazio - Frosinone')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (570, 29, N'Lazio - Latina')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (571, 29, N'Lazio - Rieti')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (572, 29, N'Lazio - Viterbo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (573, 29, N'Abruzzo - LAquila')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (574, 29, N'Abruzzo - Chieti')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (575, 29, N'Abruzzo - Pescara')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (576, 29, N'Abruzzo - Teramo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (577, 29, N'Molise - Campobasso')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (578, 29, N'Molise - Isernia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (579, 29, N'Campania - Napoli')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (580, 29, N'Campania - Avellino')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (581, 29, N'Campania - Benevento')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (582, 29, N'Campania - Caserta')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (583, 29, N'Campania - Salerno')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (584, 29, N'Puglia - Bari')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (585, 29, N'Puglia - Brindisi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (586, 29, N'Puglia - Foggia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (587, 29, N'Puglia - Lecce')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (588, 29, N'Puglia - Taranto')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (589, 29, N'Basilicata - Potenza')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (590, 29, N'Basilicata - Matera')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (591, 29, N'Calabria - Catanzaro')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (592, 29, N'Calabria - Cosenza')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (593, 29, N'Calabria - Crotone')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (594, 29, N'Calabria - Reggio Calabria')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (595, 29, N'Calabria - Vibo Valentia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (596, 29, N'Sicilia - Palermo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (597, 29, N'Sicilia - Agrigento')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (598, 29, N'Sicilia - Caltanissetta')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (599, 29, N'Sicilia - Catania')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (600, 29, N'Sicilia - Enna')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (601, 29, N'Sicilia - Messina')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (602, 29, N'Sicilia - Ragusa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (603, 29, N'Sicilia - Siracusa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (604, 29, N'Sicilia - Trapani')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (605, 29, N'Sardegna - Cagliari')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (606, 29, N'Sardegna - Nuoro')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (607, 29, N'Sardegna - Oristano')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (608, 29, N'Sardegna - Sassari')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (609, 28, N'Las Palmas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (610, 28, N'Soria')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (611, 28, N'Palencia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (612, 28, N'Zamora')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (613, 28, N'C·diz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (614, 28, N'Navarra')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (615, 28, N'Ourense')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (616, 28, N'Segovia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (617, 28, N'Guip˙zcoa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (618, 28, N'Ciudad Real')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (619, 28, N'Vizcaya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (620, 28, N'¡lava')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (621, 28, N'A CoruÒa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (622, 28, N'Cantabria')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (623, 28, N'AlmerÌa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (624, 28, N'Zaragoza')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (625, 28, N'Santa Cruz de Tenerife')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (626, 28, N'C·ceres')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (627, 28, N'Guadalajara')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (628, 28, N'¡vila')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (629, 28, N'Toledo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (630, 28, N'CastellÛn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (631, 28, N'Tarragona')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (632, 28, N'Lugo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (633, 28, N'La Rioja')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (634, 28, N'Ceuta')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (635, 28, N'Murcia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (636, 28, N'Salamanca')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (637, 28, N'Valladolid')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (638, 28, N'JaÈn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (639, 28, N'Girona')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (640, 28, N'Granada')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (641, 28, N'Alacant')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (642, 28, N'CÛrdoba')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (643, 28, N'Albacete')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (644, 28, N'Cuenca')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (645, 28, N'Pontevedra')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (646, 28, N'Teruel')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (647, 28, N'Melilla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (648, 28, N'Barcelona')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (649, 28, N'Badajoz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (650, 28, N'Madrid')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (651, 28, N'Sevilla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (652, 28, N'ValËncia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (653, 28, N'Huelva')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (654, 28, N'Lleida')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (655, 28, N'LeÛn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (656, 28, N'Illes Balears')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (657, 28, N'Burgos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (658, 28, N'Huesca')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (659, 28, N'Asturias')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (660, 28, N'M·laga')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (661, 144, N'Afghanistan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (662, 210, N'Niger')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (663, 133, N'Mali')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (664, 156, N'Burkina Faso')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (665, 136, N'Togo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (666, 151, N'Benin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (667, 119, N'Angola')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (668, 102, N'Namibia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (669, 100, N'Botswana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (670, 134, N'Madagascar')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (671, 202, N'Mauritius')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (672, 196, N'Laos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (673, 158, N'Cambodia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (674, 90, N'Philippines')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (675, 88, N'Papua New Guinea')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (676, 228, N'Solomon Islands')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (677, 240, N'Vanuatu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (678, 176, N'Fiji')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (679, 223, N'Samoa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (680, 206, N'Nauru')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (681, 168, N'Cote DIvoire')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (682, 198, N'Liberia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (683, 187, N'Guinea')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (684, 189, N'Guyana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (685, 98, N'Algeria')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (686, 147, N'Antigua and Barbuda')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (687, 127, N'Bahrain')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (688, 149, N'Bangladesh')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (689, 128, N'Barbados')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (690, 152, N'Bhutan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (691, 155, N'Brunei')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (692, 157, N'Burundi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (693, 159, N'Cape Verde')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (694, 130, N'Chad')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (695, 164, N'Comoros')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (696, 112, N'Congo (Brazzaville)')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (697, 169, N'Djibouti')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (698, 171, N'East Timor')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (699, 173, N'Eritrea')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (700, 121, N'Ethiopia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (701, 180, N'Gabon')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (702, 181, N'Gambia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (703, 105, N'Ghana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (704, 197, N'Lesotho')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (705, 125, N'Malawi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (706, 200, N'Maldives')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (707, 205, N'Myanmar (Burma)')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (708, 107, N'Nepal')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (709, 213, N'Oman')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (710, 217, N'Rwanda')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (711, 91, N'Saudi Arabia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (712, 120, N'Sri Lanka')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (713, 232, N'Sudan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (714, 234, N'Swaziland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (715, 101, N'Tanzania')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (716, 236, N'Tonga')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (717, 239, N'Tuvalu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (718, 242, N'Western Sahara')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (719, 243, N'Yemen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (720, 116, N'Zambia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (721, 96, N'Zimbabwe')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (722, 66, N'Aargau')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (723, 66, N'Appenzell Innerrhoden')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (724, 66, N'Appenzell Ausserrhoden')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (725, 66, N'Bern')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (726, 66, N'Basel-Landschaft')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (727, 66, N'Basel-Stadt')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (728, 66, N'Fribourg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (729, 66, N'GenËve')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (730, 66, N'Glarus')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (731, 66, N'Graub¸nden')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (732, 66, N'Jura')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (733, 66, N'Luzern')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (734, 66, N'Neuch‚tel')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (735, 66, N'Nidwalden')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (736, 66, N'Obwalden')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (737, 66, N'Sankt Gallen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (738, 66, N'Schaffhausen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (739, 66, N'Solothurn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (740, 66, N'Schwyz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (741, 66, N'Thurgau')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (742, 66, N'Ticino')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (743, 66, N'Uri')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (744, 66, N'Vaud')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (745, 66, N'Valais')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (746, 66, N'Zug')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (747, 66, N'Z¸rich')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (749, 48, N'Aveiro')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (750, 48, N'Beja')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (751, 48, N'Braga')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (752, 48, N'Braganca')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (753, 48, N'Castelo Branco')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (754, 48, N'Coimbra')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (755, 48, N'Evora')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (756, 48, N'Faro')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (757, 48, N'Madeira')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (758, 48, N'Guarda')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (759, 48, N'Leiria')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (760, 48, N'Lisboa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (761, 48, N'Portalegre')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (762, 48, N'Porto')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (763, 48, N'Santarem')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (764, 48, N'Setubal')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (765, 48, N'Viana do Castelo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (766, 48, N'Vila Real')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (767, 48, N'Viseu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (768, 48, N'Azores')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (769, 55, N'Armed Forces Americas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (770, 55, N'Armed Forces Europe')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (771, 55, N'Alaska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (772, 55, N'Alabama')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (773, 55, N'Armed Forces Pacific')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (774, 55, N'Arkansas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (775, 55, N'American Samoa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (776, 55, N'Arizona')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (777, 55, N'California')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (778, 55, N'Colorado')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (779, 55, N'Connecticut')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (780, 55, N'District of Columbia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (781, 55, N'Delaware')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (782, 55, N'Florida')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (783, 55, N'Federated Statess of Micronesia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (784, 55, N'Georgia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (786, 55, N'Hawaii')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (787, 55, N'Iowa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (788, 55, N'Idaho')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (789, 55, N'Illinois')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (790, 55, N'Indiana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (791, 55, N'Kansas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (792, 55, N'Kentucky')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (793, 55, N'Louisiana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (794, 55, N'Massachusetts')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (795, 55, N'Maryland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (796, 55, N'Maine')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (797, 55, N'Marshall Islands')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (798, 55, N'Michigan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (799, 55, N'Minnesota')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (800, 55, N'Missouri')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (801, 55, N'Northern Mariana Islands')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (802, 55, N'Mississippi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (803, 55, N'Montana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (804, 55, N'North Carolina')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (805, 55, N'North Dakota')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (806, 55, N'Nebraska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (807, 55, N'New Hampshire')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (808, 55, N'New Jersey')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (809, 55, N'New Mexico')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (810, 55, N'Nevada')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (811, 55, N'New York')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (812, 55, N'Ohio')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (813, 55, N'Oklahoma')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (814, 55, N'Oregon')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (815, 55, N'Pennsylvania')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (816, 246, N'Puerto Rico')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (817, 55, N'Palau')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (818, 55, N'Rhode Island')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (819, 55, N'South Carolina')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (820, 55, N'South Dakota')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (821, 55, N'Tennessee')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (822, 55, N'Texas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (823, 55, N'Utah')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (824, 55, N'Virginia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (825, 55, N'Virgin Islands')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (826, 55, N'Vermont')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (827, 55, N'Washington')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (828, 55, N'West Virginia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (829, 55, N'Wisconsin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (830, 55, N'Wyoming')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (831, 94, N'Greenland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (832, 18, N'Brandenburg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (833, 18, N'Baden-W¸rttemberg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (834, 18, N'Bayern')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (835, 18, N'Hessen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (836, 18, N'Hamburg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (837, 18, N'Mecklenburg-Vorpommern')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (838, 18, N'Niedersachsen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (839, 18, N'Nordrhein-Westfalen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (840, 18, N'Rheinland-Pfalz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (841, 18, N'Schleswig-Holstein')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (842, 18, N'Sachsen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (843, 18, N'Sachsen-Anhalt')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (844, 18, N'Th¸ringen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (845, 18, N'Berlin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (846, 18, N'Bremen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (847, 18, N'Saarland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (848, 13, N'Scotland North')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (849, 13, N'England - East')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (850, 13, N'England - West Midlands')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (851, 13, N'England - South West')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (852, 13, N'England - North West')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (853, 13, N'England - Yorks Y Humber')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (854, 13, N'England - South East')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (855, 13, N'England - London')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (856, 13, N'Northern Ireland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (857, 13, N'England - North East')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (858, 13, N'Wales South')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (859, 13, N'Wales North')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (860, 13, N'England - East Midlands')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (861, 13, N'Scotland Central')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (862, 13, N'Scotland South')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (863, 13, N'Channel Islands')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (864, 13, N'Isle of Man')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (865, 2, N'Burgenland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (866, 2, N'K‰rnten')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (867, 2, N'Niederˆsterreich')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (868, 2, N'Oberˆsterreich')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (869, 2, N'Salzburg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (870, 2, N'Steiermark')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (871, 2, N'Tirol')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (872, 2, N'Vorarlberg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (873, 2, N'Wien')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (874, 9, N'Bruxelles')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (875, 9, N'West-Vlaanderen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (876, 9, N'Oost-Vlaanderen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (877, 9, N'Limburg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (878, 9, N'Vlaams Brabant')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (879, 9, N'Antwerpen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (880, 9, N'Li√Ñ¬çge')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (881, 9, N'Namur')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (882, 9, N'Hainaut')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (883, 9, N'Luxembourg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (884, 9, N'Brabant Wallon')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (887, 67, N'Blekinge Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (888, 67, N'Gavleborgs Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (890, 67, N'Gotlands Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (891, 67, N'Hallands Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (892, 67, N'Jamtlands Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (893, 67, N'Jonkopings Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (894, 67, N'Kalmar Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (895, 67, N'Dalarnas Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (897, 67, N'Kronobergs Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (899, 67, N'Norrbottens Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (900, 67, N'Orebro Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (901, 67, N'Ostergotlands Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (903, 67, N'Sodermanlands Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (904, 67, N'Uppsala Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (905, 67, N'Varmlands Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (906, 67, N'Vasterbottens Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (907, 67, N'Vasternorrlands Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (908, 67, N'Vastmanlands Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (909, 67, N'Stockholms Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (910, 67, N'Skane Lan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (911, 67, N'Vastra Gotaland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (913, 46, N'Akershus')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (914, 46, N'Aust-Agder')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (915, 46, N'Buskerud')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (916, 46, N'Finnmark')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (917, 46, N'Hedmark')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (918, 46, N'Hordaland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (919, 46, N'More og Romsdal')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (920, 46, N'Nordland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (921, 46, N'Nord-Trondelag')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (922, 46, N'Oppland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (923, 46, N'Oslo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (924, 46, N'Ostfold')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (925, 46, N'Rogaland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (926, 46, N'Sogn og Fjordane')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (927, 46, N'Sor-Trondelag')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (928, 46, N'Telemark')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (929, 46, N'Troms')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (930, 46, N'Vest-Agder')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (931, 46, N'Vestfold')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (933, 63, N'–ïland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (934, 63, N'Lapland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (935, 63, N'Oulu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (936, 63, N'Southern Finland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (937, 63, N'Eastern Finland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (938, 63, N'Western Finland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (940, 22, N'Arhus')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (941, 22, N'Bornholm')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (942, 22, N'Frederiksborg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (943, 22, N'Fyn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (944, 22, N'Kobenhavn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (945, 22, N'Staden Kobenhavn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (946, 22, N'Nordjylland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (947, 22, N'Ribe')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (948, 22, N'Ringkobing')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (949, 22, N'Roskilde')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (950, 22, N'Sonderjylland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (951, 22, N'Storstrom')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (952, 22, N'Vejle')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (953, 22, N'Vestsjalland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (954, 22, N'Viborg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (956, 65, N'Hlavni Mesto Praha')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (957, 65, N'Jihomoravsky Kraj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (958, 65, N'Jihocesky Kraj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (959, 65, N'Vysocina')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (960, 65, N'Karlovarsky Kraj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (961, 65, N'Kralovehradecky Kraj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (962, 65, N'Liberecky Kraj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (963, 65, N'Olomoucky Kraj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (964, 65, N'Moravskoslezsky Kraj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (965, 65, N'Pardubicky Kraj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (966, 65, N'Plzensky Kraj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (967, 65, N'Stredocesky Kraj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (968, 65, N'Ustecky Kraj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (969, 65, N'Zlinsky Kraj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (971, 114, N'Berat')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (972, 114, N'Diber')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (973, 114, N'Durres')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (974, 114, N'Elbasan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (975, 114, N'Fier')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (976, 114, N'Gjirokaster')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (977, 114, N'Korce')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (978, 114, N'Kukes')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (979, 114, N'Lezhe')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (980, 114, N'Shkoder')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (981, 114, N'Tirane')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (982, 114, N'Vlore')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (984, 145, N'Canillo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (985, 145, N'Encamp')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (986, 145, N'La Massana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (987, 145, N'Ordino')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (988, 145, N'Sant Julia de Loria')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (989, 145, N'Andorra la Vella')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (990, 145, N'Escaldes-Engordany')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (992, 6, N'Aragatsotn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (993, 6, N'Ararat')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (994, 6, N'Armavir')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (995, 6, N'Gegharkunik')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (996, 6, N'Kotayk')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (997, 6, N'Lorri')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (998, 6, N'Shirak')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (999, 6, N'Syunik')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1000, 6, N'Tavush')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1001, 6, N'Vayots Dzor')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1002, 6, N'Yerevan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1004, 79, N'Federation of Bosnia and Herzegovina')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1005, 79, N'Republika Srpska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1007, 11, N'Mikhaylovgrad')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1008, 11, N'Blagoevgrad')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1009, 11, N'Burgas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1010, 11, N'Dobrich')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1011, 11, N'Gabrovo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1012, 11, N'Grad Sofiya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1013, 11, N'Khaskovo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1014, 11, N'Kurdzhali')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1015, 11, N'Kyustendil')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1016, 11, N'Lovech')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1017, 11, N'Montana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1018, 11, N'Pazardzhik')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1019, 11, N'Pernik')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1020, 11, N'Pleven')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1021, 11, N'Plovdiv')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1022, 11, N'Razgrad')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1023, 11, N'Ruse')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1024, 11, N'Shumen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1025, 11, N'Silistra')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1026, 11, N'Sliven')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1027, 11, N'Smolyan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1028, 11, N'Sofiya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1029, 11, N'Stara Zagora')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1030, 11, N'Turgovishte')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1031, 11, N'Varna')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1032, 11, N'Veliko Turnovo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1033, 11, N'Vidin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1034, 11, N'Vratsa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1035, 11, N'Yambol')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1037, 71, N'Bjelovarsko-Bilogorska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1038, 71, N'Brodsko-Posavska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1039, 71, N'Dubrovacko-Neretvanska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1040, 71, N'Istarska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1041, 71, N'Karlovacka')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1042, 71, N'Koprivnicko-Krizevacka')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1043, 71, N'Krapinsko-Zagorska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1044, 71, N'Licko-Senjska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1045, 71, N'Medimurska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1046, 71, N'Osjecko-Baranjska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1047, 71, N'Pozesko-Slavonska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1048, 71, N'Primorsko-Goranska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1049, 71, N'Sibensko-Kninska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1050, 71, N'Sisacko-Moslavacka')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1051, 71, N'Splitsko-Dalmatinska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1052, 71, N'Varazdinska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1053, 71, N'Viroviticko-Podravska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1054, 71, N'Vukovarsko-Srijemska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1055, 71, N'Zadarska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1056, 71, N'Zagrebacka')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1057, 71, N'Grad Zagreb')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1059, 143, N'Gibraltar')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1060, 20, N'Evros')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1061, 20, N'Rodhopi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1062, 20, N'Xanthi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1063, 20, N'Drama')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1064, 20, N'Serrai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1065, 20, N'Kilkis')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1066, 20, N'Pella')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1067, 20, N'Florina')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1068, 20, N'Kastoria')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1069, 20, N'Grevena')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1070, 20, N'Kozani')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1071, 20, N'Imathia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1072, 20, N'Thessaloniki')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1073, 20, N'Kavala')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1074, 20, N'Khalkidhiki')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1075, 20, N'Pieria')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1076, 20, N'Ioannina')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1077, 20, N'Thesprotia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1078, 20, N'Preveza')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1079, 20, N'Arta')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1080, 20, N'Larisa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1081, 20, N'Trikala')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1082, 20, N'Kardhitsa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1083, 20, N'Magnisia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1084, 20, N'Kerkira')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1085, 20, N'Levkas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1086, 20, N'Kefallinia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1087, 20, N'Zakinthos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1088, 20, N'Fthiotis')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1089, 20, N'Evritania')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1090, 20, N'Aitolia kai Akarnania')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1091, 20, N'Fokis')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1092, 20, N'Voiotia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1093, 20, N'Evvoia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1094, 20, N'Attiki')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1095, 20, N'Argolis')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1096, 20, N'Korinthia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1097, 20, N'Akhaia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1098, 20, N'Ilia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1099, 20, N'Messinia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1100, 20, N'Arkadhia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1101, 20, N'Lakonia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1102, 20, N'Khania')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1103, 20, N'Rethimni')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1104, 20, N'Iraklion')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1105, 20, N'Lasithi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1106, 20, N'Dhodhekanisos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1107, 20, N'Samos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1108, 20, N'Kikladhes')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1109, 20, N'Khios')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1110, 20, N'Lesvos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1112, 14, N'Bacs-Kiskun')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1113, 14, N'Baranya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1114, 14, N'Bekes')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1115, 14, N'Borsod-Abauj-Zemplen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1116, 14, N'Budapest')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1117, 14, N'Csongrad')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1118, 14, N'Debrecen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1119, 14, N'Fejer')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1120, 14, N'Gyor-Moson-Sopron')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1121, 14, N'Hajdu-Bihar')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1122, 14, N'Heves')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1123, 14, N'Komarom-Esztergom')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1124, 14, N'Miskolc')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1125, 14, N'Nograd')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1126, 14, N'Pecs')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1127, 14, N'Pest')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1128, 14, N'Somogy')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1129, 14, N'Szabolcs-Szatmar-Bereg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1130, 14, N'Szeged')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1131, 14, N'Jasz-Nagykun-Szolnok')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1132, 14, N'Tolna')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1133, 14, N'Vas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1134, 14, N'Veszprem')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1135, 14, N'Zala')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1136, 14, N'Gyor')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1150, 14, N'Veszprem')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1152, 126, N'Balzers')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1153, 126, N'Eschen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1154, 126, N'Gamprin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1155, 126, N'Mauren')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1156, 126, N'Planken')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1157, 126, N'Ruggell')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1158, 126, N'Schaan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1159, 126, N'Schellenberg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1160, 126, N'Triesen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1161, 126, N'Triesenberg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1162, 126, N'Vaduz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1163, 41, N'Diekirch')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1164, 41, N'Grevenmacher')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1165, 41, N'Luxembourg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1167, 85, N'Aracinovo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1168, 85, N'Bac')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1169, 85, N'Belcista')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1170, 85, N'Berovo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1171, 85, N'Bistrica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1172, 85, N'Bitola')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1173, 85, N'Blatec')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1174, 85, N'Bogdanci')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1175, 85, N'Bogomila')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1176, 85, N'Bogovinje')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1177, 85, N'Bosilovo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1179, 85, N'Cair')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1180, 85, N'Capari')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1181, 85, N'Caska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1182, 85, N'Cegrane')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1184, 85, N'Centar Zupa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1187, 85, N'Debar')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1188, 85, N'Delcevo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1190, 85, N'Demir Hisar')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1191, 85, N'Demir Kapija')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1195, 85, N'Dorce Petrov')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1198, 85, N'Gazi Baba')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1199, 85, N'Gevgelija')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1200, 85, N'Gostivar')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1201, 85, N'Gradsko')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1204, 85, N'Jegunovce')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1205, 85, N'Kamenjane')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1207, 85, N'Karpos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1208, 85, N'Kavadarci')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1209, 85, N'Kicevo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1210, 85, N'Kisela Voda')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1211, 85, N'Klecevce')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1212, 85, N'Kocani')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1214, 85, N'Kondovo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1217, 85, N'Kratovo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1219, 85, N'Krivogastani')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1220, 85, N'Krusevo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1223, 85, N'Kumanovo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1224, 85, N'Labunista')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1225, 85, N'Lipkovo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1228, 85, N'Makedonska Kamenica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1229, 85, N'Makedonski Brod')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1234, 85, N'Murtino')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1235, 85, N'Negotino')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1238, 85, N'Novo Selo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1240, 85, N'Ohrid')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1242, 85, N'Orizari')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1245, 85, N'Petrovec')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1248, 85, N'Prilep')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1249, 85, N'Probistip')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1250, 85, N'Radovis')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1252, 85, N'Resen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1253, 85, N'Rosoman')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1256, 85, N'Saraj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1260, 85, N'Srbinovo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1262, 85, N'Star Dojran')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1264, 85, N'Stip')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1265, 85, N'Struga')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1266, 85, N'Strumica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1267, 85, N'Studenicani')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1268, 85, N'Suto Orizari')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1269, 85, N'Sveti Nikole')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1270, 85, N'Tearce')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1271, 85, N'Tetovo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1273, 85, N'Valandovo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1275, 85, N'Veles')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1277, 85, N'Vevcani')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1278, 85, N'Vinica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1281, 85, N'Vrapciste')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1286, 85, N'Zelino')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1289, 85, N'Zrnovci')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1291, 86, N'Malta')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1292, 44, N'La Condamine')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1293, 44, N'Monaco')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1294, 44, N'Monte-Carlo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1295, 47, N'Biala Podlaska')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1296, 47, N'Bialystok')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1297, 47, N'Bielsko')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1298, 47, N'Bydgoszcz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1299, 47, N'Chelm')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1300, 47, N'Ciechanow')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1301, 47, N'Czestochowa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1302, 47, N'Elblag')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1303, 47, N'Gdansk')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1304, 47, N'Gorzow')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1305, 47, N'Jelenia Gora')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1306, 47, N'Kalisz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1307, 47, N'Katowice')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1308, 47, N'Kielce')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1309, 47, N'Konin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1310, 47, N'Koszalin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1311, 47, N'Krakow')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1312, 47, N'Krosno')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1313, 47, N'Legnica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1314, 47, N'Leszno')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1315, 47, N'Lodz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1316, 47, N'Lomza')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1317, 47, N'Lublin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1318, 47, N'Nowy Sacz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1319, 47, N'Olsztyn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1320, 47, N'Opole')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1321, 47, N'Ostroleka')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1322, 47, N'Pila')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1323, 47, N'Piotrkow')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1324, 47, N'Plock')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1325, 47, N'Poznan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1326, 47, N'Przemysl')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1327, 47, N'Radom')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1328, 47, N'Rzeszow')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1329, 47, N'Siedlce')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1330, 47, N'Sieradz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1331, 47, N'Skierniewice')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1332, 47, N'Slupsk')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1333, 47, N'Suwalki')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1335, 47, N'Tarnobrzeg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1336, 47, N'Tarnow')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1337, 47, N'Torun')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1338, 47, N'Walbrzych')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1339, 47, N'Warszawa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1340, 47, N'Wloclawek')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1341, 47, N'Wroclaw')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1342, 47, N'Zamosc')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1343, 47, N'Zielona Gora')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1344, 47, N'Dolnoslaskie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1345, 47, N'Kujawsko-Pomorskie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1346, 47, N'Lodzkie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1347, 47, N'Lubelskie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1348, 47, N'Lubuskie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1349, 47, N'Malopolskie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1350, 47, N'Mazowieckie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1351, 47, N'Opolskie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1352, 47, N'Podkarpackie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1353, 47, N'Podlaskie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1354, 47, N'Pomorskie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1355, 47, N'Slaskie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1356, 47, N'Swietokrzyskie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1357, 47, N'Warminsko-Mazurskie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1358, 47, N'Wielkopolskie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1359, 47, N'Zachodniopomorskie')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1361, 72, N'Alba')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1362, 72, N'Arad')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1363, 72, N'Arges')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1364, 72, N'Bacau')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1365, 72, N'Bihor')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1366, 72, N'Bistrita-Nasaud')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1367, 72, N'Botosani')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1368, 72, N'Braila')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1369, 72, N'Brasov')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1370, 72, N'Bucuresti')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1371, 72, N'Buzau')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1372, 72, N'Caras-Severin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1373, 72, N'Cluj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1374, 72, N'Constanta')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1375, 72, N'Covasna')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1376, 72, N'Dambovita')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1377, 72, N'Dolj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1378, 72, N'Galati')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1379, 72, N'Gorj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1380, 72, N'Harghita')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1381, 72, N'Hunedoara')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1382, 72, N'Ialomita')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1383, 72, N'Iasi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1384, 72, N'Maramures')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1385, 72, N'Mehedinti')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1386, 72, N'Mures')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1387, 72, N'Neamt')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1388, 72, N'Olt')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1389, 72, N'Prahova')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1390, 72, N'Salaj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1391, 72, N'Satu Mare')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1392, 72, N'Sibiu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1393, 72, N'Suceava')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1394, 72, N'Teleorman')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1395, 72, N'Timis')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1396, 72, N'Tulcea')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1397, 72, N'Vaslui')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1398, 72, N'Valcea')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1399, 72, N'Vrancea')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1400, 72, N'Calarasi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1401, 72, N'Giurgiu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1404, 224, N'Acquaviva')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1405, 224, N'Chiesanuova')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1406, 224, N'Domagnano')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1407, 224, N'Faetano')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1408, 224, N'Fiorentino')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1409, 224, N'Borgo Maggiore')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1410, 224, N'San Marino')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1411, 224, N'Monte Giardino')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1412, 224, N'Serravalle')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1413, 52, N'Banska Bystrica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1414, 52, N'Bratislava')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1415, 52, N'Kosice')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1416, 52, N'Nitra')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1417, 52, N'Presov')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1418, 52, N'Trencin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1419, 52, N'Trnava')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1420, 52, N'Zilina')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1423, 53, N'Beltinci')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1425, 53, N'Bohinj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1426, 53, N'Borovnica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1427, 53, N'Bovec')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1428, 53, N'Brda')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1429, 53, N'Brezice')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1430, 53, N'Brezovica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1432, 53, N'Cerklje na Gorenjskem')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1434, 53, N'Cerkno')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1436, 53, N'Crna na Koroskem')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1437, 53, N'Crnomelj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1438, 53, N'Divaca')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1439, 53, N'Dobrepolje')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1440, 53, N'Dol pri Ljubljani')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1443, 53, N'Duplek')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1447, 53, N'Gornji Grad')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1450, 53, N'Hrastnik')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1451, 53, N'Hrpelje-Kozina')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1452, 53, N'Idrija')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1453, 53, N'Ig')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1454, 53, N'Ilirska Bistrica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1455, 53, N'Ivancna Gorica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1462, 53, N'Komen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1463, 53, N'Koper-Capodistria')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1464, 53, N'Kozje')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1465, 53, N'Kranj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1466, 53, N'Kranjska Gora')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1467, 53, N'Krsko')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1469, 53, N'Lasko')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1470, 53, N'Ljubljana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1471, 53, N'Ljubno')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1472, 53, N'Logatec')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1475, 53, N'Medvode')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1476, 53, N'Menges')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1478, 53, N'Mezica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1480, 53, N'Moravce')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1482, 53, N'Mozirje')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1483, 53, N'Murska Sobota')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1487, 53, N'Nova Gorica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1489, 53, N'Ormoz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1491, 53, N'Pesnica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1494, 53, N'Postojna')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1497, 53, N'Radece')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1498, 53, N'Radenci')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1500, 53, N'Radovljica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1502, 53, N'Rogaska Slatina')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1505, 53, N'Sencur')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1506, 53, N'Sentilj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1508, 53, N'Sevnica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1509, 53, N'Sezana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1511, 53, N'Skofja Loka')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1513, 53, N'Slovenj Gradec')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1514, 53, N'Slovenske Konjice')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1515, 53, N'Smarje pri Jelsah')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1521, 53, N'Tolmin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1522, 53, N'Trbovlje')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1524, 53, N'Trzic')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1526, 53, N'Velenje')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1528, 53, N'Vipava')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1531, 53, N'Vrhnika')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1532, 53, N'Vuzenica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1533, 53, N'Zagorje ob Savi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1535, 53, N'Zelezniki')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1536, 53, N'Ziri')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1537, 53, N'Zrece')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1539, 53, N'Domzale')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1540, 53, N'Jesenice')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1541, 53, N'Kamnik')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1542, 53, N'Kocevje')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1544, 53, N'Lenart')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1545, 53, N'Litija')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1546, 53, N'Ljutomer')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1550, 53, N'Maribor')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1552, 53, N'Novo Mesto')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1553, 53, N'Piran')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1554, 53, N'Preddvor')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1555, 53, N'Ptuj')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1556, 53, N'Ribnica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1558, 53, N'Sentjur pri Celju')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1559, 53, N'Slovenska Bistrica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1560, 53, N'Videm')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1562, 53, N'Zalec')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1564, 109, N'Seychelles')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1565, 108, N'Mauritania')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1566, 135, N'Senegal')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1567, 154, N'Road Town')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1568, 165, N'Congo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1569, 166, N'Avarua')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1570, 172, N'Malabo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1571, 175, N'Torshavn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1572, 178, N'Papeete')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1573, 184, N'St Georges')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1574, 186, N'St Peter Port')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1575, 188, N'Bissau')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1576, 193, N'Saint Helier')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1577, 201, N'Fort-de-France')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1578, 207, N'Willemstad')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1579, 208, N'Noumea')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1580, 212, N'Kingston')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1581, 215, N'Adamstown')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1582, 216, N'Doha')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1583, 218, N'Jamestown')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1584, 219, N'Basseterre')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1585, 220, N'Castries')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1586, 221, N'Saint Pierre')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1587, 222, N'Kingstown')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1588, 225, N'San Tome')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1589, 226, N'Belgrade')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1590, 227, N'Freetown')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1591, 229, N'Mogadishu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1592, 235, N'Fakaofo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1593, 237, N'Port of Spain')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1594, 241, N'Mata-Utu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1596, 89, N'Amazonas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1597, 89, N'Ancash')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1598, 89, N'ApurÌmac')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1599, 89, N'Arequipa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1600, 89, N'Ayacucho')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1601, 89, N'Cajamarca')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1602, 89, N'Callao')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1603, 89, N'Cusco')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1604, 89, N'Huancavelica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1605, 89, N'Hu·nuco')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1606, 89, N'Ica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1607, 89, N'JunÌn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1608, 89, N'La Libertad')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1609, 89, N'Lambayeque')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1610, 89, N'Lima')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1611, 89, N'Loreto')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1612, 89, N'Madre de Dios')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1613, 89, N'Moquegua')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1614, 89, N'Pasco')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1615, 89, N'Piura')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1616, 89, N'Puno')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1617, 89, N'San MartÌn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1618, 89, N'Tacna')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1619, 89, N'Tumbes')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1620, 89, N'Ucayali')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1622, 110, N'Alto Paran·')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1623, 110, N'Amambay')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1624, 110, N'BoquerÛn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1625, 110, N'Caaguaz˙')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1626, 110, N'Caazap·')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1627, 110, N'Central')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1628, 110, N'ConcepciÛn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1629, 110, N'Cordillera')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1630, 110, N'Guair·')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1631, 110, N'Itap˙a')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1632, 110, N'Misiones')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1633, 110, N'Neembuc˙')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1634, 110, N'ParaguarÌ')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1635, 110, N'Presidente Hayes')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1636, 110, N'San Pedro')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1637, 110, N'Alto Paraguay')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1638, 110, N'Canindey˙')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1639, 110, N'Chaco')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1642, 111, N'Artigas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1643, 111, N'Canelones')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1644, 111, N'Cerro Largo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1645, 111, N'Colonia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1646, 111, N'Durazno')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1647, 111, N'Flores')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1648, 111, N'Florida')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1649, 111, N'Lavalleja')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1650, 111, N'Maldonado')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1651, 111, N'Montevideo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1652, 111, N'Paysand˙')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1653, 111, N'RÌo Negro')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1654, 111, N'Rivera')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1655, 111, N'Rocha')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1656, 111, N'Salto')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1657, 111, N'San JosÈ')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1658, 111, N'Soriano')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1659, 111, N'TacuarembÛ')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1660, 111, N'Treinta y Tres')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1662, 81, N'ValparaÌso')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1663, 81, N'AisÈn del General Carlos Ib·nez del Campo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1664, 81, N'Antofagasta')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1665, 81, N'AraucanÌa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1666, 81, N'Atacama')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1667, 81, N'BÌo-BÌo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1668, 81, N'Coquimbo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1669, 81, N'Libertador General Bernardo OHiggins')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1670, 81, N'Los Lagos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1671, 81, N'Magallanes y de la Ant·rtica Chilena')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1672, 81, N'Maule')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1673, 81, N'Region Metropolitana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1674, 81, N'Tarapac·')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1676, 185, N'Alta Verapaz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1677, 185, N'Baja Verapaz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1678, 185, N'Chimaltenango')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1679, 185, N'Chiquimula')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1680, 185, N'El Progreso')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1681, 185, N'Escuintla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1682, 185, N'Guatemala')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1683, 185, N'Huehuetenango')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1684, 185, N'Izabal')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1685, 185, N'Jalapa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1686, 185, N'Jutiapa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1687, 185, N'PetÈn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1688, 185, N'Quetzaltenango')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1689, 185, N'QuichÈ')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1690, 185, N'Retalhuleu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1691, 185, N'SacatepÈquez')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1692, 185, N'San Marcos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1693, 185, N'Santa Rosa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1694, 185, N'Solol·')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1695, 185, N'Suchitepequez')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1696, 185, N'Totonicap·n')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1697, 185, N'Zacapa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1699, 82, N'Amazonas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1700, 82, N'Antioquia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1701, 82, N'Arauca')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1702, 82, N'Atl·ntico')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1703, 82, N'Caquet·')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1704, 82, N'Cauca')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1705, 82, N'CÈsar')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1706, 82, N'ChocÛ')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1707, 82, N'CÛrdoba')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1708, 82, N'Guaviare')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1709, 82, N'GuainÌa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1710, 82, N'Huila')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1711, 82, N'La Guajira')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1712, 82, N'Meta')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1713, 82, N'Narino')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1714, 82, N'Norte de Santander')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1715, 82, N'Putumayo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1716, 82, N'QuindÌo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1717, 82, N'Risaralda')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1718, 82, N'San AndrÈs y Providencia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1719, 82, N'Santander')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1720, 82, N'Sucre')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1721, 82, N'Tolima')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1722, 82, N'Valle del Cauca')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1723, 82, N'VaupÈs')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1724, 82, N'Vichada')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1725, 82, N'Casanare')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1726, 82, N'Cundinamarca')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1727, 82, N'Distrito Capital')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1730, 82, N'Caldas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1731, 82, N'Magdalena')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1733, 42, N'Aguascalientes')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1734, 42, N'Baja California')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1735, 42, N'Baja California Sur')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1736, 42, N'Campeche')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1737, 42, N'Chiapas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1738, 42, N'Chihuahua')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1739, 42, N'Coahuila de Zaragoza')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1740, 42, N'Colima')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1741, 42, N'Distrito Federal')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1742, 42, N'Durango')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1743, 42, N'Guanajuato')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1744, 42, N'Guerrero')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1745, 42, N'Hidalgo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1746, 42, N'Jalisco')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1747, 42, N'MÈxico')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1748, 42, N'Michoac·n de Ocampo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1749, 42, N'Morelos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1750, 42, N'Nayarit')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1751, 42, N'Nuevo LeÛn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1752, 42, N'Oaxaca')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1753, 42, N'Puebla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1754, 42, N'QuerÈtaro de Arteaga')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1755, 42, N'Quintana Roo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1756, 42, N'San Luis PotosÌ')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1757, 42, N'Sinaloa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1758, 42, N'Sonora')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1759, 42, N'Tabasco')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1760, 42, N'Tamaulipas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1761, 42, N'Tlaxcala')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1762, 42, N'Veracruz-Llave')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1763, 42, N'Yucat·n')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1764, 42, N'Zacatecas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1766, 124, N'Bocas del Toro')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1767, 124, N'ChiriquÌ')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1768, 124, N'CoclÈ')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1769, 124, N'ColÛn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1770, 124, N'DariÈn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1771, 124, N'Herrera')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1772, 124, N'Los Santos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1773, 124, N'Panam·')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1774, 124, N'San Blas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1775, 124, N'Veraguas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1777, 123, N'Chuquisaca')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1778, 123, N'Cochabamba')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1779, 123, N'El Beni')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1780, 123, N'La Paz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1781, 123, N'Oruro')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1782, 123, N'Pando')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1783, 123, N'PotosÌ')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1784, 123, N'Santa Cruz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1785, 123, N'Tarija')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1787, 36, N'Alajuela')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1788, 36, N'Cartago')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1789, 36, N'Guanacaste')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1790, 36, N'Heredia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1791, 36, N'LimÛn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1792, 36, N'Puntarenas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1793, 36, N'San JosÈ')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1795, 103, N'Gal·pagos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1796, 103, N'Azuay')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1797, 103, N'BolÌvar')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1798, 103, N'Canar')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1799, 103, N'Carchi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1800, 103, N'Chimborazo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1801, 103, N'Cotopaxi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1802, 103, N'El Oro')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1803, 103, N'Esmeraldas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1804, 103, N'Guayas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1805, 103, N'Imbabura')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1806, 103, N'Loja')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1807, 103, N'Los RÌos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1808, 103, N'ManabÌ')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1809, 103, N'Morona-Santiago')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1810, 103, N'Pastaza')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1811, 103, N'Pichincha')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1812, 103, N'Tungurahua')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1813, 103, N'Zamora-Chinchipe')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1814, 103, N'SucumbÌos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1815, 103, N'Napo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1816, 103, N'Orellana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1818, 5, N'Buenos Aires')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1819, 5, N'Catamarca')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1820, 5, N'Chaco')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1821, 5, N'Chubut')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1822, 5, N'CÛrdoba')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1823, 5, N'Corrientes')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1824, 5, N'Distrito Federal')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1825, 5, N'Entre RÌos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1826, 5, N'Formosa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1827, 5, N'Jujuy')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1828, 5, N'La Pampa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1829, 5, N'La Rioja')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1830, 5, N'Mendoza')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1831, 5, N'Misiones')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1832, 5, N'NeuquÈn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1833, 5, N'RÌo Negro')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1834, 5, N'Salta')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1835, 5, N'San Juan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1836, 5, N'San Luis')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1837, 5, N'Santa Cruz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1838, 5, N'Santa Fe')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1839, 5, N'Santiago del Estero')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1840, 5, N'Tierra del Fuego')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1841, 5, N'Tucum·n')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1843, 95, N'Amazonas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1844, 95, N'Anzoategui')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1845, 95, N'Apure')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1846, 95, N'Aragua')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1847, 95, N'Barinas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1848, 95, N'BolÌvar')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1849, 95, N'Carabobo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1850, 95, N'Cojedes')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1851, 95, N'Delta Amacuro')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1852, 95, N'FalcÛn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1853, 95, N'Gu·rico')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1854, 95, N'Lara')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1855, 95, N'MÈrida')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1856, 95, N'Miranda')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1857, 95, N'Monagas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1858, 95, N'Nueva Esparta')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1859, 95, N'Portuguesa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1860, 95, N'Sucre')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1861, 95, N'T·chira')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1862, 95, N'Trujillo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1863, 95, N'Yaracuy')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1864, 95, N'Zulia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1865, 95, N'Dependencias Federales')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1866, 95, N'Distrito Federal')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1867, 95, N'Vargas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1869, 209, N'Boaco')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1870, 209, N'Carazo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1871, 209, N'Chinandega')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1872, 209, N'Chontales')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1873, 209, N'EstelÌ')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1874, 209, N'Granada')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1875, 209, N'Jinotega')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1876, 209, N'LeÛn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1877, 209, N'Madriz')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1878, 209, N'Managua')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1879, 209, N'Masaya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1880, 209, N'Matagalpa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1881, 209, N'Nueva Segovia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1882, 209, N'Rio San Juan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1883, 209, N'Rivas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1884, 209, N'Zelaya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1886, 113, N'Pinar del Rio')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1887, 113, N'Ciudad de la Habana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1888, 113, N'Matanzas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1889, 113, N'Isla de la Juventud')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1890, 113, N'Camaguey')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1891, 113, N'Ciego de Avila')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1892, 113, N'Cienfuegos')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1893, 113, N'Granma')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1894, 113, N'Guantanamo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1895, 113, N'La Habana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1896, 113, N'Holguin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1897, 113, N'Las Tunas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1898, 113, N'Sancti Spiritus')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1899, 113, N'Santiago de Cuba')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1900, 113, N'Villa Clara')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1901, 12, N'Acre')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1902, 12, N'Alagoas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1903, 12, N'Amapa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1904, 12, N'Amazonas')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1905, 12, N'Bahia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1906, 12, N'Ceara')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1907, 12, N'Distrito Federal')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1908, 12, N'Espirito Santo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1909, 12, N'Mato Grosso do Sul')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1910, 12, N'Maranhao')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1911, 12, N'Mato Grosso')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1912, 12, N'Minas Gerais')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1913, 12, N'Para')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1914, 12, N'Paraiba')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1915, 12, N'Parana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1916, 12, N'Piaui')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1917, 12, N'Rio de Janeiro')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1918, 12, N'Rio Grande do Norte')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1919, 12, N'Rio Grande do Sul')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1920, 12, N'Rondonia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1921, 12, N'Roraima')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1922, 12, N'Santa Catarina')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1923, 12, N'Sao Paulo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1924, 12, N'Sergipe')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1925, 12, N'Goias')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1926, 12, N'Pernambuco')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1927, 12, N'Tocantins')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1930, 83, N'Akureyri')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1931, 83, N'Arnessysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1932, 83, N'Austur-Bardastrandarsysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1933, 83, N'Austur-Hunavatnssysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1934, 83, N'Austur-Skaftafellssysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1935, 83, N'Borgarfjardarsysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1936, 83, N'Dalasysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1937, 83, N'Eyjafjardarsysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1938, 83, N'Gullbringusysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1939, 83, N'Hafnarfjordur')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1943, 83, N'Kjosarsysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1944, 83, N'Kopavogur')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1945, 83, N'Myrasysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1946, 83, N'Neskaupstadur')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1947, 83, N'Nordur-Isafjardarsysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1948, 83, N'Nordur-Mulasysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1949, 83, N'Nordur-Tingeyjarsysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1950, 83, N'Olafsfjordur')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1951, 83, N'Rangarvallasysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1952, 83, N'Reykjavik')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1953, 83, N'Saudarkrokur')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1954, 83, N'Seydisfjordur')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1956, 83, N'Skagafjardarsysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1957, 83, N'Snafellsnes- og Hnappadalssysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1958, 83, N'Strandasysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1959, 83, N'Sudur-Mulasysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1960, 83, N'Sudur-Tingeyjarsysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1961, 83, N'Vestmannaeyjar')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1962, 83, N'Vestur-Bardastrandarsysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1964, 83, N'Vestur-Isafjardarsysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1965, 83, N'Vestur-Skaftafellssysla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1966, 35, N'Anhui')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1967, 35, N'Zhejiang')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1968, 35, N'Jiangxi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1969, 35, N'Jiangsu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1970, 35, N'Jilin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1971, 35, N'Qinghai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1972, 35, N'Fujian')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1973, 35, N'Heilongjiang')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1974, 35, N'Henan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1975, 35, N'Hebei')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1976, 35, N'Hunan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1977, 35, N'Hubei')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1978, 35, N'Xinjiang')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1979, 35, N'Xizang')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1980, 35, N'Gansu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1981, 35, N'Guangxi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1982, 35, N'Guizhou')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1983, 35, N'Liaoning')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1984, 35, N'Nei Mongol')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1985, 35, N'Ningxia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1986, 35, N'Beijing')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1987, 35, N'Shanghai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1988, 35, N'Shanxi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1989, 35, N'Shandong')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1990, 35, N'Shaanxi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1991, 35, N'Sichuan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1992, 35, N'Tianjin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1993, 35, N'Yunnan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1994, 35, N'Guangdong')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1995, 35, N'Hainan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1996, 35, N'Chongqing')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1997, 97, N'Central')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1998, 97, N'Coast')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (1999, 97, N'Eastern')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2000, 97, N'Nairobi Area')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2001, 97, N'North-Eastern')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2002, 97, N'Nyanza')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2003, 97, N'Rift Valley')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2004, 97, N'Western')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2006, 195, N'Gilbert Islands')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2007, 195, N'Line Islands')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2008, 195, N'Phoenix Islands')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2010, 1, N'Australian Capital Territory')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2011, 1, N'New South Wales')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2012, 1, N'Northern Territory')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2013, 1, N'Queensland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2014, 1, N'South Australia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2015, 1, N'Tasmania')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2016, 1, N'Victoria')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2017, 1, N'Western Australia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2018, 27, N'Dublin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2019, 27, N'Galway')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2020, 27, N'Kildare')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2021, 27, N'Leitrim')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2022, 27, N'Limerick')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2023, 27, N'Mayo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2024, 27, N'Meath')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2025, 27, N'Carlow')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2026, 27, N'Kilkenny')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2027, 27, N'Laois')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2028, 27, N'Longford')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2029, 27, N'Louth')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2030, 27, N'Offaly')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2031, 27, N'Westmeath')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2032, 27, N'Wexford')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2033, 27, N'Wicklow')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2034, 27, N'Roscommon')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2035, 27, N'Sligo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2036, 27, N'Clare')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2037, 27, N'Cork')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2038, 27, N'Kerry')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2039, 27, N'Tipperary')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2040, 27, N'Waterford')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2041, 27, N'Cavan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2042, 27, N'Donegal')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2043, 27, N'Monaghan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2044, 50, N'Karachaeva-Cherkesskaya Respublica')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2045, 50, N'Raimirskii (Dolgano-Nenetskii) AO')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2046, 50, N'Respublica Tiva')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2047, 32, N'Newfoundland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2048, 32, N'Nova Scotia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2049, 32, N'Prince Edward Island')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2050, 32, N'New Brunswick')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2051, 32, N'Quebec')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2052, 32, N'Ontario')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2053, 32, N'Manitoba')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2054, 32, N'Saskatchewan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2055, 32, N'Alberta')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2056, 32, N'British Columbia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2057, 32, N'Nunavut')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2058, 32, N'Northwest Territories')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2059, 32, N'Yukon Territory')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2060, 19, N'Drenthe')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2061, 19, N'Friesland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2062, 19, N'Gelderland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2063, 19, N'Groningen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2064, 19, N'Limburg')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2065, 19, N'Noord-Brabant')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2066, 19, N'Noord-Holland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2067, 19, N'Utrecht')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2068, 19, N'Zeeland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2069, 19, N'Zuid-Holland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2071, 19, N'Overijssel')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2072, 19, N'Flevoland')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2073, 138, N'Duarte')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2074, 138, N'Puerto Plata')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2075, 138, N'Valverde')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2076, 138, N'MarÌa Trinidad S·nchez')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2077, 138, N'Azua')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2078, 138, N'Santiago')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2079, 138, N'San CristÛbal')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2080, 138, N'Peravia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2081, 138, N'ElÌas PiÒa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2082, 138, N'Barahona')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2083, 138, N'Monte Plata')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2084, 138, N'Salcedo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2085, 138, N'La Altagracia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2086, 138, N'San Juan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2087, 138, N'MonseÒor Nouel')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2088, 138, N'Monte Cristi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2089, 138, N'Espaillat')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2090, 138, N'S·nchez RamÌrez')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2091, 138, N'La Vega')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2092, 138, N'San Pedro de MacorÌs')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2093, 138, N'Independencia')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2094, 138, N'DajabÛn')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2095, 138, N'Baoruco')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2096, 138, N'El Seibo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2097, 138, N'Hato Mayor')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2098, 138, N'La Romana')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2099, 138, N'Pedernales')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2100, 138, N'Saman·')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2101, 138, N'Santiago RodrÌguez')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2102, 138, N'San JosÈ de Ocoa')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2103, 70, N'Chiba')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2104, 70, N'Ehime')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2105, 70, N'Oita')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2106, 85, N'Skopje')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2108, 35, N'Schanghai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2109, 35, N'Hongkong')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2110, 35, N'Neimenggu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2111, 35, N'Aomen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2112, 92, N'Amnat Charoen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2113, 92, N'Ang Thong')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2114, 92, N'Bangkok')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2115, 92, N'Buri Ram')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2116, 92, N'Chachoengsao')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2117, 92, N'Chai Nat')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2118, 92, N'Chaiyaphum')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2119, 92, N'Chanthaburi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2120, 92, N'Chiang Mai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2121, 92, N'Chiang Rai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2122, 92, N'Chon Buri')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2124, 92, N'Kalasin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2126, 92, N'Kanchanaburi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2127, 92, N'Khon Kaen')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2128, 92, N'Krabi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2129, 92, N'Lampang')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2131, 92, N'Loei')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2132, 92, N'Lop Buri')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2133, 92, N'Mae Hong Son')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2134, 92, N'Maha Sarakham')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2137, 92, N'Nakhon Pathom')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2139, 92, N'Nakhon Ratchasima')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2140, 92, N'Nakhon Sawan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2141, 92, N'Nakhon Si Thammarat')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2143, 92, N'Narathiwat')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2144, 92, N'Nong Bua Lam Phu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2145, 92, N'Nong Khai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2146, 92, N'Nonthaburi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2147, 92, N'Pathum Thani')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2148, 92, N'Pattani')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2149, 92, N'Phangnga')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2150, 92, N'Phatthalung')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2154, 92, N'Phichit')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2155, 92, N'Phitsanulok')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2156, 92, N'Phra Nakhon Si Ayutthaya')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2157, 92, N'Phrae')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2158, 92, N'Phuket')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2159, 92, N'Prachin Buri')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2160, 92, N'Prachuap Khiri Khan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2162, 92, N'Ratchaburi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2163, 92, N'Rayong')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2164, 92, N'Roi Et')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2165, 92, N'Sa Kaeo')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2166, 92, N'Sakon Nakhon')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2167, 92, N'Samut Prakan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2168, 92, N'Samut Sakhon')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2169, 92, N'Samut Songkhran')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2170, 92, N'Saraburi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2172, 92, N'Si Sa Ket')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2173, 92, N'Sing Buri')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2174, 92, N'Songkhla')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2175, 92, N'Sukhothai')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2176, 92, N'Suphan Buri')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2177, 92, N'Surat Thani')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2178, 92, N'Surin')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2180, 92, N'Trang')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2182, 92, N'Ubon Ratchathani')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2183, 92, N'Udon Thani')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2184, 92, N'Uthai Thani')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2185, 92, N'Uttaradit')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2186, 92, N'Yala')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2187, 92, N'Yasothon')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2188, 69, N'Busan')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2189, 69, N'Daegu')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2191, 69, N'Gangwon')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2192, 69, N'Gwangju')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2193, 69, N'Gyeonggi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2194, 69, N'Gyeongsangbuk')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2195, 69, N'Gyeongsangnam')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2196, 69, N'Jeju')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2201, 25, N'Delhi')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2202, 82, N'Bolivar')
GO
INSERT [dbo].[Region] ([reg_id], [reg_pai_id_fk], [reg_nombre]) VALUES (2203, 82, N'Boyac·')
GO
SET IDENTITY_INSERT [dbo].[Servicios] ON 
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (1, N'Degradado', 14, 1, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (2, N'Afeitado', 13, 1, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (3, N'Corte todo con maquina', 11, 1, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (4, N'Corte de pelo', 16, 1, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (5, N'Afeitado & Barba', 23, 1, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (6, N'Afeitado Maquina', 13, 1, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (7, N'Arreglo Barba', 13, 2, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (8, N'Afeitado SPA', 13, 2, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (9, N'Corte Barba con Maquina', 7, 2, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (10, N'Tinte', 20, 3, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (11, N'Tinte Express', 15, 3, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (12, N'DecoloraciÛn', 50, 3, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (13, N'MatÌz', 10, 3, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (14, N'Manicura B·sica', 10, 4, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (15, N'Manicura Rusa', 10, 4, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (16, N'UÒas AcrÌlicas', 10, 4, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (17, N'Manicura Inmesion', 10, 4, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (18, N'DecoraciÛn UÒa', 2, 4, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (19, N'DecoraciÛn Todas las uÒas', 8, 4, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (20, N'Depilacion Cejas', 9, 5, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (21, N'DepilaciÛn Oidos/Entrecejo/Labios', 5, 5, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (22, N'DepilaciÛn Rostro Completo', 25, 5, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (23, N'DepilaciÛn Corporal', 45, 5, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (24, N'Mechas', 45, 5, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (25, N'Pedicura Hombres', 14, 7, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (26, N'Pedicura Mujeres', 14, 7, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (27, N'Pedicura Express', 20, 7, NULL)
GO
INSERT [dbo].[Servicios] ([ser_id], [ser_nombre], [ser_precio], [ser_cat_id_fk], [ser_pelu_id_fk]) VALUES (28, N'Pedicura Completa SPA', 45, 7, NULL)
GO
SET IDENTITY_INSERT [dbo].[Servicios] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__GrupoPel__ADAA2AD8BE986EE3]    Script Date: 27/08/2024 14:56:21 ******/
ALTER TABLE [dbo].[GrupoPeluqueria] ADD UNIQUE NONCLUSTERED 
(
	[gp_correo_electronico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Peluquer__907ECF15D7B2F5C4]    Script Date: 27/08/2024 14:56:21 ******/
ALTER TABLE [dbo].[Peluqueria] ADD UNIQUE NONCLUSTERED 
(
	[pelu_correo_electronico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Peluquer__FFC2E04F1E3C6922]    Script Date: 27/08/2024 14:56:21 ******/
ALTER TABLE [dbo].[Peluquero] ADD UNIQUE NONCLUSTERED 
(
	[pel_correo_electronico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuarios__522F2963D0438C29]    Script Date: 27/08/2024 14:56:21 ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[usu_correo_electronico] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Peluquero] ADD  DEFAULT (NULL) FOR [pel_instagram]
GO
ALTER TABLE [dbo].[Citas]  WITH CHECK ADD FOREIGN KEY([cita_hora_id_fk])
REFERENCES [dbo].[Horarios] ([hora_id])
GO
ALTER TABLE [dbo].[Citas]  WITH CHECK ADD FOREIGN KEY([cita_pel_id_fk])
REFERENCES [dbo].[Peluquero] ([pel_id])
GO
ALTER TABLE [dbo].[Citas]  WITH CHECK ADD FOREIGN KEY([cita_pelu_id_fk])
REFERENCES [dbo].[Peluqueria] ([pelu_id])
GO
ALTER TABLE [dbo].[Citas]  WITH CHECK ADD FOREIGN KEY([cita_usu_id_fk])
REFERENCES [dbo].[Usuarios] ([usu_id])
GO
ALTER TABLE [dbo].[CitasServicios]  WITH CHECK ADD FOREIGN KEY([citas_ser_cita_id_fk])
REFERENCES [dbo].[Citas] ([cita_id])
GO
ALTER TABLE [dbo].[CitasServicios]  WITH CHECK ADD FOREIGN KEY([citas_ser_ser_id])
REFERENCES [dbo].[Servicios] ([ser_id])
GO
ALTER TABLE [dbo].[Peluqueria]  WITH CHECK ADD FOREIGN KEY([pelu_gp_id_fk])
REFERENCES [dbo].[GrupoPeluqueria] ([gp_id])
GO
ALTER TABLE [dbo].[PeluqueriaHorarios]  WITH CHECK ADD FOREIGN KEY([pelu_hora_pelu_id_fk])
REFERENCES [dbo].[Peluqueria] ([pelu_id])
GO
ALTER TABLE [dbo].[PeluqueriaHorarios]  WITH CHECK ADD FOREIGN KEY([pelu_hora_hora_id_fk])
REFERENCES [dbo].[Horarios] ([hora_id])
GO
ALTER TABLE [dbo].[PeluqueriaServicios]  WITH CHECK ADD FOREIGN KEY([pelu_ser_pelu_id_fk])
REFERENCES [dbo].[Peluqueria] ([pelu_id])
GO
ALTER TABLE [dbo].[PeluqueriaServicios]  WITH CHECK ADD FOREIGN KEY([pelu_ser_ser_id_fk])
REFERENCES [dbo].[Servicios] ([ser_id])
GO
ALTER TABLE [dbo].[Peluquero]  WITH CHECK ADD FOREIGN KEY([pel_grupo_id_fk])
REFERENCES [dbo].[GrupoPeluqueria] ([gp_id])
GO
ALTER TABLE [dbo].[Peluquero]  WITH CHECK ADD FOREIGN KEY([pel_pelu_id_fk])
REFERENCES [dbo].[Peluqueria] ([pelu_id])
GO
ALTER TABLE [dbo].[Region]  WITH CHECK ADD FOREIGN KEY([reg_pai_id_fk])
REFERENCES [dbo].[Paises] ([pai_id])
GO
ALTER TABLE [dbo].[Servicios]  WITH CHECK ADD FOREIGN KEY([ser_cat_id_fk])
REFERENCES [dbo].[Categoria] ([cat_id])
GO
ALTER TABLE [dbo].[Servicios]  WITH CHECK ADD FOREIGN KEY([ser_pelu_id_fk])
REFERENCES [dbo].[Peluqueria] ([pelu_id])
GO
USE [master]
GO
ALTER DATABASE [MyReserve] SET  READ_WRITE 
GO
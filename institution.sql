USE [master]
GO
/****** Object:  Database [Institutiondb]    Script Date: 19/09/2023 4:37:04 p. m. ******/
CREATE DATABASE [Institutiondb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Institutiondb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Institutiondb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Institutiondb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Institutiondb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Institutiondb] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Institutiondb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Institutiondb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Institutiondb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Institutiondb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Institutiondb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Institutiondb] SET ARITHABORT OFF 
GO
ALTER DATABASE [Institutiondb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Institutiondb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Institutiondb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Institutiondb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Institutiondb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Institutiondb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Institutiondb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Institutiondb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Institutiondb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Institutiondb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Institutiondb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Institutiondb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Institutiondb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Institutiondb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Institutiondb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Institutiondb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Institutiondb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Institutiondb] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Institutiondb] SET  MULTI_USER 
GO
ALTER DATABASE [Institutiondb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Institutiondb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Institutiondb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Institutiondb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Institutiondb] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Institutiondb] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Institutiondb] SET QUERY_STORE = ON
GO
ALTER DATABASE [Institutiondb] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Institutiondb]
GO
/****** Object:  Table [dbo].[Enrollment]    Script Date: 19/09/2023 4:37:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollment](
	[EnrollmentID] [int] NOT NULL,
	[CourseID] [int] NOT NULL,
	[StudentID] [int] NOT NULL,
	[Grade] [int] NOT NULL,
 CONSTRAINT [PK_Enrollment] PRIMARY KEY CLUSTERED 
(
	[EnrollmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 19/09/2023 4:37:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[ID] [int] NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[FirstMidName] [varchar](50) NOT NULL,
	[EnrollmentDate] [date] NOT NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vSubscribedStudents]    Script Date: 19/09/2023 4:37:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vSubscribedStudents]
AS
     SELECT enr.CourseID, enr.StudentID, st.FirstMidName, st.LastName 
			From Enrollment enr
     INNER JOIN Student st
	 on st.ID=enr.StudentID
	 WHERE CourseID= '2'
GO
/****** Object:  Table [dbo].[Course]    Script Date: 19/09/2023 4:37:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseID] [int] NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[Credits] [int] NOT NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseInstructor]    Script Date: 19/09/2023 4:37:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseInstructor](
	[ID] [int] NOT NULL,
	[CourseID] [int] NOT NULL,
	[InstructorID] [int] NOT NULL,
 CONSTRAINT [PK_CourseInstructor] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 19/09/2023 4:37:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Budget] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[InstructorID] [int] NOT NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 19/09/2023 4:37:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[ID] [int] NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[FirstMidName] [varchar](50) NOT NULL,
	[HireDate] [date] NOT NULL,
 CONSTRAINT [PK_Instructor] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OfficeAssignment]    Script Date: 19/09/2023 4:37:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OfficeAssignment](
	[InstructorID] [int] NOT NULL,
	[Location] [varchar](50) NOT NULL,
 CONSTRAINT [PK_OfficeAssignment] PRIMARY KEY CLUSTERED 
(
	[InstructorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Course] ([CourseID], [Title], [Credits]) VALUES (1, N'Biologia', 8)
INSERT [dbo].[Course] ([CourseID], [Title], [Credits]) VALUES (2, N'Fisica', 6)
INSERT [dbo].[Course] ([CourseID], [Title], [Credits]) VALUES (3, N'Quimica', 4)
INSERT [dbo].[Course] ([CourseID], [Title], [Credits]) VALUES (4, N'Electiva', 2)
GO
INSERT [dbo].[CourseInstructor] ([ID], [CourseID], [InstructorID]) VALUES (1, 1, 10023384)
INSERT [dbo].[CourseInstructor] ([ID], [CourseID], [InstructorID]) VALUES (2, 2, 20088445)
INSERT [dbo].[CourseInstructor] ([ID], [CourseID], [InstructorID]) VALUES (3, 3, 30098965)
INSERT [dbo].[CourseInstructor] ([ID], [CourseID], [InstructorID]) VALUES (4, 4, 60078967)
GO
INSERT [dbo].[Department] ([DepartmentID], [Name], [Budget], [StartDate], [InstructorID]) VALUES (1, N'Departamento de Biologia', 10000, CAST(N'2016-04-23' AS Date), 10023384)
INSERT [dbo].[Department] ([DepartmentID], [Name], [Budget], [StartDate], [InstructorID]) VALUES (2, N'Departamento de Fisica', 24000, CAST(N'2016-06-24' AS Date), 20088445)
INSERT [dbo].[Department] ([DepartmentID], [Name], [Budget], [StartDate], [InstructorID]) VALUES (3, N'Departamento de Quimica', 30000, CAST(N'2016-04-23' AS Date), 30098965)
INSERT [dbo].[Department] ([DepartmentID], [Name], [Budget], [StartDate], [InstructorID]) VALUES (4, N'Departamento de Electivas', 40000, CAST(N'2018-05-23' AS Date), 60078967)
GO
INSERT [dbo].[Enrollment] ([EnrollmentID], [CourseID], [StudentID], [Grade]) VALUES (1, 4, 10987879, 11)
INSERT [dbo].[Enrollment] ([EnrollmentID], [CourseID], [StudentID], [Grade]) VALUES (2, 3, 65455532, 9)
INSERT [dbo].[Enrollment] ([EnrollmentID], [CourseID], [StudentID], [Grade]) VALUES (3, 2, 34098654, 8)
INSERT [dbo].[Enrollment] ([EnrollmentID], [CourseID], [StudentID], [Grade]) VALUES (4, 1, 22122555, 10)
INSERT [dbo].[Enrollment] ([EnrollmentID], [CourseID], [StudentID], [Grade]) VALUES (5, 2, 12131415, 11)
GO
INSERT [dbo].[Instructor] ([ID], [LastName], [FirstMidName], [HireDate]) VALUES (10023384, N'Bukowski', N'Charles', CAST(N'2012-07-23' AS Date))
INSERT [dbo].[Instructor] ([ID], [LastName], [FirstMidName], [HireDate]) VALUES (20088445, N'García Lorca', N'Federico', CAST(N'2018-04-13' AS Date))
INSERT [dbo].[Instructor] ([ID], [LastName], [FirstMidName], [HireDate]) VALUES (30098965, N'Benedetti', N'Mario', CAST(N'2015-02-02' AS Date))
INSERT [dbo].[Instructor] ([ID], [LastName], [FirstMidName], [HireDate]) VALUES (60078967, N'Vallejo', N'Cesar', CAST(N'2010-06-24' AS Date))
GO
INSERT [dbo].[OfficeAssignment] ([InstructorID], [Location]) VALUES (10023384, N'Buenos Aires')
INSERT [dbo].[OfficeAssignment] ([InstructorID], [Location]) VALUES (20088445, N'Bogotá')
INSERT [dbo].[OfficeAssignment] ([InstructorID], [Location]) VALUES (30098965, N'New York')
INSERT [dbo].[OfficeAssignment] ([InstructorID], [Location]) VALUES (60078967, N'Shangai')
GO
INSERT [dbo].[Student] ([ID], [LastName], [FirstMidName], [EnrollmentDate]) VALUES (10987879, N'Jackson', N'Michael', CAST(N'2023-11-02' AS Date))
INSERT [dbo].[Student] ([ID], [LastName], [FirstMidName], [EnrollmentDate]) VALUES (12131415, N'Perez', N'Juan', CAST(N'2016-04-23' AS Date))
INSERT [dbo].[Student] ([ID], [LastName], [FirstMidName], [EnrollmentDate]) VALUES (22122555, N'Shakespeare', N'William', CAST(N'2023-04-23' AS Date))
INSERT [dbo].[Student] ([ID], [LastName], [FirstMidName], [EnrollmentDate]) VALUES (34098654, N'Whitman', N'Walt', CAST(N'2016-04-23' AS Date))
INSERT [dbo].[Student] ([ID], [LastName], [FirstMidName], [EnrollmentDate]) VALUES (65455532, N'Neruda', N'Pablo', CAST(N'2016-02-01' AS Date))
GO
ALTER TABLE [dbo].[CourseInstructor]  WITH CHECK ADD  CONSTRAINT [FK_CourseInstructor_Course] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
ALTER TABLE [dbo].[CourseInstructor] CHECK CONSTRAINT [FK_CourseInstructor_Course]
GO
ALTER TABLE [dbo].[CourseInstructor]  WITH CHECK ADD  CONSTRAINT [FK_CourseInstructor_Instructor] FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructor] ([ID])
GO
ALTER TABLE [dbo].[CourseInstructor] CHECK CONSTRAINT [FK_CourseInstructor_Instructor]
GO
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_Instructor] FOREIGN KEY([InstructorID])
REFERENCES [dbo].[Instructor] ([ID])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK_Department_Instructor]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_Course] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_Enrollment_Course]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_Student] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([ID])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_Enrollment_Student]
GO
ALTER TABLE [dbo].[Instructor]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_OfficeAssignment] FOREIGN KEY([ID])
REFERENCES [dbo].[OfficeAssignment] ([InstructorID])
GO
ALTER TABLE [dbo].[Instructor] CHECK CONSTRAINT [FK_Instructor_OfficeAssignment]
GO
/****** Object:  StoredProcedure [dbo].[pr_numberOfStudents]    Script Date: 19/09/2023 4:37:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pr_numberOfStudents](@curso INT)
AS
BEGIN 
    SELECT enr.CourseID, enr.StudentID, st.FirstMidName, st.LastName 
			From Enrollment enr
     INNER JOIN Student st
	 on st.ID=enr.StudentID
	 WHERE CourseID= @curso
END
GO
USE [master]
GO
ALTER DATABASE [Institutiondb] SET  READ_WRITE 
GO

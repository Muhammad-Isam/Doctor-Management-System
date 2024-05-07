GO
/****** Object:  Database [HospitalManagementSystem]    Script Date: 5/2/2024 7:03:51 PM ******/
CREATE DATABASE [HospitalManagementSystem]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HospitalManagementSystem', FILENAME = N'E:\SQLDATA\HospitalManagementSystem.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HospitalManagementSystem_log', FILENAME = N'E:\SQLDATA\HospitalManagementSystem_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [HospitalManagementSystem] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HospitalManagementSystem].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HospitalManagementSystem] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET ARITHABORT OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HospitalManagementSystem] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HospitalManagementSystem] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HospitalManagementSystem] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HospitalManagementSystem] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET RECOVERY FULL 
GO
ALTER DATABASE [HospitalManagementSystem] SET  MULTI_USER 
GO
ALTER DATABASE [HospitalManagementSystem] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HospitalManagementSystem] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HospitalManagementSystem] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HospitalManagementSystem] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HospitalManagementSystem] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HospitalManagementSystem] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'HospitalManagementSystem', N'ON'
GO
ALTER DATABASE [HospitalManagementSystem] SET QUERY_STORE = ON
GO
ALTER DATABASE [HospitalManagementSystem] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [HospitalManagementSystem]
GO
/****** Object:  Table [dbo].[Admin]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Admin](
	[AdminID] [int] IDENTITY(1,1) NOT NULL,
	[AdminName] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[Password] [varchar](100) NULL,
	[Contact] [varchar](20) NULL,
	[Role] [varchar](50) NULL,
	[Permission] [varchar](max) NULL,
	[LastLogin] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AdminID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ambulance]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ambulance](
	[AmbulanceID] [int] IDENTITY(1,1) NOT NULL,
	[Model] [varchar](255) NULL,
	[NumberPlate] [varchar](50) NULL,
	[Description] [varchar](255) NULL,
	[IsAvailable] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[AmbulanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AmbulanceRequest]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AmbulanceRequest](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[AmbulanceID] [int] NULL,
	[CallID] [int] NULL,
	[DispatchTime] [datetime] NULL,
	[ReturnTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Appointment]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointment](
	[AppointmentID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NULL,
	[DoctorID] [int] NULL,
	[Date] [date] NULL,
	[Time] [time](7) NULL,
	[Status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[AppointmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Control]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Control](
	[ActionID] [int] IDENTITY(1,1) NOT NULL,
	[ActionType] [varchar](50) NULL,
	[Description] [varchar](max) NULL,
	[Timestamp] [datetime] NULL,
	[AdminID] [int] NULL,
	[Details] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[ActionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Department](
	[DeptID] [int] IDENTITY(1,1) NOT NULL,
	[DeptName] [varchar](100) NULL,
	[DeptContact] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[DeptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DepartmentHead]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DepartmentHead](
	[DeptID] [int] NOT NULL,
	[HOD] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DeptID] ASC,
	[HOD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Diagnosis]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Diagnosis](
	[DiagnosisID] [int] IDENTITY(1,1) NOT NULL,
	[DiagnosisName] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[DiagnosisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor](
	[DoctorID] [int] IDENTITY(1,1) NOT NULL,
	[DeptID] [int] NULL,
	[Specialization] [varchar](100) NULL,
	[Status] [varchar](20) NULL,
	[OPDCharges] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DoctorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DoctorFeeBilling]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoctorFeeBilling](
	[BillingID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NULL,
	[DoctorID] [int] NULL,
	[AppointmentID] [int] NULL,
	[Date] [date] NULL,
	[TotalAmount] [decimal](10, 2) NULL,
	[PaymentMethod] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BillingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DoctorShift]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DoctorShift](
	[ShiftID] [int] IDENTITY(1,1) NOT NULL,
	[DoctorID] [int] NULL,
	[StartTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[Day] [varchar](20) NULL,
	[Placement] [varchar](100) NULL,
	[RoomNo] [varchar](50) NULL,
	[AppointmentsLimit] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ShiftID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmergencyCall]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmergencyCall](
	[CallID] [int] IDENTITY(1,1) NOT NULL,
	[CallerName] [varchar](255) NULL,
	[ContactNumber] [varchar](20) NULL,
	[Description] [varchar](255) NULL,
	[Location] [varchar](255) NULL,
	[Timestamp] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmpID] [int] IDENTITY(1,1) NOT NULL,
	[EmpName] [varchar](100) NULL,
	[DOB] [date] NULL,
	[Gender] [char](1) NULL,
	[Contact] [varchar](20) NULL,
	[Address] [varchar](255) NULL,
	[JobTitle] [varchar](100) NULL,
	[DeptID] [int] NULL,
	[Email] [varchar](100) NULL,
	[Password] [varchar](100) NULL,
	[DOJ] [date] NULL,
	[Salary] [decimal](10, 2) NULL,
	[Status] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[FeedbackID] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentID] [int] NULL,
	[Rating] [int] NULL,
	[Comments] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[FeedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[InventoryID] [int] IDENTITY(1,1) NOT NULL,
	[MedicineID] [int] NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Issue]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Issue](
	[IssueID] [int] IDENTITY(1,1) NOT NULL,
	[DeptID] [int] NULL,
	[EmpID] [int] NULL,
	[CreationDate] [date] NULL,
	[Condition] [varchar](max) NULL,
	[Category] [varchar](50) NULL,
	[Content] [varchar](max) NULL,
	[Status] [varchar](20) NULL,
	[Remarks] [varchar](max) NULL,
	[ResolvedBy] [int] NULL,
	[CompetitionDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[IssueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LabInvoices]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LabInvoices](
	[InvoiceID] [int] IDENTITY(1,1) NOT NULL,
	[Timestamp] [datetime] NULL,
	[Amount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LabResults]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LabResults](
	[SampleID] [int] NOT NULL,
	[FieldID] [int] NOT NULL,
	[FieldResult] [varchar](max) NULL,
	[Timestamp] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SampleID] ASC,
	[FieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manufacturer]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturer](
	[ManufacturerID] [int] IDENTITY(1,1) NOT NULL,
	[ManufacturerName] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[Address] [varchar](255) NULL,
	[Contact] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ManufacturerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ManufacturerMedicine]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ManufacturerMedicine](
	[ManufacturerID] [int] NOT NULL,
	[MedicineID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ManufacturerID] ASC,
	[MedicineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedBilling]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedBilling](
	[BillingID] [int] IDENTITY(1,1) NOT NULL,
	[PrescriptionID] [int] NULL,
	[Date] [date] NULL,
	[TotalAmount] [decimal](10, 2) NULL,
	[PaymentMethod] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BillingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedicalHistory]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedicalHistory](
	[MedicalHistoryID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NULL,
	[Diagnosis] [varchar](max) NULL,
	[TreatmentHistory] [varchar](max) NULL,
	[Allergies] [varchar](max) NULL,
	[PreviousSurgeries] [varchar](max) NULL,
	[FamilyHistory] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[MedicalHistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Medicine]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Medicine](
	[MedicineID] [int] IDENTITY(1,1) NOT NULL,
	[MedicineName] [varchar](100) NULL,
	[ManufacturerID] [int] NULL,
	[Category] [varchar](50) NULL,
	[ManufacturingDate] [date] NULL,
	[ExpiryDate] [date] NULL,
	[PricePerUnit] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[MedicineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MedStock]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MedStock](
	[StockID] [int] IDENTITY(1,1) NOT NULL,
	[MedicineID] [int] NULL,
	[SupplierID] [int] NULL,
	[PurchaseDate] [date] NULL,
	[Quantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[PatientID] [int] IDENTITY(1,1) NOT NULL,
	[PatientName] [varchar](100) NULL,
	[DOB] [date] NULL,
	[Gender] [char](1) NULL,
	[Contact] [varchar](20) NULL,
	[Address] [varchar](255) NULL,
	[Email] [varchar](100) NULL,
	[Password] [varchar](100) NULL,
	[Status] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PatientsInER]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientsInER](
	[PatientID] [int] IDENTITY(1,1) NOT NULL,
	[RequestID] [int] NULL,
	[Status] [varchar](50) NULL,
	[Triage] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PatientsInERHistory]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientsInERHistory](
	[PatientID] [int] NULL,
	[Timestamp] [datetime] NULL,
	[Description] [varchar](255) NULL,
	[Status] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PatientTest]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PatientTest](
	[PrescriptionID] [int] NOT NULL,
	[TestID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PrescriptionID] ASC,
	[TestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pharmacist]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pharmacist](
	[EmpID] [int] NOT NULL,
	[ExperienceLevel] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prescription]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prescription](
	[PrescriptionID] [int] IDENTITY(1,1) NOT NULL,
	[AppointmentID] [int] NULL,
	[DiagnosisID] [int] NULL,
	[ClinicalNotes] [varchar](max) NULL,
	[Status] [varchar](20) NULL,
	[Date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[PrescriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrescriptionDiagnosis]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrescriptionDiagnosis](
	[PrescriptionID] [int] NOT NULL,
	[DiagnosisID] [int] NOT NULL,
	[Date] [date] NULL,
	[Description] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[PrescriptionID] ASC,
	[DiagnosisID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PrescriptionMedicine]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PrescriptionMedicine](
	[PrescriptionID] [int] NOT NULL,
	[MedicineID] [int] NOT NULL,
	[Frequency] [varchar](50) NULL,
	[Quantity] [int] NULL,
	[Dosage] [varchar](100) NULL,
	[Instructions] [varchar](max) NULL,
	[MedicineDuration] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PrescriptionID] ASC,
	[MedicineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[ReportID] [int] IDENTITY(1,1) NOT NULL,
	[ReportName] [varchar](100) NULL,
	[Description] [varchar](max) NULL,
	[GeneratedBy] [int] NULL,
	[Timestamp] [datetime] NULL,
	[Format] [varchar](50) NULL,
	[DeptID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Samples]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Samples](
	[SampleID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[SampleShift] [varchar](50) NULL,
	[Timestamp] [datetime] NULL,
	[Volume] [int] NULL,
	[StorageCondition] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[SampleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[Supplier_Name] [varchar](100) NULL,
	[Contact_Number] [varchar](20) NULL,
	[Address] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestCountAndStatus]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestCountAndStatus](
	[OrderID] [int] NOT NULL,
	[TestID] [int] NOT NULL,
	[Status] [varchar](20) NULL,
	[SampleID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[TestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestFields]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestFields](
	[FieldID] [int] IDENTITY(1,1) NOT NULL,
	[FieldName] [varchar](100) NULL,
	[NormalRange] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[FieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestFieldsBridge]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestFieldsBridge](
	[TestID] [int] NOT NULL,
	[FieldID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TestID] ASC,
	[FieldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestOrders]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestOrders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[PrescriptionID] [int] NULL,
	[InvoiceID] [int] NULL,
	[Timestamp] [datetime] NULL,
	[collection_time] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TestRequirements]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TestRequirements](
	[RequirementID] [int] IDENTITY(1,1) NOT NULL,
	[TestID] [int] NULL,
	[RequirementName] [varchar](100) NULL,
	[Description] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[RequirementID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TotalLabTest]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TotalLabTest](
	[TestID] [int] IDENTITY(1,1) NOT NULL,
	[Testname] [varchar](100) NULL,
	[ProcessingTime] [int] NULL,
	[Cost] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[TestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VitalSigns]    Script Date: 5/2/2024 7:03:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VitalSigns](
	[VitalID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NULL,
	[Temperature] [decimal](5, 2) NULL,
	[BloodPressure] [varchar](20) NULL,
	[HeartRate] [int] NULL,
	[BloodSugar] [decimal](5, 2) NULL,
	[BloodOxygen] [decimal](5, 2) NULL,
	[Timestamp] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[VitalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Admin] ON 

INSERT [dbo].[Admin] ([AdminID], [AdminName], [Email], [Password], [Contact], [Role], [Permission], [LastLogin]) VALUES (1, N'Admin1', N'admin1@example.com', N'admin123', N'0300-1112223', N'Super Admin', N'All', CAST(N'2024-04-30T10:00:00.000' AS DateTime))
INSERT [dbo].[Admin] ([AdminID], [AdminName], [Email], [Password], [Contact], [Role], [Permission], [LastLogin]) VALUES (2, N'Admin2', N'admin2@example.com', N'admin456', N'0311-2233344', N'Admin', N'Limited', CAST(N'2024-04-29T09:30:00.000' AS DateTime))
INSERT [dbo].[Admin] ([AdminID], [AdminName], [Email], [Password], [Contact], [Role], [Permission], [LastLogin]) VALUES (3, N'Admin3', N'admin3@example.com', N'admin789', N'0321-3344556', N'Admin', N'Limited', CAST(N'2024-04-28T08:45:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Admin] OFF
GO
SET IDENTITY_INSERT [dbo].[Ambulance] ON 

INSERT [dbo].[Ambulance] ([AmbulanceID], [Model], [NumberPlate], [Description], [IsAvailable]) VALUES (1, N'Toyota Hiace', N'LEA-1234', N'Standard ambulance for patient transport', 1)
INSERT [dbo].[Ambulance] ([AmbulanceID], [Model], [NumberPlate], [Description], [IsAvailable]) VALUES (2, N'Suzuki Bolan', N'ABC-5678', N'Compact ambulance for emergency response', 1)
INSERT [dbo].[Ambulance] ([AmbulanceID], [Model], [NumberPlate], [Description], [IsAvailable]) VALUES (3, N'Honda Civic', N'XYZ-9876', N'Emergency response vehicle equipped with medical supplies', 0)
SET IDENTITY_INSERT [dbo].[Ambulance] OFF
GO
SET IDENTITY_INSERT [dbo].[AmbulanceRequest] ON 

INSERT [dbo].[AmbulanceRequest] ([RequestID], [AmbulanceID], [CallID], [DispatchTime], [ReturnTime]) VALUES (1, 1, 1, CAST(N'2024-04-30T09:30:00.000' AS DateTime), CAST(N'2024-04-30T10:15:00.000' AS DateTime))
INSERT [dbo].[AmbulanceRequest] ([RequestID], [AmbulanceID], [CallID], [DispatchTime], [ReturnTime]) VALUES (2, 2, 2, CAST(N'2024-04-30T10:45:00.000' AS DateTime), CAST(N'2024-04-30T11:30:00.000' AS DateTime))
INSERT [dbo].[AmbulanceRequest] ([RequestID], [AmbulanceID], [CallID], [DispatchTime], [ReturnTime]) VALUES (3, 3, 3, CAST(N'2024-04-30T12:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[AmbulanceRequest] OFF
GO
SET IDENTITY_INSERT [dbo].[Appointment] ON 

INSERT [dbo].[Appointment] ([AppointmentID], [PatientID], [DoctorID], [Date], [Time], [Status]) VALUES (1, 1, 1, CAST(N'2024-05-01' AS Date), CAST(N'09:00:00' AS Time), N'Confirmed')
INSERT [dbo].[Appointment] ([AppointmentID], [PatientID], [DoctorID], [Date], [Time], [Status]) VALUES (2, 2, 2, CAST(N'2024-05-02' AS Date), CAST(N'10:00:00' AS Time), N'Confirmed')
INSERT [dbo].[Appointment] ([AppointmentID], [PatientID], [DoctorID], [Date], [Time], [Status]) VALUES (3, 3, 3, CAST(N'2024-05-03' AS Date), CAST(N'11:00:00' AS Time), N'Confirmed')
SET IDENTITY_INSERT [dbo].[Appointment] OFF
GO
SET IDENTITY_INSERT [dbo].[Control] ON 

INSERT [dbo].[Control] ([ActionID], [ActionType], [Description], [Timestamp], [AdminID], [Details]) VALUES (1, N'Issue Resolution', N'Resolved the issue with the MRI machine.', CAST(N'2024-05-01T12:00:00.000' AS DateTime), 1, N'Technician replaced faulty parts.')
INSERT [dbo].[Control] ([ActionID], [ActionType], [Description], [Timestamp], [AdminID], [Details]) VALUES (2, N'Inventory Update', N'Restocked medications for neurology department.', CAST(N'2024-05-02T11:30:00.000' AS DateTime), 2, N'Supplier delivered additional stock.')
INSERT [dbo].[Control] ([ActionID], [ActionType], [Description], [Timestamp], [AdminID], [Details]) VALUES (3, N'Facility Maintenance', N'Fixed leaking pipes in the surgery ward.', CAST(N'2024-04-30T15:45:00.000' AS DateTime), 3, N'Plumber repaired the pipes.')
SET IDENTITY_INSERT [dbo].[Control] OFF
GO
SET IDENTITY_INSERT [dbo].[Department] ON 

INSERT [dbo].[Department] ([DeptID], [DeptName], [DeptContact]) VALUES (1, N'Cardiology', N'0312-3456789')
INSERT [dbo].[Department] ([DeptID], [DeptName], [DeptContact]) VALUES (2, N'Neurology', N'0333-4567890')
INSERT [dbo].[Department] ([DeptID], [DeptName], [DeptContact]) VALUES (3, N'Orthopedics', N'0344-5678901')
SET IDENTITY_INSERT [dbo].[Department] OFF
GO
INSERT [dbo].[DepartmentHead] ([DeptID], [HOD]) VALUES (1, 1)
INSERT [dbo].[DepartmentHead] ([DeptID], [HOD]) VALUES (2, 2)
INSERT [dbo].[DepartmentHead] ([DeptID], [HOD]) VALUES (3, 3)
GO
SET IDENTITY_INSERT [dbo].[Diagnosis] ON 

INSERT [dbo].[Diagnosis] ([DiagnosisID], [DiagnosisName]) VALUES (1, N'Hypertension')
INSERT [dbo].[Diagnosis] ([DiagnosisID], [DiagnosisName]) VALUES (2, N'Stroke')
INSERT [dbo].[Diagnosis] ([DiagnosisID], [DiagnosisName]) VALUES (3, N'Fracture')
SET IDENTITY_INSERT [dbo].[Diagnosis] OFF
GO
SET IDENTITY_INSERT [dbo].[Doctor] ON 

INSERT [dbo].[Doctor] ([DoctorID], [DeptID], [Specialization], [Status], [OPDCharges]) VALUES (1, 1, N'Cardiologist', N'Fulltime', 500)
INSERT [dbo].[Doctor] ([DoctorID], [DeptID], [Specialization], [Status], [OPDCharges]) VALUES (2, 2, N'Neurologist', N'Visiting', 1000)
INSERT [dbo].[Doctor] ([DoctorID], [DeptID], [Specialization], [Status], [OPDCharges]) VALUES (3, 3, N'Orthopedic Surgeon', N'Fulltime', 1500)
SET IDENTITY_INSERT [dbo].[Doctor] OFF
GO
SET IDENTITY_INSERT [dbo].[DoctorFeeBilling] ON 

INSERT [dbo].[DoctorFeeBilling] ([BillingID], [PatientID], [DoctorID], [AppointmentID], [Date], [TotalAmount], [PaymentMethod]) VALUES (1, 1, 1, 1, CAST(N'2024-05-01' AS Date), CAST(500.00 AS Decimal(10, 2)), N'Cash')
INSERT [dbo].[DoctorFeeBilling] ([BillingID], [PatientID], [DoctorID], [AppointmentID], [Date], [TotalAmount], [PaymentMethod]) VALUES (2, 2, 2, 2, CAST(N'2024-05-02' AS Date), CAST(600.00 AS Decimal(10, 2)), N'Credit Card')
INSERT [dbo].[DoctorFeeBilling] ([BillingID], [PatientID], [DoctorID], [AppointmentID], [Date], [TotalAmount], [PaymentMethod]) VALUES (3, 3, 3, 3, CAST(N'2024-05-03' AS Date), CAST(550.00 AS Decimal(10, 2)), N'Debit Card')
SET IDENTITY_INSERT [dbo].[DoctorFeeBilling] OFF
GO
SET IDENTITY_INSERT [dbo].[DoctorShift] ON 

INSERT [dbo].[DoctorShift] ([ShiftID], [DoctorID], [StartTime], [EndTime], [Day], [Placement], [RoomNo], [AppointmentsLimit]) VALUES (1, 1, CAST(N'09:00:00' AS Time), CAST(N'11:00:00' AS Time), N'Monday', N'OPD', N'Room 101', 20)
INSERT [dbo].[DoctorShift] ([ShiftID], [DoctorID], [StartTime], [EndTime], [Day], [Placement], [RoomNo], [AppointmentsLimit]) VALUES (2, 2, CAST(N'10:00:00' AS Time), CAST(N'12:30:00' AS Time), N'Tuesday', N'OPD', N'Room 102', 25)
INSERT [dbo].[DoctorShift] ([ShiftID], [DoctorID], [StartTime], [EndTime], [Day], [Placement], [RoomNo], [AppointmentsLimit]) VALUES (3, 3, CAST(N'11:00:00' AS Time), CAST(N'12:30:00' AS Time), N'Wednesday', N'OPD', N'Room 103', 15)
SET IDENTITY_INSERT [dbo].[DoctorShift] OFF
GO
SET IDENTITY_INSERT [dbo].[EmergencyCall] ON 

INSERT [dbo].[EmergencyCall] ([CallID], [CallerName], [ContactNumber], [Description], [Location], [Timestamp]) VALUES (1, N'Ali', N'0300-1234567', N'Car accident on main highway', N'Mall Road, Lahore', CAST(N'2024-04-30T09:15:00.000' AS DateTime))
INSERT [dbo].[EmergencyCall] ([CallID], [CallerName], [ContactNumber], [Description], [Location], [Timestamp]) VALUES (2, N'Sana', N'0312-9876543', N'Chest pain and difficulty breathing', N'Gulberg, Karachi', CAST(N'2024-04-30T10:30:00.000' AS DateTime))
INSERT [dbo].[EmergencyCall] ([CallID], [CallerName], [ContactNumber], [Description], [Location], [Timestamp]) VALUES (3, N'Ahmed', N'0321-5678901', N'Fainted at workplace', N'Blue Area, Islamabad', CAST(N'2024-04-30T11:45:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[EmergencyCall] OFF
GO
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (1, N'Ali Khan', CAST(N'1990-05-15' AS Date), N'M', N'0321-1234567', N'House #123, Street ABC, Lahore', N'Doctor', 1, N'ali@example.com', N'password123', CAST(N'2015-10-20' AS Date), CAST(100000.00 AS Decimal(10, 2)), N'Active')
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (2, N'Sana Ahmed', CAST(N'1992-08-25' AS Date), N'F', N'0311-2345678', N'Apartment #456, Street XYZ, Karachi', N'Doctor', 2, N'sana@example.com', N'sana123', CAST(N'2017-03-15' AS Date), CAST(95000.00 AS Decimal(10, 2)), N'Active')
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (3, N'Kamran Ali', CAST(N'1985-12-10' AS Date), N'M', N'0333-3456789', N'Villa #789, Street PQR, Islamabad', N'Doctor', 3, N'kamran@example.com', N'kamran123', CAST(N'2010-06-30' AS Date), CAST(105000.00 AS Decimal(10, 2)), N'Active')
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (4, N'Ayesha Ali', CAST(N'1990-05-15' AS Date), N'F', N'0312-3456789', N'House No. 123, Street 5, Gulberg, Lahore', N'Nurse', 2, N'ayesha.ali@example.com', N'password123', CAST(N'2018-07-10' AS Date), CAST(55000.00 AS Decimal(10, 2)), N'Active')
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (5, N'Farhan Khan', CAST(N'1985-09-20' AS Date), N'M', N'0333-9876543', N'Flat No. 5, Block C, Clifton, Karachi', N'Pharmacist', 3, N'farhan.khan@example.com', N'pharma456', CAST(N'2015-03-20' AS Date), CAST(60000.00 AS Decimal(10, 2)), N'Active')
INSERT [dbo].[Employee] ([EmpID], [EmpName], [DOB], [Gender], [Contact], [Address], [JobTitle], [DeptID], [Email], [Password], [DOJ], [Salary], [Status]) VALUES (6, N'Sana Ahmed', CAST(N'1993-02-28' AS Date), N'F', N'0345-1234567', N'Apartment No. 10, F-8/4, Islamabad', N'Receptionist', 1, N'sana.ahmed@example.com', N'reception789', CAST(N'2019-11-05' AS Date), CAST(45000.00 AS Decimal(10, 2)), N'Active')
SET IDENTITY_INSERT [dbo].[Employee] OFF
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 

INSERT [dbo].[Feedback] ([FeedbackID], [AppointmentID], [Rating], [Comments]) VALUES (1, 1, 4, N'The doctor was very attentive and provided clear explanations.')
INSERT [dbo].[Feedback] ([FeedbackID], [AppointmentID], [Rating], [Comments]) VALUES (2, 2, 5, N'Excellent service. The doctor was knowledgeable and caring.')
INSERT [dbo].[Feedback] ([FeedbackID], [AppointmentID], [Rating], [Comments]) VALUES (3, 3, 3, N'The doctor was a bit rushed during the appointment.')
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[Inventory] ON 

INSERT [dbo].[Inventory] ([InventoryID], [MedicineID], [Quantity]) VALUES (1, 1, 100)
INSERT [dbo].[Inventory] ([InventoryID], [MedicineID], [Quantity]) VALUES (2, 2, 50)
INSERT [dbo].[Inventory] ([InventoryID], [MedicineID], [Quantity]) VALUES (3, 3, 200)
SET IDENTITY_INSERT [dbo].[Inventory] OFF
GO
SET IDENTITY_INSERT [dbo].[Issue] ON 

INSERT [dbo].[Issue] ([IssueID], [DeptID], [EmpID], [CreationDate], [Condition], [Category], [Content], [Status], [Remarks], [ResolvedBy], [CompetitionDate]) VALUES (1, 1, 1, CAST(N'2024-04-30' AS Date), N'Equipment malfunction', N'Maintenance', N'MRI machine not functioning properly.', N'Open', N'Technician scheduled for tomorrow.', 1, CAST(N'2024-05-01' AS Date))
INSERT [dbo].[Issue] ([IssueID], [DeptID], [EmpID], [CreationDate], [Condition], [Category], [Content], [Status], [Remarks], [ResolvedBy], [CompetitionDate]) VALUES (2, 2, 2, CAST(N'2024-04-29' AS Date), N'Inventory shortage', N'Supply Chain', N'Out of stock of certain medications.', N'Open', N'Supplier contacted for urgent delivery.', 2, CAST(N'2024-05-02' AS Date))
INSERT [dbo].[Issue] ([IssueID], [DeptID], [EmpID], [CreationDate], [Condition], [Category], [Content], [Status], [Remarks], [ResolvedBy], [CompetitionDate]) VALUES (3, 3, 3, CAST(N'2024-04-28' AS Date), N'Room maintenance', N'Facilities', N'Leaking pipes in the surgery ward.', N'Open', N'Plumber to fix the issue today.', 3, CAST(N'2024-04-30' AS Date))
SET IDENTITY_INSERT [dbo].[Issue] OFF
GO
SET IDENTITY_INSERT [dbo].[LabInvoices] ON 

INSERT [dbo].[LabInvoices] ([InvoiceID], [Timestamp], [Amount]) VALUES (1, CAST(N'2024-05-01T08:00:00.000' AS DateTime), CAST(400.00 AS Decimal(10, 2)))
INSERT [dbo].[LabInvoices] ([InvoiceID], [Timestamp], [Amount]) VALUES (2, CAST(N'2024-05-02T09:00:00.000' AS DateTime), CAST(300.00 AS Decimal(10, 2)))
INSERT [dbo].[LabInvoices] ([InvoiceID], [Timestamp], [Amount]) VALUES (3, CAST(N'2024-05-03T10:00:00.000' AS DateTime), CAST(600.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[LabInvoices] OFF
GO
INSERT [dbo].[LabResults] ([SampleID], [FieldID], [FieldResult], [Timestamp]) VALUES (1, 1, N'14 g/dL', CAST(N'2024-05-02T19:01:21.570' AS DateTime))
INSERT [dbo].[LabResults] ([SampleID], [FieldID], [FieldResult], [Timestamp]) VALUES (1, 2, N'95 mg/dL', CAST(N'2024-05-02T19:01:21.570' AS DateTime))
INSERT [dbo].[LabResults] ([SampleID], [FieldID], [FieldResult], [Timestamp]) VALUES (2, 2, N'105 mg/dL', CAST(N'2024-05-02T19:01:21.570' AS DateTime))
INSERT [dbo].[LabResults] ([SampleID], [FieldID], [FieldResult], [Timestamp]) VALUES (3, 3, N'130/85 mmHg', CAST(N'2024-05-02T19:01:21.570' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Manufacturer] ON 

INSERT [dbo].[Manufacturer] ([ManufacturerID], [ManufacturerName], [Email], [Address], [Contact]) VALUES (1, N'ABC Pharmaceuticals', N'info@abcpharma.com', N'123 Pharma Street, Lahore', N'042-1234567')
INSERT [dbo].[Manufacturer] ([ManufacturerID], [ManufacturerName], [Email], [Address], [Contact]) VALUES (2, N'XYZ Laboratories', N'info@xyzlabs.com', N'456 Lab Avenue, Karachi', N'021-2345678')
INSERT [dbo].[Manufacturer] ([ManufacturerID], [ManufacturerName], [Email], [Address], [Contact]) VALUES (3, N'PQR Medical Supplies', N'info@pqrmed.com', N'789 Med Road, Islamabad', N'051-3456789')
SET IDENTITY_INSERT [dbo].[Manufacturer] OFF
GO
INSERT [dbo].[ManufacturerMedicine] ([ManufacturerID], [MedicineID]) VALUES (1, 1)
INSERT [dbo].[ManufacturerMedicine] ([ManufacturerID], [MedicineID]) VALUES (2, 2)
INSERT [dbo].[ManufacturerMedicine] ([ManufacturerID], [MedicineID]) VALUES (3, 3)
GO
SET IDENTITY_INSERT [dbo].[MedBilling] ON 

INSERT [dbo].[MedBilling] ([BillingID], [PrescriptionID], [Date], [TotalAmount], [PaymentMethod]) VALUES (1, 1, CAST(N'2024-05-01' AS Date), CAST(1500.00 AS Decimal(10, 2)), N'Cash')
INSERT [dbo].[MedBilling] ([BillingID], [PrescriptionID], [Date], [TotalAmount], [PaymentMethod]) VALUES (2, 2, CAST(N'2024-05-02' AS Date), CAST(1500.00 AS Decimal(10, 2)), N'Credit Card')
INSERT [dbo].[MedBilling] ([BillingID], [PrescriptionID], [Date], [TotalAmount], [PaymentMethod]) VALUES (3, 3, CAST(N'2024-05-03' AS Date), CAST(600.00 AS Decimal(10, 2)), N'Debit Card')
SET IDENTITY_INSERT [dbo].[MedBilling] OFF
GO
SET IDENTITY_INSERT [dbo].[MedicalHistory] ON 

INSERT [dbo].[MedicalHistory] ([MedicalHistoryID], [PatientID], [Diagnosis], [TreatmentHistory], [Allergies], [PreviousSurgeries], [FamilyHistory]) VALUES (1, 1, N'Hypertension', N'Underwent treatment for high blood pressure.', N'None', N'Appendectomy in 2005', N'Father has a history of heart disease.')
INSERT [dbo].[MedicalHistory] ([MedicalHistoryID], [PatientID], [Diagnosis], [TreatmentHistory], [Allergies], [PreviousSurgeries], [FamilyHistory]) VALUES (2, 2, N'Stroke', N'Previously suffered a stroke in 2018.', N'Penicillin allergy', N'None', N'Mother had a stroke.')
INSERT [dbo].[MedicalHistory] ([MedicalHistoryID], [PatientID], [Diagnosis], [TreatmentHistory], [Allergies], [PreviousSurgeries], [FamilyHistory]) VALUES (3, 3, N'Fracture', N'Recently had surgery to fix a fractured arm.', N'None', N'Arm surgery in 2000', N'No significant family history.')
SET IDENTITY_INSERT [dbo].[MedicalHistory] OFF
GO
SET IDENTITY_INSERT [dbo].[Medicine] ON 

INSERT [dbo].[Medicine] ([MedicineID], [MedicineName], [ManufacturerID], [Category], [ManufacturingDate], [ExpiryDate], [PricePerUnit]) VALUES (1, N'Aspirin', 1, N'Analgesic', CAST(N'2023-01-01' AS Date), CAST(N'2024-12-31' AS Date), CAST(50.00 AS Decimal(10, 2)))
INSERT [dbo].[Medicine] ([MedicineID], [MedicineName], [ManufacturerID], [Category], [ManufacturingDate], [ExpiryDate], [PricePerUnit]) VALUES (2, N'Amoxicillin', 2, N'Antibiotic', CAST(N'2022-03-15' AS Date), CAST(N'2024-03-14' AS Date), CAST(100.00 AS Decimal(10, 2)))
INSERT [dbo].[Medicine] ([MedicineID], [MedicineName], [ManufacturerID], [Category], [ManufacturingDate], [ExpiryDate], [PricePerUnit]) VALUES (3, N'Paracetamol', 3, N'Analgesic', CAST(N'2023-05-20' AS Date), CAST(N'2025-05-19' AS Date), CAST(30.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Medicine] OFF
GO
SET IDENTITY_INSERT [dbo].[MedStock] ON 

INSERT [dbo].[MedStock] ([StockID], [MedicineID], [SupplierID], [PurchaseDate], [Quantity]) VALUES (1, 1, 1, CAST(N'2024-04-01' AS Date), 200)
INSERT [dbo].[MedStock] ([StockID], [MedicineID], [SupplierID], [PurchaseDate], [Quantity]) VALUES (2, 2, 2, CAST(N'2024-04-02' AS Date), 100)
INSERT [dbo].[MedStock] ([StockID], [MedicineID], [SupplierID], [PurchaseDate], [Quantity]) VALUES (3, 3, 3, CAST(N'2024-04-03' AS Date), 300)
SET IDENTITY_INSERT [dbo].[MedStock] OFF
GO
SET IDENTITY_INSERT [dbo].[Patient] ON 

INSERT [dbo].[Patient] ([PatientID], [PatientName], [DOB], [Gender], [Contact], [Address], [Email], [Password], [Status]) VALUES (1, N'Hassan Ali', CAST(N'1988-07-20' AS Date), N'M', N'0300-1112233', N'House #234, Street LMN, Lahore', N'hassan@example.com', N'patient123', N'Visiting')
INSERT [dbo].[Patient] ([PatientID], [PatientName], [DOB], [Gender], [Contact], [Address], [Email], [Password], [Status]) VALUES (2, N'Sara Khan', CAST(N'1995-03-12' AS Date), N'F', N'0345-2223344', N'Apartment #567, Street OPQ, Karachi', N'sara@example.com', N'sara123', N'Admitted')
INSERT [dbo].[Patient] ([PatientID], [PatientName], [DOB], [Gender], [Contact], [Address], [Email], [Password], [Status]) VALUES (3, N'Ahmed Raza', CAST(N'1975-12-05' AS Date), N'M', N'0321-3334455', N'Villa #890, Street RST, Islamabad', N'ahmed@example.com', N'ahmed123', N'Visting')
SET IDENTITY_INSERT [dbo].[Patient] OFF
GO
SET IDENTITY_INSERT [dbo].[PatientsInER] ON 

INSERT [dbo].[PatientsInER] ([PatientID], [RequestID], [Status], [Triage]) VALUES (1, 1, N'Admitted', N'Immediate')
INSERT [dbo].[PatientsInER] ([PatientID], [RequestID], [Status], [Triage]) VALUES (2, 2, N'Under Observation', N'Urgent')
INSERT [dbo].[PatientsInER] ([PatientID], [RequestID], [Status], [Triage]) VALUES (3, 3, N'Awaiting Assessment', N'Non-urgent')
SET IDENTITY_INSERT [dbo].[PatientsInER] OFF
GO
INSERT [dbo].[PatientsInERHistory] ([PatientID], [Timestamp], [Description], [Status]) VALUES (1, CAST(N'2024-04-30T11:30:00.000' AS DateTime), N'Stable after initial treatment', N'Admitted')
INSERT [dbo].[PatientsInERHistory] ([PatientID], [Timestamp], [Description], [Status]) VALUES (2, CAST(N'2024-04-30T12:45:00.000' AS DateTime), N'Undergoing further tests', N'Under Observation')
INSERT [dbo].[PatientsInERHistory] ([PatientID], [Timestamp], [Description], [Status]) VALUES (3, CAST(N'2024-04-30T13:30:00.000' AS DateTime), N'Awaiting doctor assessment', N'Awaiting Assessment')
GO
INSERT [dbo].[PatientTest] ([PrescriptionID], [TestID]) VALUES (1, 1)
INSERT [dbo].[PatientTest] ([PrescriptionID], [TestID]) VALUES (2, 2)
INSERT [dbo].[PatientTest] ([PrescriptionID], [TestID]) VALUES (3, 3)
GO
INSERT [dbo].[Pharmacist] ([EmpID], [ExperienceLevel]) VALUES (5, N'Senior')
GO
SET IDENTITY_INSERT [dbo].[Prescription] ON 

INSERT [dbo].[Prescription] ([PrescriptionID], [AppointmentID], [DiagnosisID], [ClinicalNotes], [Status], [Date]) VALUES (1, 1, 1, N'Prescribed medication for hypertension.', N'Active', CAST(N'2024-05-01' AS Date))
INSERT [dbo].[Prescription] ([PrescriptionID], [AppointmentID], [DiagnosisID], [ClinicalNotes], [Status], [Date]) VALUES (2, 2, 2, N'Prescribed medication for stroke.', N'Active', CAST(N'2024-05-02' AS Date))
INSERT [dbo].[Prescription] ([PrescriptionID], [AppointmentID], [DiagnosisID], [ClinicalNotes], [Status], [Date]) VALUES (3, 3, 3, N'Prescribed medication for fracture.', N'Active', CAST(N'2024-05-03' AS Date))
SET IDENTITY_INSERT [dbo].[Prescription] OFF
GO
INSERT [dbo].[PrescriptionDiagnosis] ([PrescriptionID], [DiagnosisID], [Date], [Description]) VALUES (1, 1, CAST(N'2024-05-01' AS Date), N'Patient has high blood pressure.')
INSERT [dbo].[PrescriptionDiagnosis] ([PrescriptionID], [DiagnosisID], [Date], [Description]) VALUES (2, 2, CAST(N'2024-05-02' AS Date), N'Patient has suffered a stroke.')
INSERT [dbo].[PrescriptionDiagnosis] ([PrescriptionID], [DiagnosisID], [Date], [Description]) VALUES (3, 3, CAST(N'2024-05-03' AS Date), N'Patient has a fractured arm.')
GO
INSERT [dbo].[PrescriptionMedicine] ([PrescriptionID], [MedicineID], [Frequency], [Quantity], [Dosage], [Instructions], [MedicineDuration]) VALUES (1, 1, N'Twice a day', 30, N'500mg', N'Take with water after meals', 30)
INSERT [dbo].[PrescriptionMedicine] ([PrescriptionID], [MedicineID], [Frequency], [Quantity], [Dosage], [Instructions], [MedicineDuration]) VALUES (2, 2, N'Once a day', 15, N'250mg', N'Take with or without food', 15)
INSERT [dbo].[PrescriptionMedicine] ([PrescriptionID], [MedicineID], [Frequency], [Quantity], [Dosage], [Instructions], [MedicineDuration]) VALUES (3, 3, N'As needed', 20, N'500mg', N'Take as directed by the doctor', 10)
GO
SET IDENTITY_INSERT [dbo].[Report] ON 

INSERT [dbo].[Report] ([ReportID], [ReportName], [Description], [GeneratedBy], [Timestamp], [Format], [DeptID]) VALUES (1, N'Monthly Sales Report', N'Summary of medicine sales for the month.', 1, CAST(N'2024-05-01T15:00:00.000' AS DateTime), N'PDF', 1)
INSERT [dbo].[Report] ([ReportID], [ReportName], [Description], [GeneratedBy], [Timestamp], [Format], [DeptID]) VALUES (2, N'Inventory Status Report', N'Current inventory levels for all departments.', 2, CAST(N'2024-05-02T14:30:00.000' AS DateTime), N'Excel', 2)
INSERT [dbo].[Report] ([ReportID], [ReportName], [Description], [GeneratedBy], [Timestamp], [Format], [DeptID]) VALUES (3, N'Facility Maintenance Report', N'Overview of recent maintenance activities.', 3, CAST(N'2024-04-30T16:30:00.000' AS DateTime), N'PDF', 3)
SET IDENTITY_INSERT [dbo].[Report] OFF
GO
SET IDENTITY_INSERT [dbo].[Samples] ON 

INSERT [dbo].[Samples] ([SampleID], [OrderID], [SampleShift], [Timestamp], [Volume], [StorageCondition]) VALUES (1, 1, N'Morning', CAST(N'2024-05-02T19:01:21.567' AS DateTime), 5, N'Refrigerated')
INSERT [dbo].[Samples] ([SampleID], [OrderID], [SampleShift], [Timestamp], [Volume], [StorageCondition]) VALUES (2, 2, N'Morning', CAST(N'2024-05-02T19:01:21.567' AS DateTime), 10, N'Room Temperature')
INSERT [dbo].[Samples] ([SampleID], [OrderID], [SampleShift], [Timestamp], [Volume], [StorageCondition]) VALUES (3, 3, N'Morning', CAST(N'2024-05-02T19:01:21.567' AS DateTime), 8, N'Refrigerated')
SET IDENTITY_INSERT [dbo].[Samples] OFF
GO
SET IDENTITY_INSERT [dbo].[Supplier] ON 

INSERT [dbo].[Supplier] ([SupplierID], [Supplier_Name], [Contact_Number], [Address]) VALUES (1, N'MediSupp', N'0333-1122334', N'12 Pharma Street, Lahore')
INSERT [dbo].[Supplier] ([SupplierID], [Supplier_Name], [Contact_Number], [Address]) VALUES (2, N'Pharma Distributors', N'0311-2233445', N'34 Med Avenue, Karachi')
INSERT [dbo].[Supplier] ([SupplierID], [Supplier_Name], [Contact_Number], [Address]) VALUES (3, N'MediWholesale', N'0300-3344556', N'56 Health Road, Islamabad')
SET IDENTITY_INSERT [dbo].[Supplier] OFF
GO
INSERT [dbo].[TestCountAndStatus] ([OrderID], [TestID], [Status], [SampleID]) VALUES (1, 1, N'In Progress', 1)
INSERT [dbo].[TestCountAndStatus] ([OrderID], [TestID], [Status], [SampleID]) VALUES (2, 2, N'Completed', 2)
INSERT [dbo].[TestCountAndStatus] ([OrderID], [TestID], [Status], [SampleID]) VALUES (3, 3, N'In Progress', 3)
GO
SET IDENTITY_INSERT [dbo].[TestFields] ON 

INSERT [dbo].[TestFields] ([FieldID], [FieldName], [NormalRange]) VALUES (1, N'Hemoglobin', N'12-18 g/dL')
INSERT [dbo].[TestFields] ([FieldID], [FieldName], [NormalRange]) VALUES (2, N'Glucose', N'70-110 mg/dL')
INSERT [dbo].[TestFields] ([FieldID], [FieldName], [NormalRange]) VALUES (3, N'Blood Pressure', N'120/80 mmHg')
SET IDENTITY_INSERT [dbo].[TestFields] OFF
GO
INSERT [dbo].[TestFieldsBridge] ([TestID], [FieldID]) VALUES (1, 1)
INSERT [dbo].[TestFieldsBridge] ([TestID], [FieldID]) VALUES (1, 2)
INSERT [dbo].[TestFieldsBridge] ([TestID], [FieldID]) VALUES (2, 2)
INSERT [dbo].[TestFieldsBridge] ([TestID], [FieldID]) VALUES (3, 3)
GO
SET IDENTITY_INSERT [dbo].[TestOrders] ON 

INSERT [dbo].[TestOrders] ([OrderID], [PrescriptionID], [InvoiceID], [Timestamp], [collection_time]) VALUES (1, 1, 1, CAST(N'2024-05-02T19:01:21.567' AS DateTime), CAST(N'08:30:00' AS Time))
INSERT [dbo].[TestOrders] ([OrderID], [PrescriptionID], [InvoiceID], [Timestamp], [collection_time]) VALUES (2, 2, 2, CAST(N'2024-05-02T19:01:21.567' AS DateTime), CAST(N'09:30:00' AS Time))
INSERT [dbo].[TestOrders] ([OrderID], [PrescriptionID], [InvoiceID], [Timestamp], [collection_time]) VALUES (3, 3, 3, CAST(N'2024-05-02T19:01:21.567' AS DateTime), CAST(N'10:30:00' AS Time))
SET IDENTITY_INSERT [dbo].[TestOrders] OFF
GO
SET IDENTITY_INSERT [dbo].[TestRequirements] ON 

INSERT [dbo].[TestRequirements] ([RequirementID], [TestID], [RequirementName], [Description]) VALUES (1, 1, N'Fasting', N'Patient must fast for 8 hours prior to the test.')
INSERT [dbo].[TestRequirements] ([RequirementID], [TestID], [RequirementName], [Description]) VALUES (2, 2, N'Morning Sample', N'Sample must be collected in the morning.')
INSERT [dbo].[TestRequirements] ([RequirementID], [TestID], [RequirementName], [Description]) VALUES (3, 3, N'Radiation Safety', N'Patient should wear protective gear during the X-ray.')
SET IDENTITY_INSERT [dbo].[TestRequirements] OFF
GO
SET IDENTITY_INSERT [dbo].[TotalLabTest] ON 

INSERT [dbo].[TotalLabTest] ([TestID], [Testname], [ProcessingTime], [Cost]) VALUES (1, N'Blood Test', 1, CAST(200.00 AS Decimal(10, 2)))
INSERT [dbo].[TotalLabTest] ([TestID], [Testname], [ProcessingTime], [Cost]) VALUES (2, N'Urine Test', 2, CAST(150.00 AS Decimal(10, 2)))
INSERT [dbo].[TotalLabTest] ([TestID], [Testname], [ProcessingTime], [Cost]) VALUES (3, N'X-ray', 3, CAST(300.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[TotalLabTest] OFF
GO
SET IDENTITY_INSERT [dbo].[VitalSigns] ON 

INSERT [dbo].[VitalSigns] ([VitalID], [PatientID], [Temperature], [BloodPressure], [HeartRate], [BloodSugar], [BloodOxygen], [Timestamp]) VALUES (1, 1, CAST(99.50 AS Decimal(5, 2)), N'120/80', 80, CAST(110.00 AS Decimal(5, 2)), CAST(98.00 AS Decimal(5, 2)), CAST(N'2024-04-30T10:00:00.000' AS DateTime))
INSERT [dbo].[VitalSigns] ([VitalID], [PatientID], [Temperature], [BloodPressure], [HeartRate], [BloodSugar], [BloodOxygen], [Timestamp]) VALUES (2, 2, CAST(101.20 AS Decimal(5, 2)), N'140/90', 95, CAST(120.00 AS Decimal(5, 2)), CAST(94.00 AS Decimal(5, 2)), CAST(N'2024-04-30T11:00:00.000' AS DateTime))
INSERT [dbo].[VitalSigns] ([VitalID], [PatientID], [Temperature], [BloodPressure], [HeartRate], [BloodSugar], [BloodOxygen], [Timestamp]) VALUES (3, 3, CAST(98.60 AS Decimal(5, 2)), N'110/70', 75, CAST(100.00 AS Decimal(5, 2)), CAST(99.00 AS Decimal(5, 2)), CAST(N'2024-04-30T12:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[VitalSigns] OFF
GO
ALTER TABLE [dbo].[LabResults] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[Samples] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[TestOrders] ADD  DEFAULT (getdate()) FOR [Timestamp]
GO
ALTER TABLE [dbo].[AmbulanceRequest]  WITH CHECK ADD FOREIGN KEY([AmbulanceID])
REFERENCES [dbo].[Ambulance] ([AmbulanceID])
GO
ALTER TABLE [dbo].[AmbulanceRequest]  WITH CHECK ADD FOREIGN KEY([CallID])
REFERENCES [dbo].[EmergencyCall] ([CallID])
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[Control]  WITH CHECK ADD FOREIGN KEY([AdminID])
REFERENCES [dbo].[Admin] ([AdminID])
GO
ALTER TABLE [dbo].[DepartmentHead]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[Department] ([DeptID])
GO
ALTER TABLE [dbo].[DepartmentHead]  WITH CHECK ADD FOREIGN KEY([HOD])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[Doctor]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[Department] ([DeptID])
GO
ALTER TABLE [dbo].[DoctorFeeBilling]  WITH CHECK ADD FOREIGN KEY([AppointmentID])
REFERENCES [dbo].[Appointment] ([AppointmentID])
GO
ALTER TABLE [dbo].[DoctorFeeBilling]  WITH CHECK ADD FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[DoctorFeeBilling]  WITH CHECK ADD FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[DoctorShift]  WITH CHECK ADD FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[Department] ([DeptID])
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([AppointmentID])
REFERENCES [dbo].[Appointment] ([AppointmentID])
GO
ALTER TABLE [dbo].[Inventory]  WITH CHECK ADD FOREIGN KEY([MedicineID])
REFERENCES [dbo].[Medicine] ([MedicineID])
GO
ALTER TABLE [dbo].[Issue]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[Department] ([DeptID])
GO
ALTER TABLE [dbo].[Issue]  WITH CHECK ADD FOREIGN KEY([EmpID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[Issue]  WITH CHECK ADD FOREIGN KEY([ResolvedBy])
REFERENCES [dbo].[Admin] ([AdminID])
GO
ALTER TABLE [dbo].[LabResults]  WITH CHECK ADD FOREIGN KEY([FieldID])
REFERENCES [dbo].[TestFields] ([FieldID])
GO
ALTER TABLE [dbo].[LabResults]  WITH CHECK ADD FOREIGN KEY([SampleID])
REFERENCES [dbo].[Samples] ([SampleID])
GO
ALTER TABLE [dbo].[ManufacturerMedicine]  WITH CHECK ADD FOREIGN KEY([ManufacturerID])
REFERENCES [dbo].[Manufacturer] ([ManufacturerID])
GO
ALTER TABLE [dbo].[ManufacturerMedicine]  WITH CHECK ADD FOREIGN KEY([MedicineID])
REFERENCES [dbo].[Medicine] ([MedicineID])
GO
ALTER TABLE [dbo].[MedBilling]  WITH CHECK ADD FOREIGN KEY([PrescriptionID])
REFERENCES [dbo].[Prescription] ([PrescriptionID])
GO
ALTER TABLE [dbo].[MedicalHistory]  WITH CHECK ADD FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[Medicine]  WITH CHECK ADD FOREIGN KEY([ManufacturerID])
REFERENCES [dbo].[Manufacturer] ([ManufacturerID])
GO
ALTER TABLE [dbo].[MedStock]  WITH CHECK ADD FOREIGN KEY([MedicineID])
REFERENCES [dbo].[Medicine] ([MedicineID])
GO
ALTER TABLE [dbo].[MedStock]  WITH CHECK ADD FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Supplier] ([SupplierID])
GO
ALTER TABLE [dbo].[PatientsInER]  WITH CHECK ADD FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patient] ([PatientID])
GO
ALTER TABLE [dbo].[PatientsInER]  WITH CHECK ADD FOREIGN KEY([RequestID])
REFERENCES [dbo].[AmbulanceRequest] ([RequestID])
GO
ALTER TABLE [dbo].[PatientsInERHistory]  WITH CHECK ADD FOREIGN KEY([PatientID])
REFERENCES [dbo].[PatientsInER] ([PatientID])
GO
ALTER TABLE [dbo].[PatientTest]  WITH CHECK ADD FOREIGN KEY([PrescriptionID])
REFERENCES [dbo].[Prescription] ([PrescriptionID])
GO
ALTER TABLE [dbo].[PatientTest]  WITH CHECK ADD FOREIGN KEY([TestID])
REFERENCES [dbo].[TotalLabTest] ([TestID])
GO
ALTER TABLE [dbo].[Pharmacist]  WITH CHECK ADD FOREIGN KEY([EmpID])
REFERENCES [dbo].[Employee] ([EmpID])
GO
ALTER TABLE [dbo].[Prescription]  WITH CHECK ADD FOREIGN KEY([AppointmentID])
REFERENCES [dbo].[Appointment] ([AppointmentID])
GO
ALTER TABLE [dbo].[Prescription]  WITH CHECK ADD FOREIGN KEY([DiagnosisID])
REFERENCES [dbo].[Diagnosis] ([DiagnosisID])
GO
ALTER TABLE [dbo].[PrescriptionDiagnosis]  WITH CHECK ADD FOREIGN KEY([DiagnosisID])
REFERENCES [dbo].[Diagnosis] ([DiagnosisID])
GO
ALTER TABLE [dbo].[PrescriptionDiagnosis]  WITH CHECK ADD FOREIGN KEY([PrescriptionID])
REFERENCES [dbo].[Prescription] ([PrescriptionID])
GO
ALTER TABLE [dbo].[PrescriptionMedicine]  WITH CHECK ADD FOREIGN KEY([MedicineID])
REFERENCES [dbo].[Medicine] ([MedicineID])
GO
ALTER TABLE [dbo].[PrescriptionMedicine]  WITH CHECK ADD FOREIGN KEY([PrescriptionID])
REFERENCES [dbo].[Prescription] ([PrescriptionID])
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD FOREIGN KEY([DeptID])
REFERENCES [dbo].[Department] ([DeptID])
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD FOREIGN KEY([GeneratedBy])
REFERENCES [dbo].[Admin] ([AdminID])
GO
ALTER TABLE [dbo].[Samples]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[TestOrders] ([OrderID])
GO
ALTER TABLE [dbo].[TestCountAndStatus]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[TestOrders] ([OrderID])
GO
ALTER TABLE [dbo].[TestCountAndStatus]  WITH CHECK ADD FOREIGN KEY([SampleID])
REFERENCES [dbo].[Samples] ([SampleID])
GO
ALTER TABLE [dbo].[TestCountAndStatus]  WITH CHECK ADD FOREIGN KEY([TestID])
REFERENCES [dbo].[TotalLabTest] ([TestID])
GO
ALTER TABLE [dbo].[TestFieldsBridge]  WITH CHECK ADD FOREIGN KEY([FieldID])
REFERENCES [dbo].[TestFields] ([FieldID])
GO
ALTER TABLE [dbo].[TestFieldsBridge]  WITH CHECK ADD FOREIGN KEY([TestID])
REFERENCES [dbo].[TotalLabTest] ([TestID])
GO
ALTER TABLE [dbo].[TestOrders]  WITH CHECK ADD FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[LabInvoices] ([InvoiceID])
GO
ALTER TABLE [dbo].[TestOrders]  WITH CHECK ADD FOREIGN KEY([PrescriptionID])
REFERENCES [dbo].[Prescription] ([PrescriptionID])
GO
ALTER TABLE [dbo].[TestRequirements]  WITH CHECK ADD FOREIGN KEY([TestID])
REFERENCES [dbo].[TotalLabTest] ([TestID])
GO
ALTER TABLE [dbo].[VitalSigns]  WITH CHECK ADD FOREIGN KEY([PatientID])
REFERENCES [dbo].[PatientsInER] ([PatientID])
GO
USE [master]
GO
ALTER DATABASE [HospitalManagementSystem] SET  READ_WRITE 
GO

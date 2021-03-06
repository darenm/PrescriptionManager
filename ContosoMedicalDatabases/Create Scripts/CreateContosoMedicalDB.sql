USE [master]
GO
/****** Object:  Database [ContosoMedicalDB]    Script Date: 12/1/2017 1:29:47 PM ******/
CREATE DATABASE [ContosoMedicalDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ContosoMedicalDB', FILENAME = N'D:\Sql Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ContosoMedicalDB.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ContosoMedicalDB_log', FILENAME = N'D:\Sql Server\MSSQL13.MSSQLSERVER\MSSQL\DATA\ContosoMedicalDB_log.LDF' , SIZE = 7744KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ContosoMedicalDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ContosoMedicalDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ContosoMedicalDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ContosoMedicalDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ContosoMedicalDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ContosoMedicalDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ContosoMedicalDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ContosoMedicalDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ContosoMedicalDB] SET  MULTI_USER 
GO
ALTER DATABASE [ContosoMedicalDB] SET PAGE_VERIFY NONE  
GO
ALTER DATABASE [ContosoMedicalDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ContosoMedicalDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ContosoMedicalDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ContosoMedicalDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ContosoMedicalDB] SET QUERY_STORE = OFF
GO
USE [ContosoMedicalDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [ContosoMedicalDB]
GO
/****** Object:  Table [dbo].[Appointments]    Script Date: 12/1/2017 1:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointments](
	[AppointmentID] [int] IDENTITY(1,1) NOT NULL,
	[DoctorID] [int] NOT NULL,
	[PatientID] [int] NOT NULL,
	[AppointmentDateTime] [datetime] NOT NULL,
	[Notes] [nvarchar](500) NULL,
 CONSTRAINT [PK_Appointments] PRIMARY KEY CLUSTERED 
(
	[AppointmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ArchivedPatients]    Script Date: 12/1/2017 1:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArchivedPatients](
	[FullName] [nvarchar](70) NOT NULL,
	[DateOfBirth] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctors]    Script Date: 12/1/2017 1:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctors](
	[DoctorID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](30) NOT NULL,
	[LastName] [nvarchar](30) NOT NULL,
	[Specialty] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_Doctors] PRIMARY KEY CLUSTERED 
(
	[DoctorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patients]    Script Date: 12/1/2017 1:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patients](
	[PatientID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](30) NOT NULL,
	[LastName] [nvarchar](30) NOT NULL,
	[Gender] [char](1) NOT NULL,
	[DateOfBirth] [datetime] NOT NULL,
	[Photo] [varbinary](max) NULL,
 CONSTRAINT [PK_Patients] PRIMARY KEY CLUSTERED 
(
	[PatientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prescriptions]    Script Date: 12/1/2017 1:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prescriptions](
	[PrescriptionID] [int] IDENTITY(1,1) NOT NULL,
	[PatientID] [int] NOT NULL,
	[Description] [nvarchar](100) NOT NULL,
	[IssueDate] [datetime] NOT NULL,
	[RepeatCount] [int] NOT NULL,
 CONSTRAINT [PK_Prescriptions] PRIMARY KEY CLUSTERED 
(
	[PrescriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Appointments] ADD  CONSTRAINT [DF_Appointments_Notes]  DEFAULT (N'No notes.') FOR [Notes]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_Doctors] FOREIGN KEY([DoctorID])
REFERENCES [dbo].[Doctors] ([DoctorID])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_Doctors]
GO
ALTER TABLE [dbo].[Appointments]  WITH CHECK ADD  CONSTRAINT [FK_Appointments_Patients] FOREIGN KEY([PatientID])
REFERENCES [dbo].[Patients] ([PatientID])
GO
ALTER TABLE [dbo].[Appointments] CHECK CONSTRAINT [FK_Appointments_Patients]
GO
/****** Object:  StoredProcedure [dbo].[uspArchivePatient]    Script Date: 12/1/2017 1:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspArchivePatient]
(
   @fullName NVARCHAR(70),
   @dateOfBirth DATETIME
)
AS
   -- Simulate an error.
   IF @fullName = 'Dummy Patient'
   BEGIN
      RAISERROR('Cannot archive %s.', 11, -1, @fullName)
   END

   INSERT INTO ArchivedPatients
      (FullName, DateOfBirth)
   VALUES
      (@fullName, @dateOfBirth)
   RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspDeletePatient]    Script Date: 12/1/2017 1:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspDeletePatient]
(
   @patientID INT
)
AS
   DELETE FROM Patients
   WHERE
      PatientID=@patientID
   RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspGetAppointmentsForDoctor]    Script Date: 12/1/2017 1:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored procedure to return only the rows changed between the two sync anchors
-- Only the rows for the specified doctor will be returned.
CREATE Procedure [dbo].[uspGetAppointmentsForDoctor]
(
   @doctorID int,
   @sync_last_received_anchor datetime, -- last time we got data from the server
   @sync_new_received_anchor datetime,   -- current anchor
   @sync_initialized int
)
AS
   SELECT a.[AppointmentID], a.[AppointmentDateTime], a.[PatientID], 
          p.[FirstName] + ' ' + p.[LastName] AS FullName, 
          p.[Gender], p.[DateOfBirth], a.[Notes]
   FROM   [Appointments] AS a INNER JOIN [Patients] AS p 
          ON a.[PatientID] = p.[PatientID]
   WHERE  (a.[DoctorID] = @doctorID)
          AND ((@sync_initialized = 0) 
          OR (a.[LastEditDate] > @sync_last_received_anchor 
          AND a.[LastEditDate] <= @sync_new_received_anchor)) 
GO
/****** Object:  StoredProcedure [dbo].[uspGetDoctorsForSpecialty]    Script Date: 12/1/2017 1:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetDoctorsForSpecialty]
(
   @specialty NVARCHAR(30),
   @doctorCount INT OUTPUT
)
AS
   SET NOCOUNT ON

   SELECT @doctorCount = COUNT(*) 
   FROM Doctors 
   WHERE Specialty = @specialty

   DECLARE @specialtyCount INT
   SELECT @specialtyCount = COUNT(DISTINCT Specialty)
   FROM DOCTORS

   SELECT DoctorID, FirstName, LastName, Specialty
   FROM DOCTORS
   WHERE Specialty = @specialty

   RETURN @specialtyCount
GO
/****** Object:  StoredProcedure [dbo].[uspGetPatient]    Script Date: 12/1/2017 1:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetPatient]
(
   @patientID INT
)
AS
   SELECT * FROM Patients
   WHERE PatientID=@patientID

   RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspGetPatientPhoto]    Script Date: 12/1/2017 1:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetPatientPhoto]
(
   @patientID INT
)
AS
   -- Set up an artificial delay, to test asynchronous call.
   WAITFOR DELAY '00:00:03';

   SELECT Photo FROM Patients WHERE PatientID=@patientID

   RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspInsertPatient]    Script Date: 12/1/2017 1:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertPatient]
(
   @firstName NVARCHAR(30),
   @lastName NVARCHAR(30),
   @gender CHAR(1),
   @dateOfBirth DATETIME,
   @patientID INT OUTPUT
)
AS
   INSERT INTO Patients (FirstName, LastName, Gender, DateOfBirth)
   VALUES (@firstName, @lastName, @gender, @dateOfBirth);
    
   SELECT @patientID=@@IDENTITY

   RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspSavePatientPhoto]    Script Date: 12/1/2017 1:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspSavePatientPhoto]
(
   @patientID INT,
   @photo VARBINARY(MAX)
)
AS
   -- Set up an artificial delay, to test asynchronous call.
   WAITFOR DELAY '00:00:03';

   UPDATE Patients SET Photo=@photo WHERE PatientID=@patientID

   RETURN
GO
/****** Object:  StoredProcedure [dbo].[uspUpdatePatient]    Script Date: 12/1/2017 1:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUpdatePatient]
(
   @patientID INT,
   @firstName NVARCHAR(30),
   @lastName NVARCHAR(30),
   @gender CHAR(1),
   @dateOfBirth DATETIME
)
AS
   UPDATE Patients
   SET
      FirstName=@firstName,
      LastName=@lastName,
      Gender=@gender,
      DateOfBirth=@dateOfBirth
   WHERE
      PatientID=@patientID    
   RETURN
GO
USE [master]
GO
ALTER DATABASE [ContosoMedicalDB] SET  READ_WRITE 
GO

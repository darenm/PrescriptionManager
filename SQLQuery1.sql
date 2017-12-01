USE [ContosoMedicalDB]
GO
ALTER TABLE [dbo].[Appointments] DROP CONSTRAINT [FK_Appointments_Patients]
GO
ALTER TABLE [dbo].[Appointments] DROP CONSTRAINT [FK_Appointments_Doctors]
GO
ALTER TABLE [dbo].[Appointments] DROP CONSTRAINT [DF_Appointments_Notes]
GO
/****** Object:  Table [dbo].[Prescriptions]    Script Date: 12/1/2017 1:36:06 PM ******/
DROP TABLE [dbo].[Prescriptions]
GO
/****** Object:  Table [dbo].[Patients]    Script Date: 12/1/2017 1:36:06 PM ******/
DROP TABLE [dbo].[Patients]
GO
/****** Object:  Table [dbo].[Doctors]    Script Date: 12/1/2017 1:36:06 PM ******/
DROP TABLE [dbo].[Doctors]
GO
/****** Object:  Table [dbo].[ArchivedPatients]    Script Date: 12/1/2017 1:36:06 PM ******/
DROP TABLE [dbo].[ArchivedPatients]
GO
/****** Object:  Table [dbo].[Appointments]    Script Date: 12/1/2017 1:36:06 PM ******/
DROP TABLE [dbo].[Appointments]
GO
/****** Object:  Table [dbo].[Appointments]    Script Date: 12/1/2017 1:36:06 PM ******/
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
/****** Object:  Table [dbo].[ArchivedPatients]    Script Date: 12/1/2017 1:36:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArchivedPatients](
	[FullName] [nvarchar](70) NOT NULL,
	[DateOfBirth] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctors]    Script Date: 12/1/2017 1:36:06 PM ******/
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
/****** Object:  Table [dbo].[Patients]    Script Date: 12/1/2017 1:36:06 PM ******/
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
/****** Object:  Table [dbo].[Prescriptions]    Script Date: 12/1/2017 1:36:06 PM ******/
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
SET IDENTITY_INSERT [dbo].[Appointments] ON 

INSERT [dbo].[Appointments] ([AppointmentID], [DoctorID], [PatientID], [AppointmentDateTime], [Notes]) VALUES (1, 1, 1, CAST(N'2008-06-02T11:00:00.000' AS DateTime), N'No notes.')
INSERT [dbo].[Appointments] ([AppointmentID], [DoctorID], [PatientID], [AppointmentDateTime], [Notes]) VALUES (2, 1, 2, CAST(N'2008-06-02T11:30:00.000' AS DateTime), N'No notes.')
INSERT [dbo].[Appointments] ([AppointmentID], [DoctorID], [PatientID], [AppointmentDateTime], [Notes]) VALUES (3, 1, 3, CAST(N'2008-06-02T12:00:00.000' AS DateTime), N'No notes.')
INSERT [dbo].[Appointments] ([AppointmentID], [DoctorID], [PatientID], [AppointmentDateTime], [Notes]) VALUES (4, 1, 4, CAST(N'2008-06-02T11:30:00.000' AS DateTime), N'No notes.')
INSERT [dbo].[Appointments] ([AppointmentID], [DoctorID], [PatientID], [AppointmentDateTime], [Notes]) VALUES (5, 1, 10, CAST(N'2008-06-03T11:00:00.000' AS DateTime), N'No notes.')
INSERT [dbo].[Appointments] ([AppointmentID], [DoctorID], [PatientID], [AppointmentDateTime], [Notes]) VALUES (6, 1, 11, CAST(N'2008-06-03T11:30:00.000' AS DateTime), N'No notes.')
INSERT [dbo].[Appointments] ([AppointmentID], [DoctorID], [PatientID], [AppointmentDateTime], [Notes]) VALUES (7, 1, 12, CAST(N'2008-06-03T12:00:00.000' AS DateTime), N'No notes.')
INSERT [dbo].[Appointments] ([AppointmentID], [DoctorID], [PatientID], [AppointmentDateTime], [Notes]) VALUES (8, 2, 13, CAST(N'2008-06-03T11:00:00.000' AS DateTime), N'No notes.')
INSERT [dbo].[Appointments] ([AppointmentID], [DoctorID], [PatientID], [AppointmentDateTime], [Notes]) VALUES (9, 2, 14, CAST(N'2008-06-03T14:00:00.000' AS DateTime), N'No notes.')
SET IDENTITY_INSERT [dbo].[Appointments] OFF
SET IDENTITY_INSERT [dbo].[Doctors] ON 

INSERT [dbo].[Doctors] ([DoctorID], [FirstName], [LastName], [Specialty]) VALUES (1, N'Ian', N'Jenkins', N'Physiotherapy')
INSERT [dbo].[Doctors] ([DoctorID], [FirstName], [LastName], [Specialty]) VALUES (2, N'Chloe', N'Young', N'General')
INSERT [dbo].[Doctors] ([DoctorID], [FirstName], [LastName], [Specialty]) VALUES (3, N'Janet', N'Alvarez', N'Physiotherapy')
INSERT [dbo].[Doctors] ([DoctorID], [FirstName], [LastName], [Specialty]) VALUES (5, N'Sydney', N'Bennett', N'Haematology')
INSERT [dbo].[Doctors] ([DoctorID], [FirstName], [LastName], [Specialty]) VALUES (6, N'Carl', N'Andersen', N'Haematology')
INSERT [dbo].[Doctors] ([DoctorID], [FirstName], [LastName], [Specialty]) VALUES (7, N'Chad', N'Kumar', N'Obstetrics')
INSERT [dbo].[Doctors] ([DoctorID], [FirstName], [LastName], [Specialty]) VALUES (8, N'Stephanie', N'Flores', N'Physiotherapy')
SET IDENTITY_INSERT [dbo].[Doctors] OFF
SET IDENTITY_INSERT [dbo].[Patients] ON 

INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (1, N'Isabella', N'Young', N'F', CAST(N'1964-12-31T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (2, N'Justin', N'Harris', N'M', CAST(N'1966-02-01T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (3, N'Jenna', N'Parker', N'F', CAST(N'1974-12-05T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (4, N'Heidi', N'Chandra', N'F', CAST(N'1985-01-19T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (5, N'Richard', N'Garcia', N'M', CAST(N'1997-07-02T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (6, N'Jack', N'Phillips', N'M', CAST(N'1987-04-09T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (7, N'Katherine', N'Wright', N'F', CAST(N'1981-07-04T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (8, N'Joshua', N'Thompson', N'M', CAST(N'1972-01-04T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (9, N'Connor', N'Lopez', N'M', CAST(N'1992-11-30T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (10, N'Olivia', N'Torres', N'F', CAST(N'1974-09-27T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (11, N'Gabriel', N'Chow', N'M', CAST(N'1991-12-03T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (12, N'Fernando', N'King', N'M', CAST(N'1980-01-02T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (13, N'Derrick', N'Alonso', N'M', CAST(N'1984-06-07T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (14, N'Meghan', N'Gutierrez', N'F', CAST(N'1978-09-08T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (15, N'Jamie', N'Gao', N'M', CAST(N'1978-04-05T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (16, N'Aimee', N'Zhang', N'F', CAST(N'2000-09-02T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (17, N'Karen', N'Zeng', N'F', CAST(N'1988-03-04T00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Patients] ([PatientID], [FirstName], [LastName], [Gender], [DateOfBirth], [Photo]) VALUES (18, N'Barry', N'Subram', N'M', CAST(N'1956-01-10T00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Patients] OFF
SET IDENTITY_INSERT [dbo].[Prescriptions] ON 

INSERT [dbo].[Prescriptions] ([PrescriptionID], [PatientID], [Description], [IssueDate], [RepeatCount]) VALUES (1, 1, N'Anti-inflammatory medication', CAST(N'2008-01-01T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [PatientID], [Description], [IssueDate], [RepeatCount]) VALUES (2, 1, N'Iron tablets', CAST(N'2008-02-03T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [PatientID], [Description], [IssueDate], [RepeatCount]) VALUES (3, 1, N'Antibiotics', CAST(N'2008-05-04T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [PatientID], [Description], [IssueDate], [RepeatCount]) VALUES (4, 2, N'Anti-histamine capsules', CAST(N'2008-02-19T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [PatientID], [Description], [IssueDate], [RepeatCount]) VALUES (5, 2, N'Anti-malaria tablets', CAST(N'2008-05-06T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [PatientID], [Description], [IssueDate], [RepeatCount]) VALUES (6, 2, N'Water tablets', CAST(N'2008-03-04T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [PatientID], [Description], [IssueDate], [RepeatCount]) VALUES (7, 3, N'Gasto-resistant caplets', CAST(N'2008-05-02T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [PatientID], [Description], [IssueDate], [RepeatCount]) VALUES (8, 3, N'Anti-fungal cream', CAST(N'2008-01-31T00:00:00.000' AS DateTime), 4)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [PatientID], [Description], [IssueDate], [RepeatCount]) VALUES (9, 3, N'Psoriasis cream', CAST(N'2008-04-04T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[Prescriptions] ([PrescriptionID], [PatientID], [Description], [IssueDate], [RepeatCount]) VALUES (10, 4, N'Water tablets', CAST(N'2008-06-06T00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[Prescriptions] OFF
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

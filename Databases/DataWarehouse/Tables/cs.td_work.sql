USE [DataWarehouse]
GO
/****** Object:  Table [cs].[td_work]    Script Date: 22-11-2021 12.02.20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cs].[td_work](
	[workid_sk] [int] NOT NULL,
	[work_key] [nchar](18) NULL,
	[title] [varchar](1000) NULL,
	[subtitle] [varchar](100) NULL,
	[author_key] [nvarchar](max) NULL,
	[description] [varchar](max) NULL,
	[subjects] [nvarchar](max) NULL,
	[subject_places] [nvarchar](max) NULL,
	[subject_times] [nvarchar](max) NULL,
	[subject_people] [nvarchar](max) NULL,
	[first_publish_year] [varchar](100) NULL,
	[e_rowhash] [varbinary](8000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

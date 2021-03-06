USE [Demo]
GO
/****** Object:  Table [casestudy].[author]    Script Date: 22-11-2021 12.07.54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [casestudy].[author](
	[name] [varchar](100) NULL,
	[eastern_order] [int] NULL,
	[personal_name] [varchar](100) NULL,
	[enumeration] [varchar](100) NULL,
	[title] [varchar](100) NULL,
	[alternate_names] [nvarchar](max) NULL,
	[uris] [nvarchar](max) NULL,
	[bio] [varchar](max) NULL,
	[birth_date] [varchar](100) NULL,
	[death_date] [varchar](100) NULL,
	[date] [varchar](100) NULL,
	[wikipedia] [varchar](100) NULL,
	[links] [nvarchar](max) NULL,
	[location] [nvarchar](max) NULL,
	[key] [varchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

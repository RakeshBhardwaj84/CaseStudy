USE [DataWarehouse]
GO

/****** Object:  Table [cs].[td_author]    Script Date: 21-11-2021 11.58.46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [cs].[td_author](
	[authorid_sk] [int] NOT NULL,
	[author_key] [varchar](100) NULL,
	[title] [varchar](1000) NULL,
	[author_name] [varchar](100) NULL,
	[bio] [varchar](max) NULL,
	[birth_year] [varchar](100) NULL,
	[death_year] [varchar](100) NULL,
	[e_rowhash] [varbinary](8000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


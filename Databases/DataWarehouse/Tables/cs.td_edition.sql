USE [DataWarehouse]
GO
/****** Object:  Table [cs].[td_edition]    Script Date: 22-11-2021 12.02.20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cs].[td_edition](
	[editionid_sk] [int] NOT NULL,
	[edition_key] [varchar](100) NULL,
	[lang_sk] [int] NULL,
	[work_Key] [varchar](100) NULL,
	[title] [varchar](1000) NULL,
	[subtitle] [varchar](100) NULL,
	[author_key] [nvarchar](max) NULL,
	[publish_year] [varchar](100) NULL,
	[copyright_date] [varchar](100) NULL,
	[edition_name] [varchar](100) NULL,
	[genres] [nvarchar](max) NULL,
	[series] [nvarchar](max) NULL,
	[physical_dimensions] [varchar](100) NULL,
	[physical_format] [varchar](100) NULL,
	[number_of_pages] [int] NULL,
	[subjects] [nvarchar](max) NULL,
	[publish_places] [nvarchar](max) NULL,
	[publish_country] [varchar](100) NULL,
	[publishers] [nvarchar](max) NULL,
	[weight] [varchar](100) NULL,
	[e_rowhash] [varbinary](8000) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

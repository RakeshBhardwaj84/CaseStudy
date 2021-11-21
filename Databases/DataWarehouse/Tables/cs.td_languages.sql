USE [DataWarehouse]
GO
/****** Object:  Table [cs].[td_languages]    Script Date: 22-11-2021 12.02.20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cs].[td_languages](
	[Lang_sk] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](10) NULL,
	[Lang_Name] [varchar](100) NULL
) ON [PRIMARY]
GO

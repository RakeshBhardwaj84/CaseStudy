USE [DataWarehouse]
GO
/****** Object:  Table [cs].[td_publishers]    Script Date: 22-11-2021 12.02.20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cs].[td_publishers](
	[publisher_sk] [bigint] NULL,
	[publishers] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

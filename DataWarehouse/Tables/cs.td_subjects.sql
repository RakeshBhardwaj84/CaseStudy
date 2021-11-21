USE [DataWarehouse]
GO
/****** Object:  Table [cs].[td_subjects]    Script Date: 22-11-2021 12.02.20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cs].[td_subjects](
	[subject_sk] [bigint] NULL,
	[subjects] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

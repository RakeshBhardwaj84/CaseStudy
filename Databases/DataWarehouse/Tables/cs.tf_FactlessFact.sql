USE [DataWarehouse]
GO
/****** Object:  Table [cs].[tf_FactlessFact]    Script Date: 22-11-2021 12.02.20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cs].[tf_FactlessFact](
	[editionid_sk] [int] NOT NULL,
	[subject_sk] [bigint] NOT NULL,
	[Lang_sk] [int] NOT NULL,
	[genres_sk] [bigint] NOT NULL,
	[publisher_sk] [bigint] NOT NULL,
	[authorid_sk] [int] NOT NULL,
	[workid_sk] [int] NOT NULL
) ON [PRIMARY]
GO

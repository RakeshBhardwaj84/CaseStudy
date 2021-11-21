USE [DataWarehouse]
GO

/****** Object:  Table [cs].[td_author_sk]    Script Date: 21-11-2021 11.59.30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [cs].[td_author_sk](
	[authorID_sk] [int] IDENTITY(1,1) NOT NULL,
	[LastModifiedDttm] [datetime] NOT NULL,
	[author_key] [nchar](18) NULL,
PRIMARY KEY CLUSTERED 
(
	[authorID_sk] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [cs].[td_author_sk] ADD  DEFAULT (getdate()) FOR [LastModifiedDttm]
GO


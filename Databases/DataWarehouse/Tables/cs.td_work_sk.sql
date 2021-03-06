USE [DataWarehouse]
GO
/****** Object:  Table [cs].[td_work_sk]    Script Date: 22-11-2021 12.02.20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [cs].[td_work_sk](
	[WorkID_sk] [int] IDENTITY(1,1) NOT NULL,
	[LastModifiedDttm] [datetime] NOT NULL,
	[work_key] [nchar](18) NULL,
PRIMARY KEY CLUSTERED 
(
	[WorkID_sk] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [cs].[td_work_sk] ADD  DEFAULT (getdate()) FOR [LastModifiedDttm]
GO

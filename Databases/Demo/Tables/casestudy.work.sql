USE [Demo]
GO
/****** Object:  Table [casestudy].[Work]    Script Date: 22-11-2021 12.07.54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [casestudy].[Work](
	[title] [varchar](100) NULL,
	[subtitle] [varchar](100) NULL,
	[authors] [nvarchar](max) NULL,
	[translated_titles] [nvarchar](max) NULL,
	[subjects] [nvarchar](max) NULL,
	[subject_places] [nvarchar](max) NULL,
	[subject_times] [nvarchar](max) NULL,
	[subject_people] [nvarchar](max) NULL,
	[description] [varchar](max) NULL,
	[dewey_number] [nvarchar](max) NULL,
	[lc_classifications] [nvarchar](max) NULL,
	[first_sentence] [varchar](max) NULL,
	[original_languages] [nvarchar](max) NULL,
	[other_titles] [nvarchar](max) NULL,
	[first_publish_date] [varchar](100) NULL,
	[links] [nvarchar](max) NULL,
	[notes] [varchar](max) NULL,
	[cover_edition] [varchar](max) NULL,
	[covers] [nvarchar](max) NULL,
	[key] [varchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

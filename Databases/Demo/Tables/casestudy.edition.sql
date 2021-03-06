USE [Demo]
GO
/****** Object:  Table [casestudy].[edition]    Script Date: 22-11-2021 12.07.54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [casestudy].[edition](
	[title] [varchar](1000) NULL,
	[title_prefix] [varchar](100) NULL,
	[subtitle] [varchar](100) NULL,
	[other_titles] [nvarchar](max) NULL,
	[authors] [nvarchar](max) NULL,
	[by_statement] [varchar](100) NULL,
	[publish_date] [varchar](100) NULL,
	[copyright_date] [varchar](100) NULL,
	[edition_name] [varchar](100) NULL,
	[languages] [nvarchar](max) NULL,
	[description] [varchar](max) NULL,
	[notes] [varchar](max) NULL,
	[genres] [nvarchar](max) NULL,
	[table_of_contents] [nvarchar](max) NULL,
	[work_titles] [nvarchar](max) NULL,
	[series] [nvarchar](max) NULL,
	[physical_dimensions] [varchar](100) NULL,
	[physical_format] [varchar](100) NULL,
	[number_of_pages] [int] NULL,
	[subjects] [nvarchar](max) NULL,
	[pagination] [varchar](100) NULL,
	[lccn] [nvarchar](max) NULL,
	[ocaid] [varchar](100) NULL,
	[oclc_numbers] [nvarchar](max) NULL,
	[isbn_10] [nvarchar](max) NULL,
	[isbn_13] [nvarchar](max) NULL,
	[dewey_decimal_class] [nvarchar](max) NULL,
	[lc_classifications] [nvarchar](max) NULL,
	[contributions] [nvarchar](max) NULL,
	[publish_places] [nvarchar](max) NULL,
	[publish_country] [varchar](100) NULL,
	[publishers] [nvarchar](max) NULL,
	[distributors] [nvarchar](max) NULL,
	[first_sentence] [varchar](max) NULL,
	[weight] [varchar](100) NULL,
	[location] [nvarchar](max) NULL,
	[scan_on_demand] [int] NULL,
	[collections] [nvarchar](max) NULL,
	[uris] [nvarchar](max) NULL,
	[uri_descriptions] [nvarchar](max) NULL,
	[translation_of] [varchar](100) NULL,
	[works] [nvarchar](max) NULL,
	[source_records] [nvarchar](max) NULL,
	[translated_from] [nvarchar](max) NULL,
	[scan_records] [nvarchar](max) NULL,
	[volumes] [nvarchar](max) NULL,
	[accompanying_material] [varchar](100) NULL,
	[key] [varchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

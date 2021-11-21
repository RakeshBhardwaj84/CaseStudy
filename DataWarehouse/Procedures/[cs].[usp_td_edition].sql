	USE [DataWarehouse]
	GO


	DROP PROCEDURE IF EXISTS [cs].[usp_td_edition]
	GO


	SET ANSI_NULLS ON
	GO

	SET QUOTED_IDENTIFIER ON
	GO



	CREATE PROCEDURE [cs].[usp_td_edition] AS

	-- Populating SK table
	INSERT INTO [cs].[td_edition_sk]
	(
		[edition_key]
	 ,[LastModifiedDttm]
	)
	SELECT c.[Key]
		,GETDATE()
	FROM demo.casestudy.edition c
	LEFT JOIN DataWarehouse.cs.td_edition_sk es ON c.[key] = es.[edition_key]
	WHERE es.[edition_key] IS NULL;
/*
	-- Creating #lang table to spilt the comma seprated langauges and pipulate its sk
	drop table if exists #lang
	 SELECT a.edition_key,a.languages,l.lang_sk Into #lang FROM
	 (
	 SELECT
    tbl.id [edition_key],
    trim(Splita.a.value('.', 'NVARCHAR(MAX)')) [languages]    
    FROM
    (
        SELECT CAST('<X>'+REPLACE( [languages], ',', '</X><X>')+'</X>' AS XML) AS Col1,
             [key] as id

      FROM  demo.casestudy.edition 
    ) AS tbl
    CROSS APPLY Col1.nodes('/X') AS Splita(a)) a
	LEFT JOIN DataWarehouse.cs.td_languages l on a.languages = l.code

	-- Creating #Subjects table to spilt the comma seprated Subjects
	drop table if exists #Subjects
	 SELECT
    tbl.id [edition_key],
    trim(Splita.a.value('.', 'NVARCHAR(MAX)')) Subjects    INTO #Subjects
    FROM
    (
        SELECT CAST('<X>'+REPLACE( replace(subjects,'&','and'), '@@@', '</X><X>')+'</X>' AS XML) AS Col1,
             [key] as id

      FROM  demo.casestudy.edition 
    ) AS tbl
    CROSS APPLY Col1.nodes('/X') AS Splita(a)
	
	--Creating #genres table to spilt the comma seprated genres values
	drop table if exists #genres
	 SELECT
    tbl.id [edition_key],
     replace(trim(Splita.a.value('.', 'NVARCHAR(MAX)')),'.','')  genres into #genres 
	
    FROM
    (
        SELECT CAST('<X>'+REPLACE( genres, '@@@', '</X><X>')+'</X>' AS XML) AS Col1,genres,
             [key] as id

      FROM  demo.casestudy.edition 
    ) AS tbl
    CROSS APPLY Col1.nodes('/X') AS Splita(a)
	
	--Creating #publishers table to spilt the comma seprated publishers values
	drop table if exists #publishers
	 SELECT
    tbl.id [edition_key],
    trim(Splita.a.value('.', 'NVARCHAR(MAX)')) publishers    INTO #publishers
    FROM
    (
        SELECT CAST('<X>'+REPLACE( replace(replace(replace(replace(replace(replace(publishers,'&','and'),'<',''),'>',''),'[',''),']',''),'"',''), ',', '</X><X>')+'</X>' AS XML) AS Col1,
             [key] as id

      FROM  demo.casestudy.edition --where [key] = 'OL22907369M'
    ) AS tbl
    CROSS APPLY Col1.nodes('/X') AS Splita(a)
	*/
	-- Populating main dim table
	
select *  INTO #EMerge from 
(
SELECT distinct editionid_sk
		  ,
		  e.[key] as edition_key
		--	,l.lang_sk 
			,CONCAT([title_prefix],[title]) AS Title
		  ,[subtitle]
		--  , authors [author_key]
		  ,reverse(substring(reverse([publish_date]),1,4)) publish_year
		  ,[copyright_date]
		  ,[edition_name]
		 -- ,g.[genres]
		--  ,[series]
		  ,[physical_dimensions]
		  ,[physical_format]
		  ,[number_of_pages]
		 -- ,s.[subjects]
		  ,[publish_places]
		  ,[publish_country]
		 -- ,p.[publishers]
		  ,[weight]
		  ,replace(replace(replace(replace(replace([works],'{"key": "/works/',''),'[',''),']',''),'"',''),'}','') AS work_key
		  ,ROW_NUMBER() over (partition by e.[key] order by title, [physical_dimensions] desc) r
		
	  FROM [Demo].[casestudy].[edition] e
	  INNER JOIN  [DataWarehouse].[cs].[td_edition_sk](NOLOCK) csk ON e.[Key] = csk.[edition_key]
	--  LEFT JOIN  #lang l on l.edition_key = e.[key]
	 -- LEFT JOIN  #Subjects s on s.edition_key = e.[key]
	 -- LEFT JOIN #genres g on g.edition_key = e.[key]
	--  LEFT JOIN #publishers p on p.edition_key = e.[key]
	  where [title] is not null and number_of_pages >=20 and publish_date >'1950') a where a.r=1

	CREATE CLUSTERED INDEX CIX_E_MERGE ON #EMerge(editionid_sk);

	MERGE [cs].[td_edition] AS T USING
	(
	SELECT  #EMERGE.*
			,HASHBYTES('MD5',
			(SELECT  E_MergeRowHash.*
			FROM    #EMERGE AS E_MergeRowHash
			WHERE   E_MergeRowHash.editionid_sk = #EMERGE.editionid_sk
			FOR     XML RAW
			)) AS E_RowHash
	FROM    #EMERGE
	) AS S ON T.editionid_sk=S.editionid_sk

	WHEN MATCHED AND ISNULL(T.E_RowHash,-1) != S.E_RowHash THEN UPDATE
	SET
	T.editionid_sk= S.editionid_sk
	,T.[Title] = S.[Title]
	,T.[subtitle] = S.[subtitle]
	--,T.[lang_sk] = S.[lang_sk]
	--,T.[author_key] = S.[author_key]
	,T.[publish_year] = S.[publish_year]
	,T.[copyright_date] = S.[copyright_date]
	,T.[edition_name] = S.[edition_name]
	--,T.[genres] = S.[genres]
	--,T.[series] = S.[series]
	,T.[physical_dimensions] = S.[physical_dimensions]
	,T.[physical_format] = S.[physical_format]
	,T.[number_of_pages] = S.[number_of_pages]
	--,T.[subjects] = S.[subjects]
	,T.[publish_places] = S.[publish_places]
	,T.[publish_country] = S.[publish_country]
	--,T.[publishers] = S.[publishers]
	,T.[weight] = S.[weight]
	,T.[work_key] = S.[work_key]
	,T.[E_RowHash]=S.[E_RowHash]

	WHEN NOT MATCHED THEN INSERT (
			editionid_sk
		--	,lang_sk
			,[Title]
		  ,[subtitle]
		--  ,[author_key]
		  ,[publish_year]
		  ,[copyright_date]
		  ,[edition_name]
		 --,[genres]
		--  ,[series]
		  ,[physical_dimensions]
		  ,[physical_format]
		  ,[number_of_pages]
		--  ,[subjects]
		,[publish_places]
		  ,[publish_country]
		--  ,[publishers]
		  ,[weight]
		  
		  ,[work_key]
		  ,[edition_key]
	,[E_RowHash]
	)
	VALUES (
	S.editionid_sk
	--,S.lang_sk
	,S.[Title]
	,S.[subtitle]
	---,S.[author_key]
	,S.[publish_year]
	,S.[copyright_date]
	,S.[edition_name]
	--,S.[genres]
	--,S.[series]
	,S.[physical_dimensions]
	,S.[physical_format]
	,S.[number_of_pages]
	--,S.[subjects]
	,S.[publish_places]
	,S.[publish_country]
	--,S.[publishers]
	,S.[weight]
	,S.[work_key]
	,S.[edition_key]
	,S.[E_RowHash]
	);



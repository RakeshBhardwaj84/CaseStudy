USE [DataWarehouse]
GO


DROP PROCEDURE IF EXISTS [cs].[usp_td_work]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [cs].[usp_td_work] AS


INSERT INTO [cs].[td_work_sk]
(
	[work_key]
 ,[LastModifiedDttm]
)
SELECT c.[Key]
	,GETDATE()
FROM demo.casestudy.work c
LEFT JOIN DataWarehouse.cs.td_work_sk es ON c.[key] = es.[work_key]
WHERE es.[work_key] IS NULL;
/*
-- Creating #Subjects table to spilt the comma seprated Subjects
	drop table if exists #Subjects
	select *  INTO #Subjects from (
	SELECT
    tbl.id [EditionKey],
    trim(Splita.a.value('.', 'NVARCHAR(MAX)')) Subjects    
    FROM
    (
        SELECT CAST('<X>'+REPLACE( replace(subjects,'&','and'), '@@@', '</X><X>')+'</X>' AS XML) AS Col1,
             [key] as id

      FROM  [Demo].[casestudy].[work]
    ) AS tbl
    CROSS APPLY Col1.nodes('/X') AS Splita(a)) b where b.Subjects not like '%\u0%'  order by 2 
	*/
	select * INTO #EMerge 
	from ( 
	SELECT distinct [workid_sk],
			 replace( replace(replace([title],'"','')  ,'[',''),']','')   [title] 
			,[subtitle]
		--	,[authors] author_key
			--[translated_titles] NULL
			--,'' subjects--s.[subjects]
			--,[subject_places] 
			--,[subject_times]
			--,[subject_people]
			,[description]
			-- [dewey_number] Dosnt make sense
			-- [lc_classifications]
			-- [first_sentence] NULL
			--[original_languages] NULL
			--[other_titles] NULL
			, reverse(substring(reverse([first_publish_date]),1,4)) First_Publish_Year
			-- [links]
			-- [notes] NULL
			--[cover_edition] NULL
			-- [covers]
			,e.[key] as work_Key
			,ROW_NUMBER() over (partition by e.[key] order by title) r	  
	  FROM [Demo].[casestudy].[work] e
	  INNER JOIN [DataWarehouse].[cs].[td_work_sk](NOLOCK) csk ON e.[Key] = csk.[work_key]
	   where title not like '%?%'and authors is not null and authors not like '%"type%') a where r=1

CREATE CLUSTERED INDEX CIX_E_MERGE ON #EMerge(workid_sk);

MERGE [cs].[td_work] AS T USING
(
SELECT  #EMERGE.*
        ,HASHBYTES('MD5',
		(SELECT  E_MergeRowHash.*
        FROM    #EMERGE AS E_MergeRowHash
        WHERE   E_MergeRowHash.workid_sk = #EMERGE.workid_sk
        FOR     XML RAW
        )) AS E_RowHash
FROM    #EMERGE
) AS S ON T.workid_sk=S.workid_sk

WHEN MATCHED AND ISNULL(T.E_RowHash,-1) != S.E_RowHash THEN UPDATE
SET
T.[workid_sk] = S.[workid_sk]
,T.[title] = S.[title]      
,T.[subtitle] = S.[subtitle]
--,T.[author_key] = S.[author_key]
--,T.[subjects] = S.[subjects]
--,T.[subject_places] = S.[subject_places]
--,T.[subject_times] = S.[subject_times]
--,T.[subject_people] = S.[subject_people]
,T.[description] = S.[description]
,T.[First_Publish_Year] = S.[First_Publish_Year]
,T.[work_key]  = S.[work_key] 
,T.[E_RowHash]=S.[E_RowHash]

WHEN NOT MATCHED THEN INSERT (
		[workid_sk]
		,[title]      
		,[subtitle]
		--,[author_key]
		--,[subjects]
		--,[subject_places]
		--,[subject_times]
		--,[subject_people]
		,[description]
		,[First_Publish_Year]
		,[work_key] 
		,[E_RowHash]
)
VALUES (
S.[workid_sk]
		,S.[title]      
		,S.[subtitle]
		--,S.[author_key]
		--,S.[subjects]
		--,S.[subject_places]
		--,S.[subject_times]
		--,S.[subject_people]
		,S.[description]
		,S.[First_Publish_Year]
		,S.[work_key] 
		,S.[E_RowHash]
);



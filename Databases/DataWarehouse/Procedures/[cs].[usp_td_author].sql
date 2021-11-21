  USE [DataWarehouse]
GO


DROP PROCEDURE IF EXISTS [cs].[usp_td_author]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [cs].[usp_td_author] AS


INSERT INTO [cs].[td_author_sk]
(
	[author_key]
 ,[LastModifiedDttm]
)
SELECT c.[Key]
	,GETDATE()
FROM demo.casestudy.author c
LEFT JOIN DataWarehouse.cs.td_author_sk es ON c.[key] = es.[author_key]
WHERE es.[author_key] IS NULL;

select * 	 INTO #EMerge from 
(
SELECT distinct authorid_sk,
		ISNULL([name], [personal_name]) [author_name],
		--,[eastern_order] Null so can be removed
		-- [personal_name],
		-- [enumeration] Null so can be removed
		[title],
		--[alternate_names] Not required
		--  [uris]  Null so can be removed
		[bio],
		reverse(substring(reverse(birth_date),1,4)) birth_year,
		 reverse(substring(reverse(death_date),1,4)) death_year,
		--[date] Null so can be removed
		-- ,[wikipedia]
		--[links]
		--[location] Null so can be removed
		e.[key]as author_key
		,ROW_NUMBER() over (partition by e.[key] order by death_date desc, bio desc) r

  FROM [Demo].[casestudy].[author] e
  INNER JOIN [DataWarehouse].[cs].[td_author_sk](NOLOCK) csk ON e.[Key] = csk.[author_key]
  where [name] not like '%????%' ) a where a.r = 1

  
 -- where [title] is not null and number_of_pages >=20 and publish_date >'1950'

CREATE CLUSTERED INDEX CIX_E_MERGE ON #EMerge(authorid_sk);

MERGE [cs].[td_author] AS T USING
(
SELECT  #EMERGE.*
        ,HASHBYTES('MD5',
		(SELECT  E_MergeRowHash.*
        FROM    #EMERGE AS E_MergeRowHash
        WHERE   E_MergeRowHash.authorid_sk = #EMERGE.authorid_sk
        FOR     XML RAW
        )) AS E_RowHash
FROM    #EMERGE
) AS S ON T.authorid_sk=S.authorid_sk

WHEN MATCHED AND ISNULL(T.E_RowHash,-1) != S.E_RowHash THEN UPDATE
SET
T.[authorid_sk] = S.[authorid_sk]
,T.[author_name] = S.[author_name]
,T.[title] = S.[title]
,T.[bio] = S.[bio]
,T.[birth_year] = S.[birth_year]
,T.[death_year] = S.[death_year]
,T.[author_key] = S.[author_key]
,T.[E_RowHash]=S.[E_RowHash]

WHEN NOT MATCHED THEN INSERT (
		[authorid_sk]
		,[author_name]
		,[title]
		,[bio]
		,[birth_year]
		,[death_year]
		,[author_key] 
		,[E_RowHash]
)
VALUES (
		S.[authorid_sk]
		,S.[author_name]
		,S.[title]
		,S.[bio]
		,S.[birth_year]
		,S.[death_year]
		,S.[author_key]
		,S.[E_RowHash]
);


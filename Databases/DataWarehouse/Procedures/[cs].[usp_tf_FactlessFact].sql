USE [DataWarehouse]
GO


DROP PROCEDURE IF EXISTS [cs].[usp_tf_FactlessFact]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [cs].[usp_tf_FactlessFact] AS


drop table if exists #Subjects
	 SELECT
    tbl.id,
    trim(Splita.a.value('.', 'NVARCHAR(MAX)')) Subjects    INTO #Subjects
    FROM
    (
        SELECT CAST('<X>'+REPLACE( replace(subjects,'&','and'), '@@@', '</X><X>')+'</X>' AS XML) AS Col1,
             [key] as id

      FROM demo.casestudy.mv_o1_cdump 
    ) AS tbl
    CROSS APPLY Col1.nodes('/X') AS Splita(a)

	drop table if exists #lang
	 SELECT a.id,a.languages,l.lang_sk Into #lang FROM
	 (
	 SELECT
    tbl.id,
    trim(Splita.a.value('.', 'NVARCHAR(MAX)')) [languages]    
    FROM
    (
        SELECT CAST('<X>'+REPLACE( [languages], ',', '</X><X>')+'</X>' AS XML) AS Col1,
             [key] as id

      FROM  demo.casestudy.mv_o1_cdump where [type] = 'edition'
    ) AS tbl
    CROSS APPLY Col1.nodes('/X') AS Splita(a)) a
	LEFT JOIN DataWarehouse.cs.td_languages l on a.languages = l.code

	drop table if exists #genres
	 SELECT
    tbl.id ,
     replace(trim(Splita.a.value('.', 'NVARCHAR(MAX)')),'.','')  genres into #genres 
	
    FROM
    (
        SELECT CAST('<X>'+REPLACE( genres, '@@@', '</X><X>')+'</X>' AS XML) AS Col1,genres,
             [key] as id

      FROM  demo.casestudy.mv_o1_cdump  
    ) AS tbl
    CROSS APPLY Col1.nodes('/X') AS Splita(a)

	drop table if exists #publishers
	 SELECT
    tbl.id ,
    trim(Splita.a.value('.', 'NVARCHAR(MAX)')) publishers    INTO #publishers
    FROM
    (
        SELECT CAST('<X>'+REPLACE( replace(replace(replace(replace(replace(replace(publishers,'&','and'),'<',''),'>',''),'[',''),']',''),'"',''), ',', '</X><X>')+'</X>' AS XML) AS Col1,
             [key] as id

      FROM   demo.casestudy.mv_o1_cdump  --where [key] = 'OL22907369M'
    ) AS tbl
    CROSS APPLY Col1.nodes('/X') AS Splita(a)

	drop table if exists #authors
	 SELECT
    tbl.id ,
     replace(trim(Splita.a.value('.', 'NVARCHAR(MAX)')),'.','')  authors into #authors 
	
    FROM
    (
        SELECT CAST('<X>'+REPLACE( authors, ',', '</X><X>')+'</X>' AS XML) AS Col1,genres,
             [key] as id

      FROM  demo.casestudy.mv_o1_cdump  
    ) AS tbl
    CROSS APPLY Col1.nodes('/X') AS Splita(a)

	
	drop table   if exists cs.tf_FactlessFact
	select 
	ISNULL(editionid_sk,-1) editionid_sk,
	ISNULL(subject_sk,-1) subject_sk,
	ISNULL(Lang_sk,-1) Lang_sk,
	ISNULL(genres_sk,-1) genres_sk,
	ISNULL(publisher_sk,-1) publisher_sk,
	ISNULL(authorid_sk,-1) authorid_sk,
	ISNULL(workid_sk,-1) workid_sk
	INTO cs.tf_FactlessFact 
	from 
	(
	select distinct e.editionid_sk,ts.subject_sk,tl.Lang_sk,tg.genres_sk,tp.publisher_sk ,ta.authorid_sk,w.workid_sk
	from demo.casestudy.mv_o1_cdump  o 
	INNER JOIN cs.td_edition e on e.edition_key = o. [key]
	LEFT JOIN cs.td_work w on w.work_key = e.work_Key
	LEFT JOIN #Subjects s on s.id = o.[key] 
	LEFT JOIN cs.td_subjects ts on ts.subjects = s.Subjects
	LEFT JOIN #lang l on l.id = o.[key]  
	LEFT JOIN cs.td_languages tl on tl.Code = l.languages
	LEFT JOIN #genres g on g.id = o.[key] 
	LEFT JOIN cs.td_genres tg on tg.genres = g.genres
	LEFT JOIN #publishers p on p.id =o.[key] 
	LEFT JOIN cs.td_publishers tp on tp.publishers = p.publishers
	LEFT JOIN #authors a on a.id = o.[key]  
	LEFT JOIN cs.td_author ta on ta.author_key = a.authors
	where e.edition_key is not null 
	UNION
		select distinct NULL editionid_sk,ts.subject_sk,NULL as Lang_sk, NULL as genres_sk, NULL AS publisher_sk ,ta.authorid_sk,e.workid_sk
	from demo.casestudy.mv_o1_cdump  o 
	INNER JOIN cs.td_work e on e.work_key = o. [key]
	LEFT JOIN #Subjects s on s.id = o.[key] 
	LEFT JOIN cs.td_subjects ts on ts.subjects = s.Subjects
	LEFT JOIN #authors a on a.id = o.[key]  
	LEFT JOIN cs.td_author ta on ta.author_key = a.authors
	where e.workid_sk is not null) a



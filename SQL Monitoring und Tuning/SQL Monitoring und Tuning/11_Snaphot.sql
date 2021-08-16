--Snapshot


/*
100GB datei in OrgDB

--> SNDB 100GB Datei




*/

-- =============================================
-- Create Database Snapshot Template
-- =============================================
USE master
GO



-- Create the database snapshot
CREATE DATABASE SNNWind1000 ON
( NAME = northwind,
FILENAME = 'D:\_SQLDB\nwindsn1000.mdf' ),
( NAME = nhot,
FILENAME = 'D:\_SQLDB\nhot1000.ndf' )
AS SNAPSHOT OF northwind;
GO

--Restore... Achtung.. keine Connections 
--auf Snapshot und OrigDatenbank erlaubt
restore database northwind from 
database_Snapshot = 'SNNWind1000'
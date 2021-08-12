/*

Securty: Auth (NT oder gemischte Auth) ,sysadmin
Instanzname

Dienstkonten: NT Service\SQLAgent$FE
			  verwaltete Dienstkonto

Pfade für
		Programmdateien
		SystemDbs
		UserdbDatendateien
		UserDBLogdateien
		Backup
		tempdbdatendatei
		temepdblogdatei

		--verschiedene Pfade, weil
		!!!  Trenne Daten von Log per HDD



		TempDB
		Inhalt: #tabellen, Zeilenversionierung, IX Rebuild, Auslagerung
			eig HDDs
				trenne Log von Daten

			sollte soviele Datendateien wie Cores (max 8)
			T1117 alle Dateien werden immer gleich groß sein
			--weil immer in die größte geschr werden würde..
			T1118

		Arbeitsspeicher:
			MIN 0 (wenn keine andere Instanz)
				Garatie: Speicher wird behalten, aber er muss erst erreicht werden
			MAX Gesamt -OS (2-3)

	Dienstkonto bekommt Rechte für Volumewartungstask
	kein SQL Einstellung

	windows würde die Vergrößerung übernhemen und mit 0 zuerst befüllen
	-------------------------
	111101010101010111111010
	-------------------------
	setzt man den Haken, dann kein Ausnullen


	--mir wäre da wurscht!!


MAXDOP


*/

--Spielwiese


SELECT        Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Orders.OrderDate, Orders.EmployeeID, Orders.Freight, Orders.ShipName, 
                         Orders.ShipCity, Orders.ShipCountry, [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName, Products.UnitsInStock, Employees.LastName, 
                         Employees.FirstName
INTO KU
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID

--solange wiederhilen bis ca 1,1 Mio in KU sind
insert into KU
select * from ku --letzetr Durchagng 9 Sek


select * into ku1 from ku --3 Sek

alter table ku1 add id int identity --9 Sek

--Summe aller Frachtkosten pro Stadt in einem best Land
select country, city,SUM(freight) from ku1
group by country, city

--Kosten= SQL Dollar
--Doppelpfeile = mehr CPUs verwendet

set statistics io, time on-- CPU Dauer in ms, ges Dauer in ms, Anzahl der Seiten
select country, city,SUM(freight) from ku1
group by country, city
--350 ms CPU 120 ms  65000
--375 ms      173ms   62000 

--mehr CPU verbrauche als Dauer, hat sich auf jeden Fall mehr CPUs sich gelohnt
--wieviele CPUS nimmt sql pro Abfrage denn her
--4 8 

--SQL verwendet ab (default) 5 SQL Dollar alle CPUs

--KOstenlimit 50
--230ms

--ab 5 .. 4 CPus
--Dauer 90 ms.. CPU 370ms.. 4 CPUs tun nix

--Regel: Setzte den KOstenschwellwert auf 25 oder 50
--OLAP 25  OLTP 50

--gilt für ganzen Server..
--Scoped Database--> Northwind maxcpu=4

select country, city,SUM(freight) from ku1
group by country, city option (maxdop 2)

set statistics io, time off

USE [Northwind]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 4;
GO
EXEC sys.sp_configure N'cost threshold for parallelism', N'25'
GO
EXEC sys.sp_configure N'max degree of parallelism', N'6'
GO
RECONFIGURE WITH OVERRIDE
GO


--os_wait_Stats

select * from sys.dm_os_wait_Stats where wait_type like 'CX%'






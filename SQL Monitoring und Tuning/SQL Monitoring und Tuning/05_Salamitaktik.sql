/*
TAB A 10
TAB B 100000000000000000000000000000000000000000000

Abfrage --> 10 Zeilen


A und B absolut identisch 

Welche Tabelle wird eher eine Aergbnis zurückgeben?

kleine Tabellen sind schneller--> 




*/



--Kompression
--Seiten (zuerst Seitenkompression)
--Zeilen (Entlüften und zusammenfassen)
-- 40-60%


--1. Neustart des SQL Server: RAM : 623
--2. 
set statistics io, time on 
select * from testdb..t1

--Seiten:20000   CPU: 328 ms  Dauer:  2768    RAM: 780  +160MB

--1. Tab komprimieren
--wie groß vermutlich: 95%  wie groß wirklich: 350kb
--1. Neustart des SQL Server: geschätzt RAM : gleich oder weniger    tatsächlicher RAM
--2. 
set statistics io, time on 
select * from testdb..t1
--geschätzt
--Seiten: weniger  CPU: weniger  Dauer: weniger oder mehr     
--tats
--Seiten: 31  CPU:  gleich (in Praxis eher steigend)   Dauer: etwas weniger (in Praxis etwa gleich)
--RAM: 620-->621
--Kompression zugunsten der anderen
--wieos nicht gleich die DB komprimieren


------------IDEE 2 part Sicht

--UMSATZ Tabelle

--U2021 U2020 u2019

create table u2021 (id int , jahr int, spx int)

create table u2020 (id int , jahr int, spx int)

create table u2019 (id int , jahr int, spx int)


select * from umsatz

create view umsatz
as
select * from u2021
UNION ALL
select * from u2020
UNION ALL
select * from u2019



select * from umsatz where id = 2020
select * from umsatz where jahr = 2019

--TÜV Siegel 
ALTER TABLE dbo.u2019 ADD CONSTRAINT
	CK_u2019 CHECK (jahr=2019)

ALTER TABLE dbo.u2021 ADD CONSTRAINT
	CK_u2021 CHECK (jahr=2021)

ALTER TABLE dbo.u2020 ADD CONSTRAINT
	CK_u2020 CHECK (jahr=2020)

--Aber .. INS UP DEL geht nur über die Sicht, wenn kein Identity, der PK muss den DS eindeutig in der Sicht! machen

----bei Änderungen: Tab anlegen , PK , Sicht anpassen check



--Dateigruppen


create table t3(id int) on HOT

--Partitionierung

--4 DGruppen: bis100, bis200 bis5000 rest


--Part F()

--------------100-----------------------200-----------------------------
--   1					2							3

create partition function fzahl(int) --varchar, char, datetime, money,
as
RANGE LEFT FOR VALUES(100,200)

select $partition.fzahl(117) --2  --15000m Bereiche möglich


create partition scheme schZahl
as
partition fzahl to (bis100,bis200,rest)
---                   1      2    3
create table ptab (id int identity, nummer int, spx char(4100)) --so auf Primary
ON schZahl(nummer)


set statistics io, time off

declare @i as int = 1
begin tran
while @i<=20000
	begin 
		insert into ptab select @i, 'XY'
		set @i+=1   --set @i=+1
	end
commit
--PLAN: SCAN  .. Suche von A bis Z
--      SEEK  .. Herauspicken

set statistics io, time on
select * from ptab where nummer = 117
select * from ptab where id= 117


--kleiner SCANs!!


select * from ptab where nummer = 1117


--neue Grenze bei 5000

--f(), schema, Tab ,DGR

--1. neue Dgruppe   bis5000
--2 schema
alter partition scheme schZahl next  used bis5000 --schema kennt 4 DGr

alter partition function fzahl() split range(5000)

select * from ptab where nummer = 1117

----------100--------------200-----------------5000------------

--f()  



alter partition function fzahl() merge range (100)

select * from ptab where nummer = 117

--Archiv

create table archiv(id int not null, nummer int, spx char(4100)) on bis200 

alter table ptab switch partition 1 to archiv

select * from archiv

where .. '%A' and 

Volltextsuche

select * from ptab

--100MB/sek  1000MB ->2ms
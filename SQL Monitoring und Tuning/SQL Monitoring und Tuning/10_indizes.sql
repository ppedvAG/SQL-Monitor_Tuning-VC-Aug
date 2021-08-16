/*
CL IX   Gruppiert
gut bei Bereichsabfrage auch wenn mehr rauskommt
nur einmal pro Tab


NON CL  Nicht Gruppierte
gut bei: rel geringer Ergebnismenge
	oft bei PK indentity guid
	ca 1000

Dilemma: der PK wird immer als CL IX eindeutig generiert
--obwohl der PK auch N CL sein könnte
--also zuerst den CL festlegen .. alles ander nur och NON CL


vermeide Lookup

----------------------------
eindeutigen IX  x
gefilterten IX nicht mehr alle enthalten
part IX
IX mit eingeschl Spalten ca 1023 ..Lookup vermeiden...cool
zusammengesetzten IX max 16 Spalten 900bytes.. was bei Select * ;-(
abdeckender IX * ergibt sich einfach.. reine Seeks
realen hypth IX
ind Sicht y
-----------------------------

ColumnStore (gr und ngr) 

Überflüssige IX


IX Strategie

Fehlende IX




create table ---> HEAP

IX nur von Interesse bei:

where
		<
		>
		=
		like
		in
		between






*/

select * from best  --T scan

set statistics io, time on
select top 3 * from ku1

select ID from ku1 where id=100 -- TAB SCAN  60326  250ms

---Fix: CL IX orderdate

select ID from ku1 where id = 100 --IX Seek 0 ms  3 Seiten

select id , freight from ku1 where id = 100 --IX Seek mit Lookup 4 Seiten 0 ms

select id , freight from ku1 where id < 100  --99% für Lookup

select id , freight from ku1 where id < 11980  --99% für Lookup


--besser wenn die freight tmit im IX wäre
--NIX_IDFR zusammengestzter IX
--kann nur 16 Spalten haben 
--nur max 900byte

select id , freight from ku1 where id < 800000 --immer noch IX Seek



select country, city, SUM(unitprice*quantity) 
from ku1
where EmployeeID = 5 and ShipCity = 'Berlin'
group by Country, City

--NIX_EIDSC_i_cyciupqu


--

--geht besser mit IX_ID_i_FR mit eingeschl.
--wir können ca 1000 Spalten einschliessen

select id , freight from ku1 where id <800000


select country, city, SUM(unitprice*quantity) 
from ku1
where EmployeeID = 5 or ShipCity = 'Berlin'
group by Country, City


--2 Indizes
--NIX_EID_i_cy_ci_up_qu_SC
--NIX_SC_i_cy_ci_up_qu_EID


--Ind Sicht
select country, COUNT(*) from ku1
group by country

create view v1 
as
select country, COUNT(*) as Anz from ku1
group by country

select * from v1--..scan

select country, COUNT(*) from ku1
group by country


alter  view v1 with schemabinding
as
select country, COUNT_BIG(*) as Anz from dbo.ku1
group by country



select * from v1--..scan


select country, COUNT(*) as Anz from ku1
group by country


--geht nicht bei : wenn kein COUNT_BIG




------
select * into ku2 from ku1

select top 3 * from ku2





--where agg
select country, SUM(quantity) from ku1
where YEAR(OrderDate) = 1998  --scan zwang
group by country

select country, SUM(quantity) from ku1
where OrderDate between '1.1.1998' and '31.12.1998' --IX Seek
group by country

--NIX_OD_i_cy_qu

select country, SUM(quantity) from ku2
where OrderDate between '1.1.1997' and '31.12.1997' --IX Seek
group by country

----:-|  statt 480MB 3,5 MB und schneller

--hat sie 3,5 oder nicht
--es sind 3,5MB --> kompression-- nach Arhievierungskompr...--> 3,0MB

---> auch im RAM




select * from sys.dm_db_index_usage_stats

--indexid=0 Heap
--       1 CL IX
--    > 1 NON CL IX
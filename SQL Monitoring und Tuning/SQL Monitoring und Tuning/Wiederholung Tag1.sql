--

/*
RAM
CPU
HDD


1 HDD
  Seiten 
  Messung: set statistics io,time

  Plan .. der kann lügen

  SEEK
  SCAN



  Abfragespeicher

  Massnahmen zur Reduzierung von IO

  Kompression (40-60)
  Partitionierung 
  f() + PartSchema ü Tab auf Schema
   

*/

create partition function fDatum(datetime)
as
range left for values ('31.12.2020 23:59:59.999','','',...)

-----------31.12.2021----31.12.2023-----31.12.2030---
--1                     2               3

-- a bis m     n  bis s   t bis z
create partition function fNamen(varchar(50))
as
range left for values ('n','t','',...)
--Grenzen sind harte Grenzen
--M < Maier

--Funktionen kann man verwenden, allerdings wird nur bei
--DML (up, del, ins) der Wert interpretiert..
--also keine ständige Hintergrundüberwachung



create partition scheme schXY
as
partition fzahl to ([PRIMARY],[PRIMARY],[PRIMARY])

--geht und macht sinn...
--als ob es viele kleine Tabellen wäre









create database testdb


/*
Wie gro� ist die DB?
8MBLog
8MB Daten
----
16MB

Um wieivel MB w�chst die DB?
Daten +64MB
Log   +64MB

2014
5+2
Log 10%
Datendatei um 1 MB

Wo liegen die Dateien.. mdf ldf

--Trenne Log und Daten bei jeder DB extra. und evtl eige HDD in Betracht ziehen

*/

use testdb

create table t1 (id int identity, spx char(4100))


--keine StatMessung, keine Planausgabe
insert into t1
select 'XY'
GO 20000 ---21 Sekunden... 48 


/*
wie gro� ist ein DS?

1 DS ca 4k * 20000 = 80MB
hat aber 160MB

7 Vergr��erungen pro Sek... teilw 15  5 bois 15 ms
8 Vergr. 

Regel: wir wollen gar keine Verg��erung
--also machen wir die Dateien gr��er


--Wie gro� sollte man die Dateien machen?
--evt Verg��erung nicht mit 64MB sinde3rn eher Richtung 1 GB
--Tipp:Logile mit 1 GB   (VLF)
--idelae Logile wird nie gr��er und hat max 75% F�llgrad


Wieso hatte eigtl die t1 160MB 


*/

create table t2 (id int identity, spx char(4100))


--keine StatMessung, keine Planausgabe
insert into t2
select 'XY'
GO 20000 ---21 Sekunden... 48 


--Wie ist eigtl das DB Design der Tabellen?

--Redundanzen
--Normalisierung
-- 1NF : jede Zelle hat nur einen Wert
-- 2NF : jeder DS hat einen PK
-- 3NF : wenWerte ausserhalb des PK nicht in Wechselwirkung

--schau auf die Datentypen

'otto'
char(50)    'otto                                 '   50
varchar(50)  'otto'    4
nchar(50)      'otto                                ' 100
nvarchar(50)  'otto'             8


datetime (ms)
date 
smalldatetime (sek)
datetime2 (ns)
datetimeoffset (ns + Zeizone)
time 




*/
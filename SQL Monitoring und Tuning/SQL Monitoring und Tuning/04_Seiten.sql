/*
1 Seite hat immer 8192bytes (Page)
8 Seiten am Stück = Block (Extent)
1 Seite kann nie mehr als 700 DS enthalten
1 DS kann nicht größer werden als 8060bytes
1 DS muss in (fast immer) Seite passen
für DS sind maxc 8072 bytes vorgesehen


1MIO DS a 4100byte ==>  1 MIO Seiten * 8kb ==> 8GB
1 MIO A a 4000  ==> 500.000 Seiten         ==> 4GB
1 MIO B  a 100 ==> 12500 Seiten			   ==> 110 MB

Seiten kommen beim Lesen 1:1 in RAM

Kann man den Effekt irgendwo nachschauen?

dbcc showcontig()


Regel: Untersuche die Tabelle nicht nur auf Datentypen , 
--sondern auch auf die Physik die darunter liegt

*/

create table t3 (id int, sp1 char(4100), sp2 char(4100))
--Error on 8060 Bytes


dbcc showcontig('t1')
--- Gescannte Seiten.............................: 20000
--- Mittlere Seitendichte (voll).....................: 50.79%


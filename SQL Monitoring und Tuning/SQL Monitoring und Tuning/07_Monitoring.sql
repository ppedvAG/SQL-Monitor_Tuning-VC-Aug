/*

aktuelles Problem

Taskmanager evtl fremde Prozesse, Peakwerte HDD

Aktivitätsmonitor

---QUERY--> Worker (untersucht Ressource)---------> Ress Parat---CPU
              SUSPENDED  LCK_M_S                      RUNNABLE    RUNNING

*/


dbcc showcontig('ku1')
set statistics io on
select * from ku1 where companyname like'%alf%'

--alter table add id

select * from sys.dm_db_index_physical_stats(db_id(), object_id('ku1'), NULL, NULL, 'detailed')




select * from sys.dm_os_wait_stats


--ABFR----------------------50ms---------------70ms
--0ms

--wait time kummuierende Zeiten   70
--signaltime .. Dauer bis CPU anfängt zu arbeiten 20     70-20= 50


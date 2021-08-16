CREATE EVENT SESSION [DemoWien] ON SERVER 
ADD EVENT sqlserver.sp_statement_completed(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'Northwind'))),
ADD EVENT sqlserver.sql_batch_completed(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'Northwind'))),
ADD EVENT sqlserver.sql_batch_starting(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'Northwind')))
ADD TARGET package0.event_file(SET filename=N'D:\_BACKUP\demowien.xel'),
ADD TARGET package0.histogram(SET source=N'sqlserver.sql_text'),
ADD TARGET package0.ring_buffer(SET max_memory=(102400))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO



--Locks
CREATE EVENT SESSION [LockCounts] ON SERVER 
ADD EVENT sqlserver.lock_acquired(
    ACTION(sqlserver.sql_text)
    WHERE ([database_id]=(5))),
ADD EVENT sqlserver.lock_deadlock(
    ACTION(sqlserver.sql_text)),
ADD EVENT sqlserver.lock_deadlock_chain(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[database_name]=N'')),
ADD EVENT sqlserver.sp_statement_completed(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'northwind'))),
ADD EVENT sqlserver.sp_statement_starting(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'northwind'))),
ADD EVENT sqlserver.sql_statement_completed(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'northwind'))),
ADD EVENT sqlserver.sql_statement_starting(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'northwind'))),
ADD EVENT sqlserver.xml_deadlock_report(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[database_name]=N''))
ADD TARGET package0.histogram(SET filtering_event_name=N'sqlserver.lock_acquired',source=N'resource_type',source_type=(0)),
ADD TARGET package0.ring_buffer(SET max_memory=(102400))
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO


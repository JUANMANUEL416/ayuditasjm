SELECT 
    s.session_id,
    s.login_name,
    s.host_name,
    s.program_name,
    t.transaction_id,
    t.name AS transaction_name,
    t.transaction_begin_time,
    DATEDIFF(MINUTE, t.transaction_begin_time, GETDATE()) AS transaction_duration_minutes,
    DB_NAME() AS database_name
FROM 
    sys.dm_tran_active_transactions t
    JOIN sys.dm_tran_session_transactions st ON t.transaction_id = st.transaction_id
    JOIN sys.dm_exec_sessions s ON st.session_id = s.session_id
WHERE 
    t.transaction_type = 1 -- Solo transacciones de usuario
ORDER BY 
    t.transaction_begin_time;

    KILL 165;
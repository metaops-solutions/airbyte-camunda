{{ config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = 'id'
) }}

{% if not is_incremental() %}

SELECT DISTINCT ON (id)
    id, state, endtime, starttime, businesskey, removaltime, startactivityid, durationinmillis, processdefinitionid, processdefinitionkey, processdefinitionname, rootprocessinstanceid, superprocessinstanceid, processdefinitionversion 
FROM (  SELECT id, state, endtime, starttime, businesskey, removaltime, startactivityid, durationinmillis, processdefinitionid, processdefinitionkey, processdefinitionname, rootprocessinstanceid, superprocessinstanceid, processdefinitionversion FROM process_instance_startedafter
        UNION  
        SELECT id, state, endtime, starttime, businesskey, removaltime, startactivityid, durationinmillis, processdefinitionid, processdefinitionkey, processdefinitionname, rootprocessinstanceid, superprocessinstanceid, processdefinitionversion FROM process_instance_finishedafter
) AS merged 
ORDER BY id, endtime

{% else %}

SELECT DISTINCT ON (id)
    id, state, endtime, starttime, businesskey, removaltime, startactivityid, durationinmillis, processdefinitionid, processdefinitionkey, processdefinitionname, rootprocessinstanceid, superprocessinstanceid, processdefinitionversion 
FROM (  SELECT id, state, endtime, starttime, businesskey, removaltime, startactivityid, durationinmillis, processdefinitionid, processdefinitionkey, processdefinitionname, rootprocessinstanceid, superprocessinstanceid, processdefinitionversion FROM process_instance_startedafter
        UNION  
        SELECT id, state, endtime, starttime, businesskey, removaltime, startactivityid, durationinmillis, processdefinitionid, processdefinitionkey, processdefinitionname, rootprocessinstanceid, superprocessinstanceid, processdefinitionversion FROM process_instance_finishedafter
) AS merged 
ORDER BY id, endtime

{% endif %}



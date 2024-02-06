SELECT
    activities.id,
    activities.starttime,
    activities.endtime,
    EXTRACT(EPOCH FROM (activities.endtime - activities.starttime)) as duration_seconds,
    activities.activityid,
    activities.activityname,
    processes.id as processes_id,
    processes.processdefinitionname
FROM {{ ref('fct_activities') }} as activities
LEFT JOIN {{ ref('fct_processes') }} as processes
ON ( activities.processinstanceid = processes.id )
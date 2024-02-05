SELECT
    id,
    starttime,
    endtime,
    activityid,
    activityname,
    processinstanceid,
    processdefinitionkey
FROM {{ ref('stg_activity_instance') }} as activities

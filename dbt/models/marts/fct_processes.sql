SELECT
    id,
    starttime,
    endtime,
    businesskey,
    state,
    processdefinitionkey,
    processdefinitionname
FROM {{ ref('stg_process_instance') }} as processes
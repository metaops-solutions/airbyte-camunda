SELECT
    tasks.id, 
    tasks.processInstanceId, 
    tasks.caseInstanceId, 
    tasks.activityInstanceId, 
    tasks.name, 
    tasks.description, 
    tasks.owner, 
    tasks.assignee, 
    tasks.startTime, 
    tasks.endTime,
    tasks.duration,
    EXTRACT(EPOCH FROM (tasks.endTime - tasks.startTime)) as duration_seconds,
    processes.processdefinitionname,
    processes.businesskey as processes_businesskey,
    cases.caseDefinitionName,
    cases.businesskey as cases_businesskey,
    activities.activityname
FROM {{ ref('fct_tasks') }} as tasks
LEFT JOIN {{ ref('fct_processes') }} as processes
ON ( tasks.processInstanceId = processes.id )
LEFT JOIN {{ ref('fct_cases') }} as cases
ON ( tasks.caseInstanceId = cases.id )
LEFT JOIN {{ ref('fct_activities') }} as activities
ON ( tasks.activityInstanceId = activities.id )
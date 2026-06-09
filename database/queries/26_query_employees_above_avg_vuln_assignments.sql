WITH TaskCounts AS (
    SELECT executor_user_id, COUNT(*) AS tasks 
    FROM public.remediation_task GROUP BY executor_user_id
)
SELECT u.username, tc.tasks 
FROM TaskCounts tc
JOIN public.user_account u ON tc.executor_user_id = u.id
WHERE tc.tasks > (SELECT AVG(tasks) FROM TaskCounts);
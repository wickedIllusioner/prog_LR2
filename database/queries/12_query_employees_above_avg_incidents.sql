WITH UserIncidentCounts AS (
    SELECT responsible_user_id, COUNT(*) AS inc_count 
    FROM public.incident GROUP BY responsible_user_id
),
AvgIncidents AS (
    SELECT AVG(inc_count) AS avg_count FROM UserIncidentCounts
)
SELECT u.username, uic.inc_count
FROM UserIncidentCounts uic
JOIN public.user_account u ON uic.responsible_user_id = u.id
WHERE uic.inc_count > (SELECT avg_count FROM AvgIncidents);
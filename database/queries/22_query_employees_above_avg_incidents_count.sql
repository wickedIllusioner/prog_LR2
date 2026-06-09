WITH UserStats AS (
    SELECT responsible_user_id, COUNT(*) AS total_incidents,
           AVG(COUNT(*)) OVER () AS system_avg
    FROM public.incident
    GROUP BY responsible_user_id
)
SELECT u.username, s.total_incidents 
FROM UserStats s
JOIN public.user_account u ON s.responsible_user_id = u.id
WHERE s.total_incidents > s.system_avg;
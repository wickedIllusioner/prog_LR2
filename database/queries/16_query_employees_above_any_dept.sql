SELECT u.username, COUNT(rt.id) AS tasks_count
FROM public.remediation_task rt
JOIN public.user_account u ON rt.executor_user_id = u.id
GROUP BY u.id, u.username
HAVING COUNT(rt.id) > ALL (
    SELECT COUNT(rt2.id)
    FROM public.remediation_task rt2
    JOIN public.user_account u2 ON rt2.executor_user_id = u2.id
    JOIN public.department d ON u2.department_id = d.id
    WHERE d.name = 'Отдел системного администрирования'
    GROUP BY u2.id
);
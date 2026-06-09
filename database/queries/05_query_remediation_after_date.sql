SELECT rt.id, u.username, rt.deadline 
FROM public.remediation_task rt
JOIN public.user_account u ON rt.executor_user_id = u.id
WHERE rt.status = 'Готово' AND rt.deadline > '2026-06-01';
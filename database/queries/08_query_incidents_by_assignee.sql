SELECT i.title, i.status, i.created_at 
FROM public.incident i
JOIN public.user_account u ON i.responsible_user_id = u.id
WHERE u.username = 'smirnov_sab';
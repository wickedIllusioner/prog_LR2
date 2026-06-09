SELECT id, title, priority, status, created_at 
FROM public.incident 
WHERE status NOT IN ('Закрыт', 'Устранен');
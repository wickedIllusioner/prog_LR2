SELECT id, title, created_at 
FROM public.incident
WHERE created_at > (
    SELECT TO_TIMESTAMP(AVG(EXTRACT(EPOCH FROM created_at))) 
    FROM public.incident
);
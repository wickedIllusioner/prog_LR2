SELECT hostname, ip_address, commissioned_at 
FROM public.asset 
WHERE commissioned_at >= '2026-01-01 00:00:00';
SELECT a.hostname, a.ip_address, ag.name AS group_name 
FROM public.asset a
JOIN public.asset_group ag ON a.group_id = ag.id
WHERE ag.name ILIKE '%сервер%';
SELECT a.hostname, COUNT(DISTINCT i.id) AS incident_count
FROM public.asset a
JOIN public.vulnerability_asset va ON a.id = va.asset_id
JOIN public.incident_vulnerability iv ON va.id = iv.vulnerability_asset_id
JOIN public.incident i ON iv.incident_id = i.id
GROUP BY a.id, a.hostname
ORDER BY incident_count DESC
LIMIT 1;
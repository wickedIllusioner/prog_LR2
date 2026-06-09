SELECT DISTINCT vc.cve_id, a.hostname, i.status
FROM public.vulnerability_catalog vc
JOIN public.vulnerability_asset va ON vc.id = va.vulnerability_id
JOIN public.asset a ON va.asset_id = a.id
JOIN public.incident_vulnerability iv ON va.id = iv.vulnerability_asset_id
JOIN public.incident i ON iv.incident_id = i.id
WHERE i.status = 'В работе';
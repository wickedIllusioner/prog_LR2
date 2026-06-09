SELECT va.id AS vuln_asset_id, a.hostname, vc.cve_id
FROM public.vulnerability_asset va
JOIN public.asset a ON va.asset_id = a.id
JOIN public.vulnerability_catalog vc ON va.vulnerability_id = vc.id
LEFT JOIN public.remediation_task rt ON va.id = rt.vulnerability_asset_id
WHERE rt.id IS NULL;
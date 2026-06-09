SELECT vc.cve_id, vc.description, va.status 
FROM public.vulnerability_asset va
JOIN public.vulnerability_catalog vc ON va.vulnerability_id = vc.id
JOIN public.asset a ON va.asset_id = a.id
WHERE a.hostname = 'arm-disp-orel-01';
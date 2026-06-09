SELECT i.id AS incident_id, i.title, vc.cvss_score, sp.criticality_level
FROM public.incident i
JOIN public.incident_vulnerability iv ON i.id = iv.incident_id
JOIN public.vulnerability_asset va ON iv.vulnerability_asset_id = va.id
JOIN public.vulnerability_catalog vc ON va.vulnerability_id = vc.id
JOIN public.sla_policy sp ON i.sla_policy_id = sp.id
WHERE vc.cvss_score = (SELECT MAX(cvss_score) FROM public.vulnerability_catalog);
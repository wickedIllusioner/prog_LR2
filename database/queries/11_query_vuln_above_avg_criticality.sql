SELECT cve_id, cvss_score 
FROM public.vulnerability_catalog 
WHERE cvss_score > (SELECT AVG(cvss_score) FROM public.vulnerability_catalog);
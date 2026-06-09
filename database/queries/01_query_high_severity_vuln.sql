SELECT cve_id, description, cvss_score 
FROM public.vulnerability_catalog 
WHERE cvss_score >= 7.0 
ORDER BY cvss_score DESC;
WITH DiscoveredVulns AS (
    SELECT vc.cvss_score 
    FROM public.vulnerability_asset va
    JOIN public.vulnerability_catalog vc ON va.vulnerability_id = vc.id
)
SELECT DISTINCT vc.cve_id, vc.cvss_score
FROM public.vulnerability_catalog vc
JOIN public.vulnerability_asset va ON vc.id = va.vulnerability_id
WHERE vc.cvss_score > (SELECT AVG(cvss_score) FROM DiscoveredVulns);
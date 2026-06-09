WITH ActualThreats AS (
    SELECT tc.threat_type, COUNT(ii.incident_id) AS occurrences
    FROM public.threat_catalog tc
    JOIN public.indicator_compromise ic ON tc.id = ic.threat_id
    JOIN public.incident_indicator ii ON ic.id = ii.ioc_id
    GROUP BY tc.threat_type
)
SELECT threat_type, occurrences 
FROM ActualThreats 
WHERE occurrences > (SELECT AVG(occurrences) FROM ActualThreats);
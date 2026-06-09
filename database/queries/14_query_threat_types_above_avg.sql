WITH TypeCounts AS (
    SELECT threat_type, COUNT(*) AS type_count 
    FROM public.threat_catalog GROUP BY threat_type
)
SELECT threat_type, type_count 
FROM TypeCounts 
WHERE type_count > (SELECT AVG(type_count) FROM TypeCounts);
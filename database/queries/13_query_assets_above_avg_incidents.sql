WITH AssetIncidentCounts AS (
    SELECT va.asset_id, COUNT(DISTINCT i.id) AS inc_count
    FROM public.incident i
    JOIN public.incident_vulnerability iv ON i.id = iv.incident_id
    JOIN public.vulnerability_asset va ON iv.vulnerability_asset_id = va.id
    GROUP BY va.asset_id
)
SELECT a.hostname, aic.inc_count
FROM AssetIncidentCounts aic
JOIN public.asset a ON aic.asset_id = a.id
WHERE aic.inc_count > (SELECT AVG(inc_count) FROM AssetIncidentCounts);
WITH CommonVuln AS (
    SELECT vulnerability_id 
    FROM public.vulnerability_asset 
    GROUP BY vulnerability_id 
    ORDER BY COUNT(*) DESC LIMIT 1
)
SELECT DISTINCT u.username 
FROM public.user_account u
JOIN public.incident i ON u.id = i.responsible_user_id
JOIN public.incident_vulnerability iv ON i.id = iv.incident_id
JOIN public.vulnerability_asset va ON iv.vulnerability_asset_id = va.id
WHERE va.vulnerability_id = (SELECT vulnerability_id FROM CommonVuln);
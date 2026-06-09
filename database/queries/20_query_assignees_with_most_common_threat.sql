WITH CommonThreat AS (
    SELECT ic.threat_id, COUNT(*) AS count
    FROM public.incident_indicator ii
    JOIN public.indicator_compromise ic ON ii.ioc_id = ic.id
    GROUP BY ic.threat_id
    ORDER BY count DESC LIMIT 1
)
SELECT DISTINCT u.username, u.email
FROM public.incident i
JOIN public.user_account u ON i.responsible_user_id = u.id
JOIN public.incident_indicator ii ON i.id = ii.incident_id
JOIN public.indicator_compromise ic ON ii.ioc_id = ic.id
WHERE ic.threat_id = (SELECT threat_id FROM CommonThreat);
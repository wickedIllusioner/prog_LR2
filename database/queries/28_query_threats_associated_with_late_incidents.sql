SELECT DISTINCT tc.threat_name 
FROM public.threat_catalog tc
JOIN public.indicator_compromise ic ON tc.id = ic.threat_id
JOIN public.incident_indicator ii ON ic.id = ii.ioc_id
JOIN public.incident i ON ii.incident_id = i.id
WHERE i.created_at > (
    SELECT TO_TIMESTAMP(AVG(EXTRACT(EPOCH FROM created_at))) FROM public.incident
);
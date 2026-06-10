CREATE OR REPLACE FUNCTION fn_has_threat_info(p_incident_id INTEGER)
RETURNS BOOLEAN AS $$
DECLARE
    v_exists BOOLEAN;
BEGIN
    SELECT EXISTS (
        SELECT 1
        FROM public.incident_indicator ii
        JOIN public.indicator_compromise ic ON ii.ioc_id = ic.id
        JOIN public.threat_catalog tc ON ic.threat_id = tc.id
        WHERE ii.incident_id = p_incident_id AND tc.risk_level IS NOT NULL
    ) INTO v_exists;
    
    RETURN v_exists;
END;
$$ LANGUAGE plpgsql;
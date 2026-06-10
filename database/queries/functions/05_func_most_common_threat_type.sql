CREATE OR REPLACE FUNCTION fn_most_common_threat_type(p_start_date TIMESTAMP, p_end_date TIMESTAMP)
RETURNS VARCHAR AS $$
DECLARE
    v_common_type VARCHAR;
BEGIN
    SELECT tc.threat_type INTO v_common_type
    FROM public.incident i
    JOIN public.incident_indicator ii ON i.id = ii.incident_id
    JOIN public.indicator_compromise ic ON ii.ioc_id = ic.id
    JOIN public.threat_catalog tc ON ic.threat_id = tc.id
    WHERE i.created_at BETWEEN p_start_date AND p_end_date
    GROUP BY tc.threat_type
    ORDER BY COUNT(*) DESC
    LIMIT 1;
    
    RETURN v_common_type;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION fn_count_incidents_in_period(p_start_date TIMESTAMP, p_end_date TIMESTAMP)
RETURNS INTEGER AS $$
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM public.incident
    WHERE created_at BETWEEN p_start_date AND p_end_date;
    
    RETURN v_count;
END;
$$ LANGUAGE plpgsql;
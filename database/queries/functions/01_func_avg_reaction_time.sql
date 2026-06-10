CREATE OR REPLACE FUNCTION fn_avg_reaction_time(p_start_date TIMESTAMP, p_end_date TIMESTAMP)
RETURNS INTERVAL AS $$
DECLARE
    v_avg_time INTERVAL;
BEGIN
    SELECT AVG(ia.first_action - i.created_at) INTO v_avg_time
    FROM public.incident i
    JOIN (
        SELECT incident_id, MIN(action_datetime) AS first_action
        FROM public.incident_action
        GROUP BY incident_id
    ) ia ON i.id = ia.incident_id
    WHERE i.created_at BETWEEN p_start_date AND p_end_date;
    
    RETURN COALESCE(v_avg_time, '0 seconds'::INTERVAL);
END;
$$ LANGUAGE plpgsql;
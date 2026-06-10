CREATE OR REPLACE FUNCTION fn_count_open_incidents()
RETURNS INTEGER AS $$
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM public.incident
    WHERE status NOT IN ('Закрыт', 'Устранен');
    
    RETURN v_count;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION fn_count_incidents_by_employee(p_username VARCHAR)
RETURNS INTEGER AS $$
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM public.incident i
    JOIN public.user_account u ON i.responsible_user_id = u.id
    WHERE u.username = p_username;
    
    RETURN v_count;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION fn_get_high_severity_handlers()
RETURNS TABLE(user_id INTEGER, username VARCHAR, department_name VARCHAR) AS $$
BEGIN
    RETURN QUERY 
    SELECT DISTINCT u.id, u.username::VARCHAR, d.name::VARCHAR
    FROM public.user_account u
    JOIN public.department d ON u.department_id = d.id
    JOIN public.incident i ON u.id = i.responsible_user_id
    WHERE i.priority IN ('High', 'Critical');
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION fn_avg_vulns_per_asset()
RETURNS NUMERIC AS $$
DECLARE
    v_avg NUMERIC;
BEGIN
    SELECT COALESCE(
        ROUND(COUNT(va.id)::NUMERIC / NULLIF((SELECT COUNT(*) FROM public.asset), 0), 2), 
        0.00
    ) INTO v_avg
    FROM public.vulnerability_asset va;
    
    RETURN v_avg;
END;
$$ LANGUAGE plpgsql;
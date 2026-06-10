CREATE OR REPLACE FUNCTION fn_get_assets_with_vulns()
RETURNS TABLE(asset_id INTEGER, hostname VARCHAR, ip_address VARCHAR) AS $$
BEGIN
    RETURN QUERY 
    SELECT DISTINCT a.id, a.hostname::VARCHAR, a.ip_address::VARCHAR
    FROM public.asset a
    JOIN public.vulnerability_asset va ON a.id = va.asset_id;
END;
$$ LANGUAGE plpgsql;
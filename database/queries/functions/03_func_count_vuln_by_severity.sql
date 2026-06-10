CREATE OR REPLACE FUNCTION fn_count_vuln_by_severity(p_severity VARCHAR)
RETURNS INTEGER AS $$
DECLARE
    v_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM public.vulnerability_catalog
    WHERE 
        (p_severity = 'Low' AND cvss_score < 4.0) OR
        (p_severity = 'Medium' AND cvss_score >= 4.0 AND cvss_score < 7.0) OR
        (p_severity = 'High' AND cvss_score >= 7.0 AND cvss_score < 9.0) OR
        (p_severity = 'Critical' AND cvss_score >= 9.0);
        
    RETURN v_count;
END;
$$ LANGUAGE plpgsql;
CREATE OR REPLACE FUNCTION trg_fn_check_vuln_criticality()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.cvss_score < 0.0 OR NEW.cvss_score > 10.0 THEN
        RAISE EXCEPTION 'Ошибка целостности: оценка CVSS должна быть в диапазоне от 0.0 до 10.0. Передано: %', NEW.cvss_score;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_02_check_vuln_criticality ON public.vulnerability_catalog;
CREATE TRIGGER trg_02_check_vuln_criticality
BEFORE INSERT OR UPDATE ON public.vulnerability_catalog
FOR EACH ROW
EXECUTE FUNCTION trg_fn_check_vuln_criticality();
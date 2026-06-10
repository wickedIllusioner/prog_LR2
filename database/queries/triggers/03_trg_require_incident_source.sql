CREATE OR REPLACE FUNCTION trg_fn_require_incident_source()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.source IS NULL OR TRIM(NEW.source) = '' THEN
        RAISE EXCEPTION 'Отказ операции: инцидент не может быть добавлен без указания источника (поле source).';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_03_require_incident_source ON public.incident;
CREATE TRIGGER trg_03_require_incident_source
BEFORE INSERT ON public.incident
FOR EACH ROW
EXECUTE FUNCTION trg_fn_require_incident_source();
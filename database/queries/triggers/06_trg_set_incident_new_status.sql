CREATE OR REPLACE FUNCTION trg_fn_set_incident_new_status()
RETURNS TRIGGER AS $$
BEGIN
    NEW.status := 'Новый';
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_06_set_incident_new_status ON public.incident;
CREATE TRIGGER trg_06_set_incident_new_status
BEFORE INSERT ON public.incident
FOR EACH ROW
EXECUTE FUNCTION trg_fn_set_incident_new_status();
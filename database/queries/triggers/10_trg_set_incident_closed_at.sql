CREATE OR REPLACE FUNCTION trg_fn_set_incident_closed_at()
RETURNS TRIGGER AS $$
BEGIN
    -- Если статус меняется на "Закрыт" (и до этого он не был закрыт)
    IF NEW.status = 'Закрыт' AND OLD.status IS DISTINCT FROM 'Закрыт' THEN
        NEW.closed_at := CURRENT_TIMESTAMP;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_10_set_incident_closed_at ON public.incident;
CREATE TRIGGER trg_10_set_incident_closed_at
BEFORE UPDATE ON public.incident
FOR EACH ROW
EXECUTE FUNCTION trg_fn_set_incident_closed_at();
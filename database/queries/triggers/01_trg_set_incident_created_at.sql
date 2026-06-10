CREATE OR REPLACE FUNCTION trg_fn_set_incident_created_at()
RETURNS TRIGGER AS $$
BEGIN
    -- Принудительно ставим текущее время, даже если пользователь передал NULL
    NEW.created_at := CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_01_set_incident_created_at ON public.incident;
CREATE TRIGGER trg_01_set_incident_created_at
BEFORE INSERT ON public.incident
FOR EACH ROW
EXECUTE FUNCTION trg_fn_set_incident_created_at();
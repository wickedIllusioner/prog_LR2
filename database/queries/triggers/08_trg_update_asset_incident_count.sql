ALTER TABLE public.asset ADD COLUMN IF NOT EXISTS incident_count INTEGER DEFAULT 0;

CREATE OR REPLACE FUNCTION trg_fn_update_asset_incident_count()
RETURNS TRIGGER AS $$
DECLARE
    v_asset_id INTEGER;
BEGIN
    -- Находим ID актива через связь с уязвимостью
    SELECT asset_id INTO v_asset_id 
    FROM public.vulnerability_asset 
    WHERE id = NEW.vulnerability_asset_id;
    
    IF v_asset_id IS NOT NULL THEN
        UPDATE public.asset 
        SET incident_count = incident_count + 1 
        WHERE id = v_asset_id;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_08_update_asset_incident_count ON public.incident_vulnerability;
CREATE TRIGGER trg_08_update_asset_incident_count
AFTER INSERT ON public.incident_vulnerability
FOR EACH ROW
EXECUTE FUNCTION trg_fn_update_asset_incident_count();
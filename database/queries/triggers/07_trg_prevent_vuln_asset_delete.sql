CREATE OR REPLACE FUNCTION trg_fn_prevent_vuln_asset_delete()
RETURNS TRIGGER AS $$
BEGIN
    -- Проверяем наличие связей в кросс-таблице incident_vulnerability
    IF EXISTS (SELECT 1 FROM public.incident_vulnerability WHERE vulnerability_asset_id = OLD.id) THEN
        RAISE EXCEPTION 'Отказ удаления: уязвимость (ID: %) связана с зарегистрированными инцидентами.', OLD.id;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_07_prevent_vuln_asset_delete ON public.vulnerability_asset;
CREATE TRIGGER trg_07_prevent_vuln_asset_delete
BEFORE DELETE ON public.vulnerability_asset
FOR EACH ROW
EXECUTE FUNCTION trg_fn_prevent_vuln_asset_delete();
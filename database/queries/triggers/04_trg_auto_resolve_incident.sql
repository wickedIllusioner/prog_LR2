CREATE OR REPLACE FUNCTION trg_fn_auto_resolve_incident()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'Готово' AND OLD.status != 'Готово' THEN
        IF NOT EXISTS (
            SELECT 1 FROM public.remediation_task
            WHERE asset_vulnerability_id = NEW.asset_vulnerability_id
              AND status != 'Готово'
        ) THEN
            UPDATE public.incident
            SET status = 'Устранен'
            WHERE id IN (
                SELECT incident_id FROM public.incident_vulnerability
                WHERE vulnerability_asset_id = NEW.asset_vulnerability_id
            ) AND status NOT IN ('Устранен', 'Закрыт');
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

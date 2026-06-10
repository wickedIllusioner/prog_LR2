CREATE OR REPLACE FUNCTION trg_fn_auto_resolve_incident()
RETURNS TRIGGER AS $$
BEGIN
    -- Если статус текущей задачи изменился на "Готово"
    IF NEW.status = 'Готово' AND OLD.status != 'Готово' THEN
        -- Проверяем, не осталось ли у данной уязвимости невыполненных задач
        IF NOT EXISTS (
            SELECT 1 FROM public.remediation_task
            WHERE vulnerability_asset_id = NEW.vulnerability_asset_id
              AND status != 'Готово'
        ) THEN
            -- Если все готово, переводим связанные инциденты в статус "Устранен"
            UPDATE public.incident
            SET status = 'Устранен'
            WHERE id IN (
                SELECT incident_id FROM public.incident_vulnerability
                WHERE vulnerability_asset_id = NEW.vulnerability_asset_id
            ) AND status NOT IN ('Устранен', 'Закрыт');
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_04_auto_resolve_incident ON public.remediation_task;
CREATE TRIGGER trg_04_auto_resolve_incident
AFTER UPDATE ON public.remediation_task
FOR EACH ROW
EXECUTE FUNCTION trg_fn_auto_resolve_incident();
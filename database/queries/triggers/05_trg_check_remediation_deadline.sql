CREATE OR REPLACE FUNCTION trg_fn_check_remediation_deadline()
RETURNS TRIGGER AS $$
BEGIN
    -- При завершении задачи проверяем, не просрочен ли дедлайн
    IF NEW.status = 'Готово' AND OLD.status != 'Готово' THEN
        IF CURRENT_DATE > NEW.deadline THEN
            -- Фиксируем превышение в таблицу аудита и выдаем предупреждение
            INSERT INTO public.audit_log (user_id, action, table_name, "timestamp")
            VALUES (NEW.executor_user_id, 'Превышен SLA (Дедлайн: ' || NEW.deadline || ')', 'remediation_task', CURRENT_TIMESTAMP);
            
            RAISE NOTICE 'ВНИМАНИЕ: Превышено допустимое время обработки задачи (ID: %)', NEW.id;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_05_check_remediation_deadline ON public.remediation_task;
CREATE TRIGGER trg_05_check_remediation_deadline
BEFORE UPDATE ON public.remediation_task
FOR EACH ROW
EXECUTE FUNCTION trg_fn_check_remediation_deadline();
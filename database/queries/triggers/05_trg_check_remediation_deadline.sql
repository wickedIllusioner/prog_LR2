CREATE OR REPLACE FUNCTION trg_fn_check_remediation_deadline()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'Готово' AND OLD.status != 'Готово' THEN
        IF CURRENT_DATE > NEW.deadline THEN
            -- В ER-диаграмме action_type имеет список значений (CREATE, UPDATE, DELETE). Пишем 'UPDATE'
            INSERT INTO public.audit_log (user_id, action_type, table_name, "timestamp")
            VALUES (NEW.assignee_id, 'UPDATE', 'remediation_task', CURRENT_TIMESTAMP);
            
            RAISE NOTICE 'ВНИМАНИЕ: Превышено допустимое время обработки задачи (ID: %)', NEW.id;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

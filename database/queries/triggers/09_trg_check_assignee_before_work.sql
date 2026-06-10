CREATE OR REPLACE FUNCTION trg_fn_check_assignee_before_work()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.status = 'В работе' AND NEW.responsible_user_id IS NULL THEN
        RAISE EXCEPTION 'Нельзя перевести инцидент в статус "В работе" без назначения ответственного сотрудника.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_09_check_assignee_before_work ON public.incident;
CREATE TRIGGER trg_09_check_assignee_before_work
BEFORE UPDATE ON public.incident
FOR EACH ROW
EXECUTE FUNCTION trg_fn_check_assignee_before_work();
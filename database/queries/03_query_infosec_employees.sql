SELECT u.username, u.email, d.name AS department
FROM public.user_account u
JOIN public.department d ON u.department_id = d.id
WHERE d.name ILIKE '%безопасности%';
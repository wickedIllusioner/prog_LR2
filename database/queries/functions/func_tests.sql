
-- СКРИПТ АВТОМАТИЗИРОВАННОГО ТЕСТИРОВАНИЯ ФУНКЦИЙ
WITH test_results AS (
    -- Тест 01: fn_avg_reaction_time
    SELECT 
        'Test 01: fn_avg_reaction_time' AS test_name,
        fn_avg_reaction_time('2026-06-01', '2026-06-30')::TEXT AS actual_result,
        CASE WHEN fn_avg_reaction_time('2026-06-01', '2026-06-30') IS NOT NULL THEN 'PASS ✅' ELSE 'FAIL ❌' END AS status

    UNION ALL
    -- Тест 02: fn_count_incidents_in_period
    SELECT 
        'Test 02: fn_count_incidents_in_period',
        fn_count_incidents_in_period('2026-06-01', '2026-06-30')::TEXT,
        CASE WHEN fn_count_incidents_in_period('2026-06-01', '2026-06-30') > 0 THEN 'PASS ✅' ELSE 'FAIL ❌' END

    UNION ALL
    -- Тест 03: fn_count_vuln_by_severity
    -- Проверяем количество критических уязвимостей (их должно быть как минимум 2 в нашей БД)
    SELECT 
        'Test 03: fn_count_vuln_by_severity (Critical)',
        fn_count_vuln_by_severity('Critical')::TEXT,
        CASE WHEN fn_count_vuln_by_severity('Critical') >= 2 THEN 'PASS ✅' ELSE 'FAIL ❌' END

    UNION ALL
    -- Тест 04: fn_has_threat_info
    -- Проверяем инцидент №1 (мы точно знаем, что привязывали к нему IoC и угрозу)
    SELECT 
        'Test 04: fn_has_threat_info (Incident ID = 1)',
        fn_has_threat_info(1)::TEXT,
        CASE WHEN fn_has_threat_info(1) = true THEN 'PASS ✅' ELSE 'FAIL ❌' END

    UNION ALL
    -- Тест 05: fn_most_common_threat_type
    SELECT 
        'Test 05: fn_most_common_threat_type',
        COALESCE(fn_most_common_threat_type('2026-06-01', '2026-06-30'), 'NULL'),
        CASE WHEN fn_most_common_threat_type('2026-06-01', '2026-06-30') IS NOT NULL THEN 'PASS ✅' ELSE 'FAIL ❌' END

    UNION ALL
    -- Тест 06: fn_count_incidents_by_employee
    SELECT 
        'Test 06: fn_count_incidents_by_employee (soc_analyst01)',
        fn_count_incidents_by_employee('soc_analyst01')::TEXT,
        CASE WHEN fn_count_incidents_by_employee('soc_analyst01') >= 0 THEN 'PASS ✅' ELSE 'FAIL ❌' END

    UNION ALL
    -- Тест 07: fn_get_assets_with_vulns
    -- Функция возвращает таблицу, поэтому считаем количество строк в ней
    SELECT 
        'Test 07: fn_get_assets_with_vulns',
        (SELECT COUNT(*) FROM fn_get_assets_with_vulns())::TEXT || ' активов',
        CASE WHEN (SELECT COUNT(*) FROM fn_get_assets_with_vulns()) > 0 THEN 'PASS ✅' ELSE 'FAIL ❌' END

    UNION ALL
    -- Тест 08: fn_count_open_incidents
    SELECT 
        'Test 08: fn_count_open_incidents',
        fn_count_open_incidents()::TEXT,
        CASE WHEN fn_count_open_incidents() > 0 THEN 'PASS ✅' ELSE 'FAIL ❌' END

    UNION ALL
    -- Тест 09: fn_avg_vulns_per_asset
    SELECT 
        'Test 09: fn_avg_vulns_per_asset',
        fn_avg_vulns_per_asset()::TEXT,
        CASE WHEN fn_avg_vulns_per_asset() > 0 THEN 'PASS ✅' ELSE 'FAIL ❌' END

    UNION ALL
    -- Тест 10: fn_get_high_severity_handlers
    -- Также возвращает таблицу, считаем строки
    SELECT 
        'Test 10: fn_get_high_severity_handlers',
        (SELECT COUNT(*) FROM fn_get_high_severity_handlers())::TEXT || ' сотрудников',
        CASE WHEN (SELECT COUNT(*) FROM fn_get_high_severity_handlers()) > 0 THEN 'PASS ✅' ELSE 'FAIL ❌' END
)
SELECT 
    test_name AS "Название теста", 
    actual_result AS "Фактический результат", 
    status AS "Статус проверки"
FROM test_results 
ORDER BY test_name;
# TODO: Тестовые данные (CSV-файлы)

Здесь перечислены все CSV-файлы с тестовыми данными, которые необходимо подготовить.
Каждый CSV-файл соответствует одной таблице в базе данных.

## Формат именования файлов

database/seeds/csv/имя_таблицы.csv

Примеры:
- database/seeds/csv/asset.csv
- database/seeds/csv/incident.csv
- database/seeds/csv/department.csv

## Список CSV-файлов для заполнения

| № | Имя файла | Таблица |
|---|-----------|---------------------------|
| 01 | `asset.csv` | Актив (asset) |
| 02 | `audit_log.csv` | Аудиторский лог (audit_log) |
| 03 | `asset_group.csv` | Группа активов (asset_group) |
| 04 | `incident_action.csv` | Действие по инциденту (incident_action) |
| 05 | `remediation_task.csv` | Задача на устранение (remediation_task) |
| 06 | `scan_job.csv` | Задача сканирования (scan_job) |
| 07 | `incident_ioc.csv` | Индикатор инцидента (incident_ioc) |
| 08 | `ioc.csv` | Индикатор компрометации (ioc) |
| 09 | `incident.csv` | Инцидент (incident) |
| 10 | `risk_exception.csv` | Исключение из рисков (risk_exception) |
| 11 | `threat_catalog.csv` | Каталог угроз (threat_catalog) |
| 12 | `alert.csv` | Оповещение безопасности (alert) |
| 13 | `scan_report.csv` | Отчет сканирования (scan_report) |
| 14 | `patch.csv` | Патч безопасности (patch) |
| 15 | `department.csv` | Подразделение (department) |
| 16 | `sla_policy.csv` | Политика SLA (sla_policy) |
| 17 | `software.csv` | Программное обеспечение (software) |
| 18 | `asset_software.csv` | Программное обеспечение актива (asset_software) |
| 19 | `vendor.csv` | Производитель (vendor) |
| 20 | `role.csv` | Роль (role) |
| 21 | `user_role.csv` | Роль пользователя (user_role) |
| 22 | `network.csv` | Сетевой сегмент (network) |
| 23 | `scanner.csv` | Сканер безопасности (scanner) |
| 24 | `vulnerability_dictionary.csv` | Справочник уязвимостей (vulnerability_dictionary) |
| 25 | `playbook.csv` | Сценарий реагирования (playbook) |
| 26 | `notification.csv` | Уведомление (notification) |
| 27 | `user_account.csv` | Учетная запись (user_account) |
| 28 | `asset_vulnerability.csv` | Уязвимость актива (asset_vulnerability) |
| 29 | `report_template.csv` | Шаблон отчета (report_template) |
| 30 | `playbook_step.csv` | Шаг сценария (playbook_step) |

## Работа с CSV-файлами

1. Каждый выбирает файлы из списка для заполнения
2. Создаёт ветку от актуальной main
3. Добавляет CSV-файл(ы) в папку `database/seeds/csv/`
4. Создаёт Pull Request
5. После слияния — данные считаются подготовленными

## Требования к CSV-файлам

- Первая строка — заголовки (названия колонок)
- Разделитель — запятая (,)
- Кодировка — UTF-8
- Пустые значения допустимы
- Даты в формате `YYYY-MM-DD` или `YYYY-MM-DD HH:MI:SS`

## Скрипт загрузки данных

Файл `database/seeds/load_data.py` должен:
- Подключаться к БД через psycopg2
- Читать CSV-файлы из папки `seeds/csv/`
- Загружать данные в соответствующие таблицы
- Учитывать порядок внешних ключей при загрузке
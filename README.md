# prog_LR2
Репозиторий для выполнения ЛР2 по дисциплине ТиМП на проектирование базы данных "Система управления уязвимостями и реагированием на угрозы в IT-компании"

## Структура проекта

```
database/
  - deploy.py          # Авто развертывание схемы БД, функций, триггеров
  - queries/           # SQL-запросы
    - TODO.md
    - *.sql
  - schema/
    - functions/       # Пользовательские функции
      - TODO.md
      - *.sql
    - triggers/        # Триггеры
      - TODO.md
      - *.sql
    - tables/
      - 01_tables.sql  # Создание всех таблиц
  - seeds/
    - csv/             # CSV-файлы с тестовыми данными
      - *.csv
    - TODO.md
    - load_data.py     # Скрипт загрузки CSV в БД
```

## Настройка окружения (PipEnv)

### Установка PipEnv

Если PipEnv не установлен глобально:

```bash
pip install pipenv
```

### Установка зависимостей

В корневой папке проекта выполнить:

```bash
pipenv install
```

### Активация виртуального окружения

```bash
pipenv shell
```

После активации все команды python будут выполняться в изолированном окружении.

### Запуск скрипта без активации окружения

```bash
pipenv run python database/seeds/load_data.py
```

### Выход из виртуального окружения

```bash
exit
```

## Работа с Git и ветками

### Главное правило

Ветка `main` всегда содержит только рабочий код. Запрещено коммитить напрямую в `main`.

### Именование веток

Каждый участник работает в своей ветке. Примерный формат: `personN_branch`, где N - номер участника.


### Алгоритм работы

#### Получение актуальной версии

```bash
git checkout main
git pull origin main
git checkout personN_branch
git merge main
```

#### Создание новой ветки

```bash
git checkout main
git pull origin main
git checkout -b personN_branch
```

#### Сохранение изменений

```bash
git add .
git commit -m "feat: краткое описание что сделано"
git push origin personN_branch
```

#### Создание Pull Request

1. Зайти на GitHub
2. Перейти в раздел Pull requests
3. Нажать New pull request
4. Выбрать `main` как целевую ветку, а `personN_branch` как ветку с изменениями
5. Нажать Create pull request
6. Добавить описание изменений
7. Назначить ответственного за ревью

#### Исправление замечаний после ревью

```bash
# Внести правки в код
git add .
git commit -m "fix: исправления по замечаниям ревью"
git push origin personN_branch
```

#### После успешного слияния

```bash
git checkout main
git pull origin main
git branch -d personN_branch
```

### Разрешение конфликтов

Если при слиянии возник конфликт:

1. Выполнить в терминале:

```bash
git checkout main
git pull origin main
git checkout personN_branch
git merge main
```

2. Git покажет файлы с конфликтами. Открыть каждый такой файл.
3. Найти маркеры конфликта:

```
<<<<<<< HEAD
ваш код
=======
код из main
>>>>>>> main
```

4. Удалить маркеры (`<<<<<<<`, `=======`, `>>>>>>>`) и оставить нужный код (или объединить оба варианта).
5. Сохранить файл.
6. Завершить слияние:

```bash
git add .
git commit -m "resolve merge conflict"
git push origin personN_branch
```



## Работа с базой данных

### Предварительные требования

- Установленный PostgreSQL (локально или удалённо)
- Установленный pgAdmin (или похожая альтернатива)
- Созданная пустая база данных (в pgAdmin)

### Настройка подключения

Для подключения к PostgreSQL используется файл `.env` в корне проекта.

Создайте в корне проекта файл с именем `.env` и добавьте в него следующие строки:

```
DB_HOST=localhost
DB_PORT=5432
DB_NAME=vulnerability_db
DB_USER=postgres
DB_PASSWORD=your_password_here
```

Измените значения на свои (хост, порт, имя базы, пользователь, пароль).
Скрипт `database/deploy.py` автоматически загрузит настройки из `.env` и подключится к вашей базе данных.


### Полное развертывание схемы БД

Команда создаёт все таблицы, функции и триггеры:

```bash
pipenv run python database/deploy.py
```

Скрипт автоматически:
1. Создаёт таблицы из `database/schema/tables/`
2. Создаёт функции из `database/schema/functions/`
3. Создаёт триггеры из `database/schema/triggers/`

### Загрузка тестовых данных

После развертывания схемы можно загрузить тестовые данные:

```bash
pipenv run python database/deploy.py --with-data
```

Или отдельно, если схема уже развёрнута:

```bash
pipenv run python database/seeds/load_data.py
```

### Выполнение отдельных SQL-запросов

Для выполнения конкретного запроса из `database/queries/` можно использовать psql:

```bash
psql -U postgres -d vulnerability_db -f database/queries/01_query_high_severity_vuln.sql
```

Или подключиться к БД в интерактивном режиме:

```bash
psql -U postgres -d vulnerability_db
```

### Обновление после изменений

Если кто-то из команды добавил новую функцию или триггер:

```bash
git checkout main
git pull origin main
git checkout personN_branch
git merge main
pipenv run python database/deploy.py
```

Скрипт пересоздаст функции и триггеры (используя CREATE OR REPLACE), не затрагивая уже загруженные данные.

## Порядок развёртывания БД с нуля

1. Создать пустую базу данных в PostgreSQL (в pgAdmin)
2. Настроить переменные окружения (DB_HOST, DB_NAME, DB_USER, DB_PASSWORD)
3. Выполнить:
   ```bash
   pipenv run python database/deploy.py --with-data
   ```


## Типичные команды для повседневной работы

| Действие | Команда |
|----------|---------|
| Активировать окружение | `pipenv shell` |
| Развернуть схему БД (таблицы + функции + триггеры) | `pipenv run python database/deploy.py` |
| Развернуть схему и загрузить тестовые данные | `pipenv run python database/deploy.py --with-data` |
| Загрузить только тестовые данные | `pipenv run python database/seeds/load_data.py` |
| Выполнить конкретный SQL-запрос | `psql -U postgres -d vulnerability_db -f путь/к/файлу.sql` |
| Проверить статус git | `git status` |
| Посмотреть список веток | `git branch -a` |
| Переключиться на другую ветку | `git checkout имя_ветки` |
| Получить актуальную версию из main | `git checkout main && git pull origin main && git checkout personN_branch && git merge main` |



## Что делать, если что-то пошло не так

### Случайно закоммитил в main (до push в облако)

```bash
# Откатываем коммит, оставляя код нетронутым в файлах
git reset --soft HEAD~1

# Создаем правильную ветку и переключаемся на нее
git checkout -b personN_branch

git add .
git commit -m "feat: перенос изменений в правильную ветку"
git push origin personN_branch
```

### Код случайно закоммичен и отправлен (push) напрямую в ветку main в облако

```bash
# Смотрим историю и копируем ХЕШ (ID) вашего ошибочного коммита
git log --oneline

# Создаем новый коммит, который автоматически сделает строго противоположные действия
git revert <хеш_ошибочного_коммита>

# Отправляем безопасное исправление в облако
git push origin main
```

### Испорчен локальный код, нужно вернуть последнюю рабочую версию

```bash
# Полностью восстанавливает состояние всех файлов до момента последнего коммита
git restore .
```

### Забыл создать ветку и сделал коммит в main

```bash
git branch personN_branch  # создать ветку от текущего состояния
git reset --hard HEAD~1    # откатить main на коммит назад
git checkout personN_branch  # переключиться на свою ветку
git push origin personN_branch
```

### Нужно отменить изменения в конкретном файле

```bash
# Восстанавливает конкретный файл из последней сохраненной точки
git restore путь/к/файлу.sql
```
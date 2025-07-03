## Data Build Tool fundamentals sandbox
### Установка
1. Создать python проект в любой IDE
2. Установить зависимости
  ```pip install dbt-core dbt-postgres ```
3. Запустить docker-compose.yml с PostgreSQL и Grafana
4. Инициализировать проект dbt  ```dbt init```

### Настройка
1. В файле .dbt/profiles.yml настроить соединение с БД
```
dbtsandbox:
  outputs:
    dev:
      dbname: dbt_sandbox
      host: localhost
      pass: dbt
      port: 5444
      schema: analytics
      threads: 1
      type: postgres
      user: dbt
  target: dev
```
2. В файле dbt_projects.yml добавить поля для models:
```
models:
  dbtsandbox:
    # Config indicated by + and applies to all files under models/example/
    marts:
      +materialized: table
    staging:
      +materialized: view
```
3. Создать в директории models директории marts, staging и schema.yml
4. В staging и marts создать модели из репозитория
5. Создать schema.yml как в репозитории

### Запуск
Для начала надо создать схемы и таблицы в Postgres. Выполните скрипт из файла sql_for_dbt.sql.
Затем с помощью ```dbt debug``` проверим подключение к Postgres.
Если видим  ```Connection test: [OK connection ok] ``` запускаем  ```dbt run ``` и создаем нужные таблицы в Postgres.

### Визуализация
После успешного создания можно попроовать визуализировать данные в Grafana. Перейдем по адресу ```http://localhost:3000/```. Создадим новый дашборд и добавим в него новую визуализацию. Визуализировать данные можно с помощью SQL кода. Для это запустите скрипты из sql_for_grafana.sql. Созданные чарты добавьте в дашборд. В итоге должен получится подобный дашборд:


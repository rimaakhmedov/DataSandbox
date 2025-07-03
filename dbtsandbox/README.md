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
3. Создать в директории проекта models/marts, models/staging и models/schema.yml
4. В models/marts создать:
   

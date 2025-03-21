# sql_project
Итоговый проект по SQL и базам данных.

## Запуск через Docker Desktop
1. Создайте в корне проекта файл `docker-compose.yml` со следующим содержимым:

```yaml
version: '3.8'

services:
  mysql:
    image: mysql:8.0
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_DATABASE: mysqlproject_2
    ports:
      - "3307:3306"
    volumes:
      - ./init.sql:/docker-entrypoint-initdb.d/init.sql
```

- 'docker-compose up -d'
- 'docker exec -it docker_sql-mysql-1 mysql -u root -p'


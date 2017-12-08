# Readme
Simple template for JRuby microservice.
It uses `Sequel`, `Postgres`, `MarchHare gem for RabbitMQ`, `MiniTest` for Tests Protobufs for Inter-service communications

## Java libraries

Place `*.jar` files in `jars/lib` folder

## Commands

*Setup*:

```sh
docker-compose build .
docker exec -it my_db_container1 psql -U postgres -c 'create database my_db_name;'
```

*Start*:

Place your start logic to `bin/start` and `bin/start` :)


*Console*:

```sh
docker-compose run app  bin/console
```

*Tests*:

```sh
docker-compose run app rake test
```

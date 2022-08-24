#!/bin/bash

echo 'criando volumes...'

docker volume create app
docker volume create data

echo 'criando container mysql...'

docker run -e MYSQL_ROOT_PASSWORD=Senha123 -e MYSQL_DATABASE=meubanco --name mysql-A -d -p 3306:3306 --mount type=volume,src=data,dst=/var/lib/mysql/ mysql:5.7

echo 'criando container php...'

docker run --name web-server -dt -p 80:80 --mount type=volume,src=app,dst=/app/ webdevops/php-apache:alpine-php7

echo 'fim'

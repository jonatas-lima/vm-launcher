#!/bin/bash

# Instalando o docker
curl -fsSL https://get.docker.com -o get-docker.sh | bash

# # Adicionando o usuário ao grupo docker
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Variáveis do banco de dados
MYSQL_ROOT_PASSWORD=root
DB_NAME=net
DB_USER=net_user
DB_PASSWORD=net_password

# Iniciando o container
docker run -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  -e MYSQL_DATABASE=$DB_NAME \
  -e MYSQL_USER=$DB_USER \
  -e MYSQL_PASSWORD=$DB_PASSWORD \
  -v $(pwd)/mysql_conf:'/etc/mysql/mysql.conf.d' \
  -v $(pwd)/mysql_data:'/docker-entrypoint-initdb.d' \
  -p 3306:3306 \
  -d --name mysql \
  mysql:5.7

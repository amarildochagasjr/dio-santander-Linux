#!/bin/bash

echo "----- ATUALIZANDO O SERVIDOR -----"

sudo apt-get update
sudo apt-get upgrade -y

echo "----- DOWNLOAD DO APACHE, UNZIP e APLICAÇÃO -----"

sudo apt-get install apache2 -y
sudo apt-get install unzip -y
cd /tmp
sudo wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip

echo "----- DESCOMPACTANDO E ENVIANDO ARQUIVOS PARA APACHE -----"

sudo unzip main.zip
cd linux-site-dio-main
cd -R * /var/www.html

#!/bin/bash

# Lista de los nombres de los contenedores e imágenes
#containers=("lab1-helper" "lab1-tomcat")

# Detener y eliminar los contenedores
echo "Deteniendo el contenedores..."
docker-compose down

#echo "Eliminando las imágenes..."
#docker-compose down --rmi all

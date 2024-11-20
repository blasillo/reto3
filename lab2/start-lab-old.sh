#!/bin/bash

# Descomprimir (cargar) las imágenes desde los archivos tar
echo "Cargando las imágenes desde los archivos .tar..."

docker load -i lab2-administrator.tar
docker load -i lab2-bookstore.tar
docker load -i lab2-db.tar

echo "Etiquetando las imágenes..."

docker tag lab2-administrator:latest btorregrosa/lab2-administrator:v1.0
docker tag lab2-bookstore:latest btorregrosa/lab2-bookstore:v1.0
docker tag lab2-db:latest btorregrosa/lab2-db:v1.0


# Verificar que las imágenes se hayan cargado correctamente
echo "Imágenes cargadas"
#docker images | grep "lab2"

# Ejecutar docker-compose.yml con las imágenes cargadas
echo "Iniciando docker-compose..."
docker-compose up -d


# Lista de los nombres de los contenedores
containers=("administrator" "bookstore" "mysql-db")

for container in "${containers[@]}"
do
  # Verificar si el contenedor está en ejecución
  if [ "$(docker inspect -f '{{.State.Running}}' $container)" == "true" ]; then
    
    # Obtener la IP del contenedor en la red 'pentest-lab'
    IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container)
    echo " $container en IP $IP"
  else
    echo "Error: $container no está en ejecución."
  fi
done

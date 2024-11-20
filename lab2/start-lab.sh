#!/bin/bash

# Imágenes Docker en Docker Hub
images=("btorregrosa/lab2-administrator:v1.0" "btorregrosa/lab2-bookstore:v1.0" "btorregrosa/lab2-db:v1.0")

echo "Descargando imágenes desde Docker Hub..."
for image in "${images[@]}"
do
  docker pull "$image"
done


# Ejecutar docker-compose.yml con las imágenes cargadas
echo "Iniciando contenedores..."
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

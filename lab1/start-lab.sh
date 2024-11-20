#!/bin/bash

# 
# Imágenes Docker en Docker Hub
image_names=("btorregrosa/lab1-helper:latest" "btorregrosa/lab1-tomcat:latest")

echo "Descargando imágenes desde Docker Hub"
# Descargar las imágenes desde Docker Hub
for image in "${image_names[@]}"
do
  docker pull "$image"
done

# Iniciar los servicios usando docker-compose
echo "Iniciando contenedores "
docker-compose up -d

# Verificar si los contenedores están en ejecución y obtener las IPs
containers=("lab1-helper" "lab1-tomcat")

for container in "${containers[@]}"
do
  # Verificar si el contenedor está en ejecución
  if [ "$(docker inspect -f '{{.State.Running}}' $container)" == "true" ]; then

    # Obtener la IP del contenedor
    IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container | awk '{print $1}')
    echo "La dirección IP de $container es: $IP"
  else
    echo "Error: $container no está en ejecución."
  fi
done

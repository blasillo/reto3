#!/bin/bash

# Archivos tar e imágenes Docker correspondientes
tar_files=("helper.tar" "tomcat.tar")
image_names=("lab1-helper:v1" "lab1-tomcat:v1")

echo "Cargando imágenes"
# Cargar las imágenes desde los archivos tar
for i in "${!tar_files[@]}"
do
  docker load -i "${tar_files[i]}"

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

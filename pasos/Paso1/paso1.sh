#!/bin/bash

# Abrir el contenedor de la version 1 

sudo docker-compose -f docker-compose-v1.yml up -d

# Abrir el nodo maestro y crear la carpeta Datasets  
sudo docker exec -it namenode bash
  ls

# sudo mkdir Datasets2

exit

# Copiar los archivos que se encuentran en datasets a el nodo maestro del contenedor

sudo docker cp ./Datasets/canaldeventa/ namenode:/home/Datasets/canaldeventa/

sudo docker cp ./Datasets/calendario/ namenode:/home/Datasets/calendario/

sudo docker cp ./Datasets/empleado/ namenode:/home/Datasets/empleado/

sudo docker cp ./Datasets/gasto/ namenode:/home/Datasets/gasto/

sudo docker cp ./Datasets/producto/ namenode:/home/Datasets/producto/

sudo docker cp ./Datasets/proveedor/ namenode:/home/Datasets/proveedor/

sudo docker cp ./Datasets/sucursal/ namenode:/home/Datasets/sucursal/

sudo docker cp ./Datasets/tipodegasto/ namenode:/home/Datasets/tipodegasto/

sudo docker cp ./Datasets/venta/ namenode:/home/Datasets/venta/

sudo docker cp ./Datasets/data_nvo/ namenode:/home/Datasets/data_nvo/


# Crear un directorio en HDFS llamado "/data".

sudo docker exec -it namenode bash

hdfs dfs -mkdir -p /data

# # Copiar los archivos csv provistos a HDFS:

hdfs dfs -put /home/Datasets/* /data

exit
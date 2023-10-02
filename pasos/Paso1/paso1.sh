
# Abrir el contenedor de la version 1 
  sudo docker-compose -f docker-compose-v1.yml up -d

# Abrir el nodo maestro y crear la carpeta Datasets  
sudo docker exec -it namenode bash
  cd home
  mkdir Datasets
  exit
  

# Copiar los archivos que se encuentran en datasets a el nodo maestro del contenedor

sudo docker cp /home/pc/Documentos/henry/SoyHenryDataScience/Modulo4/DS-M4-Herramientas_Big_Data/Datasets/canaldeventa/ namenode:/home/Datasets/canaldeventa/

sudo docker cp /home/pc/Documentos/henry/SoyHenryDataScience/Modulo4/DS-M4-Herramientas_Big_Data/Datasets/calendario/ namenode:/home/Datasets/canalendario/

sudo docker cp /home/pc/Documentos/henry/SoyHenryDataScience/Modulo4/DS-M4-Herramientas_Big_Data/Datasets/empleado/ namenode:/home/Datasets/empleado/

sudo docker cp /home/pc/Documentos/henry/SoyHenryDataScience/Modulo4/DS-M4-Herramientas_Big_Data/Datasets/gasto/ namenode:/home/Datasets/gasto/

sudo docker cp /home/pc/Documentos/henry/SoyHenryDataScience/Modulo4/DS-M4-Herramientas_Big_Data/Datasets/producto/ namenode:/home/Datasets/producto/

sudo docker cp /home/pc/Documentos/henry/SoyHenryDataScience/Modulo4/DS-M4-Herramientas_Big_Data/Datasets/proveedor/ namenode:/home/Datasets/proveedor/

sudo docker cp /home/pc/Documentos/henry/SoyHenryDataScience/Modulo4/DS-M4-Herramientas_Big_Data/Datasets/sucursal/ namenode:/home/Datasets/sucursal/

sudo docker cp /home/pc/Documentos/henry/SoyHenryDataScience/Modulo4/DS-M4-Herramientas_Big_Data/Datasets/tipodegasto/ namenode:/home/Datasets/tipodegasto/

sudo docker cp /home/pc/Documentos/henry/SoyHenryDataScience/Modulo4/DS-M4-Herramientas_Big_Data/Datasets/venta/ namenode:/home/Datasets/venta/

sudo docker cp /home/pc/Documentos/henry/SoyHenryDataScience/Modulo4/DS-M4-Herramientas_Big_Data/Datasets/data_nvo/ namenode:/home/Datasets/data_nvo/

sudo docker cp /home/pc/Documentos/henry/SoyHenryDataScience/Modulo4/DS-M4-Herramientas_Big_Data/Datasets/data_nvo/ namenode:/home/Datasets/data_nvo/

sudo docker cp /home/pc/Documentos/henry/SoyHenryDataScience/Modulo4/DS-M4-Herramientas_Big_Data/Datasets/data_nvo/ namenode:/home/Datasets/data_nvo/


# Crear un directorio en HDFS llamado "/data".

  hdfs dfs -mkdir -p /data


# Copiar los archivos csv provistos a HDFS:

hdfs dfs -put /home/Datasets/* /data


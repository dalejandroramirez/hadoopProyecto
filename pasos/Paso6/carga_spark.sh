# Cargar raw-flight-data.csv desde HDFS
# Creacion de las carpetas y ubicar el archivo dentro del hdfs

sudo docker exec -it namenode bash
mkdir home/flight
exit 

hdfs dfs -mkdir -p /data/flight

sudo docker cp Datasets/raw-flight-data.csv namenode:/home/flight/raw-flight-data.csv

sudo docker cp Datasets/airports.csv namenode:/home/flight/airports.csv

# copiar al hdfs 
hdfs dfs -put /home/flight/airports.csv /flight/airports.csv

##########################################
## Entrar al entorno de spark
##########################################
sudo docker exec -it spark-master bash

spark/bin/spark-shell --master spark://spark-master:7077

## Ejecutar comandos del archivo Paso00_scala.scala






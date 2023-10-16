### 3) Comparativa Dataset y Dataframe en Scala:

### copiar los archivos dentro del spark-master

- sudo docker cp pasos/Paso6/scripts/Paso01_scala.scala spark-master:Paso01_scala.scala

- sudo docker cp pasos/Paso6/scripts/Paso01_spark.py spark-master:Paso01_spark.py

### Entrar al entorno de spark-master bash

- sudo docker exec -it spark-master bash


## 
/spark/bin/spark-submit --master spark://spark-master:7077 Paso01_spark.py

/spark/bin/spark-shell --master spark://spark-master:7077 -i pruebaScala.scala


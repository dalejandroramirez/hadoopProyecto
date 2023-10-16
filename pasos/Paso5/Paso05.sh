sudo docker-compose -f docker-compose-v3.yml up -d

	 #1 crear una tabla de personas
   sudo docker exec -it hbase-master hbase shell

		create 'personal','personal_data'
		list 'personal'
		put 'personal',1,'personal_data:name','Juan'
		put 'personal',1,'personal_data:city','Cordoba'
		put 'personal',1,'personal_data:age','25'
		put 'personal',2,'personal_data:name','Franco'
		put 'personal',2,'personal_data:city','Lima'
		put 'personal',2,'personal_data:age','32'
		put 'personal',3,'personal_data:name','Ivan'
		put 'personal',3,'personal_data:age','34'
		put 'personal',4,'personal_data:name','Eliecer'
		put 'personal',4,'personal_data:city','Caracas'
		get 'personal','4''personal_data:city'

	#2-En el namenode del cluster:
	# Se abre el namenode y se guarda el archivo personal.csv en el nodo, luego se guarda en el hdfs 

	sudo docker exec -it namenode bash

	sudo docker cp Datasets/personal.csv namenode:home/hbase/data/personal.csv

	hdfs dfs -put ./personal.csv /hbase/data/personal.csv

##

	sudo docker exec -it hbase-master bash
		
    hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.separator=',' -Dimporttsv.columns=HBASE_ROW_KEY,personal_data:name,personal_data:city,personal_data:age personal hdfs://namenode:9000/hbase/data/personal.csv

		## Se debe ejecutar linea por linea 

		hbase shell
		scan 'personal'
		create 'album','label','image'
		put 'album','label1','label:size','10'
		put 'album','label1','label:color','255:255:255'
		
		put 'album','label1','label:text','Family album'
		put 'album','label1','image:name','holiday'
		put 'album','label1','image:source','/tmp/pic1.jpg'
		get 'album','label1';
	

############################################################
## Mongo

	sudo docker cp Datasets/iris.csv mongodb:/data/iris.csv
	sudo docker cp Datasets/iris.json mongodb:/data/iris.json

	sudo docker exec -it mongodb bash

	mongoimport /data/iris.csv --type csv --headerline -d proyectoHadoop -c iris_csv
	mongoimport --db proyectoHadoop --collection iris_json --file /data/iris.json --jsonArray


## entrar al bash de mongo y ejecutar lineas
 mongosh

		use proyectoHadoop
		show collections
		db.iris_csv.find()
		db.iris_json.find()


# Dentro de sudo docker exec -it mongodb bash

mongoexport --db proyectoHadoop --collection iris_csv --fields "sepal_length,sepal_width,petal_length,petal_width,species" --type=csv --out home/data/iris_export.csv


mongoexport --db proyectoHadoop --collection iris_json --fields sepal_length,sepal_width,petal_length,petal_width,species --type=json --out home/data/iris_export.json


# descargar desde  https://search.maven.org/search?q=g:org.mongodb.mongo-hadoop

## copiamos los archivos al hive server

sudo docker cp pasos/Paso5/mongo/mongo-hadoop-hive-2.0.2.jar hive-server:/opt/hive/lib/mongo-hadoop-hive-2.0.2.jar

sudo docker cp pasos/Paso5/mongo/mongo-hadoop-core-2.0.2.jar hive-server:/opt/hive/lib/mongo-hadoop-core-2.0.2.jar

sudo docker cp pasos/Paso5/mongo/mongo-hadoop-spark-2.0.2.jar hive-server:/opt/hive/lib/mongo-hadoop-spark-2.0.2.jar

sudo docker cp pasos/Paso5/mongo/mongo-java-driver-3.12.11.jar hive-server:/opt/hive/lib/mongo-java-driver-3.12.11.jar

# copia de escala
sudo docker cp pasos/Paso5/mongo/mongo-scala-driver-0.8.15.jar hive-server:/opt/hive/lib/mongo-java-driver-3.12.11.jar

#
sudo docker cp iris.hql hive-server:/opt/iris.hql
sudo docker exec -it hive-server bash

#
hiveserver2
chmod 777 iris.hql
hive -f iris.hql




################################################################



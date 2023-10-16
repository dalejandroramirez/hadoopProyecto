
#copiar dentro del nodo spark-master

sudo docker cp pasos/Paso7/Paso06_GeneracionVentasNuevasPorDia.py spark-master:/home/Paso06_GeneracionVentasNuevasPorDia.py

sudo docker cp pasos/Paso7/Paso06_IncrementalVentas.py spark-master:/home/Paso06_IncrementalVentas.py

# ejecutar el archivo
sudo docker exec -it spark-master /spark/bin/spark-submit --master spark://spark-master:7077 /home/Paso06_GeneracionVentasNuevasPorDia.py

## otro archivo
	/spark/bin/spark-submit --master spark://spark-master:7077 Paso06_IncrementalVentas.py
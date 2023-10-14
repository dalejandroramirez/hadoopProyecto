#!/bin/bash

# Debo copiar mi archivo hql dentro de serverhive

# docker cp /home/pc/Documentos/henry/hadoopProyecto/pasos/Paso2/Paso02.hql hive-server:/Paso02.hql

sudo docker exec -it hive-server bash

# Ejecutar el script .hql con Hive 
hive -f /home/Paso02.hql

# Si no funciona es necesario --->    chmod +x ejecutar_hql.sh
# Inicializacion del problema 3

#!/bin/bash

#Entorno que contiene a hive
sudo docker-compose -f docker-compose-v2.yml up -d


# Debo copiar mi archivo hql dentro de serverhive

docker cp /home/pc/Documentos/henry/hadoopProyecto/pasos/Paso3/Paso03.hql hive-server:/home/Paso03.hql

sudo docker exec -it hive-server bash

# Ejecutar el script .hql con Hive 
hive -f /home/Paso03.hql

# Si no funciona es necesario --->    chmod +x ejecutar_hql.sh


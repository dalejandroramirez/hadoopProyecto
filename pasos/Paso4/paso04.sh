# En el entorno v2

# ejecutar en hiveserver
sudo docker exec -it hive-server bash

# Ejecutar el script .hql con Hive 
hive -f /home/Paso04.hql

# Al crear el indice paso  de 2,36 seg a 1,7seg (muy poco pero mejoro)

# select IdSucursal, sum(Monto) From gasto
# group by IdSucursal;



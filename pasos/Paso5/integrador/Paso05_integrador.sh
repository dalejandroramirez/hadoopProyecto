sudo docker cp ./Datasets/producto/Producto.csv neo4j:/var/lib/neo4j/import/producto.csv

sudo docker cp ./Datasets/cliente/Cliente.csv neo4j:/var/lib/neo4j/import/cliente.csv

sudo docker cp ./Datasets/venta/Venta.csv neo4j:/var/lib/neo4j/import/venta.csv

sudo docker cp ./Datasets/tipodegasto/TiposDeGasto.csv neo4j:/var/lib/neo4j/import/tipo_gasto.csv

## conectarse a neo4j
docker exec -it neo4j bash

# entrar a la consola de neo4j
cypher-shell -u neo4j -p zeppelin

# copiar el contenido de cargadata.txt

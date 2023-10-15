# ejecutar en hiveserver

# use integrador2;
# select idsucursal, sum(precio * cantidad) from venta group by idsucursal;

# CREATE INDEX index_venta_sucursal ON TABLE venta(IdSucursal) AS 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler' WITH DEFERRED REBUILD;


# CREATE INDEX index_compra_producto ON TABLE compra(IdProducto) AS 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler' WITH DEFERRED REBUILD;

# Al crear el indice se mejoro de 2,36 seg a  1,7seg
use integrador2;

select idsucursal, sum(precio * cantidad) from venta group by idsucursal;

CREATE INDEX index_venta_sucursal ON TABLE venta(IdSucursal) AS 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler' WITH DEFERRED REBUILD;


CREATE INDEX index_compra_producto ON TABLE compra(IdProducto) AS 'org.apache.hadoop.hive.ql.index.compact.CompactIndexHandler' WITH DEFERRED REBUILD;

select IdSucursal, sum(Monto) From gasto
group by IdSucursal;

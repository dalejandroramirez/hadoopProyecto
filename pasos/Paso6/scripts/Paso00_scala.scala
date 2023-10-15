import org.apache.spark.SparkConf
import org.apache.spark.SparkContext
import org.apache.spark.sql.SparkSession

val startTimeMillis = System.currentTimeMillis()

val spark = SparkSession.
            builder().
            appName("prueba-scala").
            master("spark://spark-master:7077").
            config("spark.executor.memory", "1g").
            getOrCreate()
			

## Crear esquema de fligth
case class flightSchema(DayofMonth:String, DayOfWeek:String, Carrier:String, OriginAirportID:String, DestAirportID:String, DepDelay:String, ArrDelay:String)

## cargar variable flight
val flights = spark.read.format("csv").option("sep", ",").option("header", "true").load("hdfs://namenode:9000/flight/raw-flight-data.csv").as[flightSchema]

## eliminar nulos
var flights2 = flights.dropDuplicates().na.fill(0, Array("ArrDelay", "DepDelay"))


## carga de airports

case class airportsSchema(airport_id:String, city:String, state:String, name:String)

var airports = spark.read.format("csv").option("sep", ",").option("header", "true").load("hdfs://namenode:9000/flight/airports.csv").as[airportsSchema]

##cuandos vuelos existen agrupados por ciudad

val flightsByOrigin = flights.join(airports, $"OriginAirportID" === $"airport_id").groupBy("city").count()

flightsByOrigin.repartition(1).write.format("csv").mode("overwrite").option("sep", ",").option("header", "true").save("hdfs://namenode:9000/flight/flightsByOrigin-procesado-scala")



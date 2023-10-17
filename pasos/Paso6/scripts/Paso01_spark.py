## Conectarse a spark y ejecutar algun comando 

from pyspark.sql.types import *
from pyspark.sql.functions import *

from pyspark.sql import SparkSession

spark = SparkSession.\
        builder.\
        appName("hadoopProyect").\
        master("spark://spark-master:7077").\
        config("spark.executor.memory", "1g").\
        getOrCreate()

flightSchema = StructType([
  StructField("DayofMonth", IntegerType(), False),
  StructField("DayOfWeek", IntegerType(), False),
  StructField("Carrier", StringType(), False),
  StructField("OriginAirportID", IntegerType(), False),
  StructField("DestAirportID", IntegerType(), False),
  StructField("DepDelay", IntegerType(), False),
  StructField("ArrDelay", IntegerType(), False),
])

flights = spark.read.csv('hdfs://namenode:9000/data/flight/raw-flight-data.csv', schema=flightSchema, header=True)

flights = flights.dropDuplicates().fillna(value=0, subset=["ArrDelay", "DepDelay"])

airports = spark.read.csv('hdfs://namenode:9000/data/flight/airports.csv', header=True, inferSchema=True)

flightsByOrigin = flights.join(airports, flights.OriginAirportID == airports.airport_id).groupBy("city").count()

flightsByOrigin.repartition(1).write.csv(path="hdfs://namenode:9000/data/flight/flightsByOrigin-procesado-spark", sep=",", header=True, mode="overwrite")


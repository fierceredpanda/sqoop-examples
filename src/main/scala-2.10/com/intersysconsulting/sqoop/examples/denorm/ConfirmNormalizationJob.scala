package com.intersysconsulting.sqoop.examples.denorm

import org.apache.spark.{SparkConf, SparkContext}
import org.apache.spark.sql.SQLContext

/**
  * Reads the normalization parquet file, prints it schema and shows the rows.
  *
  * @author Victor M. Miller
  */
object ConfirmNormalizationJob {

  def main(args: Array[String]): Unit = {

    val sparkConf = new SparkConf().setAppName("Normalization Job")
    val sc = new SparkContext(sparkConf)
    val sqlContext = new SQLContext(sc)

    val normalizedCustomers = sqlContext.read.parquet("hdfs://localhost:8020/user/cloudera/norm/customer.parquet")
    normalizedCustomers.printSchema()
    normalizedCustomers.show(100)
  }
}

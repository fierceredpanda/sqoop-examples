package com.intersysconsulting.sqoop.examples.denorm

import com.databricks.spark.avro._
import org.apache.spark.sql.SQLContext
import org.apache.spark.{SparkConf, SparkContext}


/**
  * Loads the denormailized Avro records, groups them by customer and writes them to parquet in a complex data
  * structure where each contact has a list of addresses.
  *
  * @author Victor M. Miller
  */
object NormalizationJob {

  def main(args: Array[String]): Unit = {

    val sparkConf = new SparkConf().setAppName("Normalization Job")
    val sc = new SparkContext(sparkConf)
    val sqlContext = new SQLContext(sc)

    import sqlContext.implicits._

    val customerDenormDF = sqlContext.read
      .avro("hdfs://localhost:8020/user/cloudera/denorm/*.avro")
      .as[CustomerDenormalized]
    val customerNormRDD = customerDenormDF.rdd
      .map(customer => {
          val address = Address(customer.address_id, customer.street_address_1, customer.street_address_2, customer.city, customer.state, customer.zip)
          CustomerNormalized(customer.customer_id, customer.first_name, customer.last_name, customer.age, customer.height_inches, customer.weight, List(address))
      })
      .map(customer => (customer.customer_id, customer))
      .reduceByKey((cust1, cust2) => CustomerNormalized(cust1.customer_id, cust1.first_name, cust1.last_name, cust1.age, cust1.height_inches, cust1.weight, cust1.addresses ++ cust2.addresses))
      .map(tuple => tuple._2)

    val customerNormDF = customerNormRDD.toDF()
    customerNormDF.printSchema()
    customerNormDF.write.parquet("hdfs://localhost:8020/user/cloudera/norm/customer.parquet")
  }

}

case class CustomerDenormalized(customer_id: Int,
                                first_name: String,
                                last_name: String,
                                age: Int,
                                height_inches: Int,
                                weight: Int,
                                address_id: Int,
                                street_address_1: String,
                                street_address_2: String,
                                city: String,
                                state: String,
                                zip: String)

case class CustomerNormalized(customer_id: Int,
                              first_name: String,
                              last_name: String,
                              age: Int,
                              height_inches: Int,
                              weight: Int,
                              addresses: List[Address])

case class Address(address_id: Int,
                   street_address_1: String,
                   street_address_2: String,
                   city: String,
                   state: String,
                   zip: String)
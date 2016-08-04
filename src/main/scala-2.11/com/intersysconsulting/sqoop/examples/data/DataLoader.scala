package com.intersysconsulting.sqoop.examples.data

import java.sql.{Connection, DatabaseMetaData, DriverManager, PreparedStatement, SQLException, Timestamp, Types}
import java.util.Date

import scala.collection.mutable.ArrayBuffer
import scala.util.Random

/**
  * Used to load data into a table.  Arguments to the data loader are as follows:
  * 1. server - The host url and port for the database
  * 2. database - The database to connec to
  * 3. user - The user to use when connecting to the database
  * 4. password - The password to authenticate with
  * 5. table - The to load data into
  */
object DataLoader {

  val ColumnName = 4
  val DataType = 5
  val TypeName = 6
  val ColumnSize = 7
  val Nullable = 18
  val AutoIncrement = 23

  val randumNumGenerator = Random

  def main(args: Array[String]): Unit = {

    if (args.length != 7) throw new IllegalArgumentException("Correct usage: <server> <database> <user> <password> <table> <numBatches> <itemsPerBatch>")
    val Array(server, database, user, password, table, numBatches, itemsPerBatch) = args

    val url = s"jdbc:mysql://$server/$database?useSSL=false"

    var connection: Connection = null

    try {

      connection = DriverManager.getConnection(url, user, password)

      val databaseMetaData: DatabaseMetaData = connection.getMetaData
      val columnDefinitions = parseTableDefinition(database, table, databaseMetaData)
      val insertSQL = buildInsertSQL(table, columnDefinitions)

      val insertStatement = connection.prepareStatement(insertSQL)

      for (x <- 1 to numBatches.toInt) {
        insertBatch(itemsPerBatch.toInt, insertStatement, columnDefinitions)
        Thread.sleep(2500)
      }

    } catch {
      case e: SQLException => e.printStackTrace()
    }

    connection.close()
  }

  /**
    * Queries the table to get the columns that belong to the table.
    * @param database The database that the table belongs to.
    * @param table The table to query for the list of oolumns.
    * @param databaseMetaData The meta data for the database.
    * @return A list of columns for the table.
    */
  def parseTableDefinition(database: String, table: String, databaseMetaData: DatabaseMetaData): List[ColumnDef] = {

    val columnRs = databaseMetaData.getColumns(database, null, table, "%")

    val columns = new ArrayBuffer[ColumnDef]()
    var columnIndex = 1
    while (columnRs.next()) {
      val columnDef = ColumnDef(columnRs.getString(ColumnName), columnRs.getInt(DataType), columnRs.getString(TypeName),
          columnRs.getInt(ColumnSize), columnRs.getString(Nullable) == "YES", columnRs.getString(AutoIncrement) == "YES", columnIndex)
        if (!columnDef.autoIncrement) columnIndex = columnIndex + 1
      columns += columnDef
    }

    columns.toList
  }

  /**
    * Uses the table and list of columns to build a prepared statement that can be used to insert data.
    * @param table The table to insert into.
    * @param columns The columns.  If the column is auto incrementing then it is ignroed.
    * @return The SQL that can be used to insert into the table.
    */
  def buildInsertSQL(table: String, columns: List[ColumnDef]) : String = {

    val statement = new StringBuilder
    statement ++= s"INSERT INTO $table ("

    columns.foreach(column => if (!column.autoIncrement) statement ++= s"${column.name}, ")
    statement.delete(statement.length - 2, statement.length)
    statement ++= ") VALUES ("
    columns.foreach(column => if (!column.autoIncrement) statement ++= "?, ")
    statement.delete(statement.length - 2, statement.length)
    statement ++= ");"

    statement.toString()
  }

  /**
    * Inserts a batch of data.
    * @param numEntries The number of entries to insert in the batch.
    * @param insertStatement The statement to use to do the insert.
    * @param columns The list of columns that make up an individual row.
    */
  def insertBatch(numEntries: Int, insertStatement: PreparedStatement, columns: List[ColumnDef]): Unit = {

    for (a <- 1 to numEntries) {
      columns.foreach(column => {
        if (!column.autoIncrement) {
          insertStatement.setObject(column.index, generateValue(column.columnType, column.columnType))
        }
      })
      insertStatement.addBatch()
    }

    insertStatement.executeBatch()
  }

  def generateValue(columnType: Int, columnSize: Int): Any = {
    columnType match {
      case Types.VARCHAR =>
        val randomSize = randumNumGenerator.nextInt(columnSize)
        Random.alphanumeric.take(randomSize).mkString
      case Types.INTEGER => randumNumGenerator.nextInt(500)
      case Types.TIMESTAMP => new Timestamp(new Date().getTime)
    }
  }

  case class ColumnDef(name: String, columnType: Int, typeName: String, columnSize: Int, nullable: Boolean, autoIncrement: Boolean, index: Int)
}
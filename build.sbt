name := "sqoop-examples"

version := "1.0"

scalaVersion := "2.10.6"

javacOptions ++= Seq("-source", "1.8", "-target", "1.8")

libraryDependencies ++= Seq(
  "org.apache.spark" %% "spark-core" % "1.6.2" % "provided",
  "org.apache.spark" %% "spark-sql" % "1.6.2" % "provided",
  "com.databricks" %% "spark-avro" % "2.0.1")

resolvers += "Typesafe Repository" at "http://repo.typesafe.com/typesafe/releases/"

mainClass in assembly := Some("com.intersysconsulting.sqoop.examples.denorm.NormalizationJob")

test in assembly := {}

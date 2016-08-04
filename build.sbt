name := "sqoop-examples"

version := "1.0"

scalaVersion := "2.11.8"

resolvers += "Typesafe Repository" at "http://repo.typesafe.com/typesafe/releases/"

libraryDependencies += "mysql" % "mysql-connector-java" % "6.0.3"

// for debugging sbt problems
logLevel := Level.Debug

scalacOptions += "-deprecation"
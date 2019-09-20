# nlp-graph-examples
Examples for Graphorum 2019 presentation -- Graph Techniques for Natural Language Processing

### Environment

#### Neo4j

* The graph database used for this project was Neo4j-community version 3.5.5.
* The APOC and Graph Algorithm libraries had to be separately installed in the `$NEO4J_HOME/plugin` directory. Following JAR files were used (they need to be compatible with the server version).
  * apoc-3.5.0.4-all.jar 
  * neo4j-graph-algorithms-3.5.8.1-standalone.jar
* APOC and Graph Algorithms need to be enabled in `$NEO4J_HOME/conf/neo4j.conf`
  * `dbms.security.procedures.unrestricted=apoc.*,algo.*`
  * `dbms.security.procedures.whitelist=apoc.*,algo.*`
* Python 3.7 from Anaconda
* SpaCy 2.0.11 for NLP support
* py2neo 4.1.3 for connecting to neo4j via Bolt and execute Cypher commands
  * pip install py2neo

#### Spark + GraphFrames

* Databricks Runtime version 5.5 LTS (Apache Spark 2.4.3, Scala 2.11)
* GraphFrames 0.7.0 (Apache Spark 2.4, Scala 2.11)


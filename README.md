# nlp-graph-examples

Examples for Graphorum 2019 presentation -- Graph Techniques for Natural Language Processing

### Abstract

Natural Language embodies the human ability to make “infinite use of finite means” (Humboldt, 1836; Chomsky, 1965). A relatively small number of words can be combined using a grammar in myriad different ways to convey all kinds of information. Languages model inter-relationships between their words, just like graphs model inter-relationships between their vertices. It is not surprising then, that graphs are a natural tool to study Natural Language and glean useful information from it, automatically, and at scale. This presentation will focus on NLP techniques to convert raw text to graphs, and present Graph Theory–based solutions to some common NLP problems. Solutions presented will use Apache Spark or Neo4j, depending on problem size and scale. Examples of Graph Theory solutions presented include PageRank for Document Summarization, Link Prediction from raw text for Knowledge Graph enhancement, Label Propagation for entity classification, and Random Walk techniques to find similar documents.

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

_Note: This ended up not really getting used, all case study examples are based on Neo4j. This is because Neo4j algorithms are usually more feature-rich than Spark+GraphFrames counterparts, and Neo4j scales well to large graphs, largest used here is one with 500K nodes, and 1.3M edges._

* Databricks Runtime version 5.5 LTS (Apache Spark 2.4.3, Scala 2.11)
* GraphFrames 0.7.0 (Apache Spark 2.4, Scala 2.11)


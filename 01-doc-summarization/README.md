## 01-doc-summarization

### Introduction

This sub-project is inspired by the paper [A Complex Network approach to Text Summarization](https://www.sciencedirect.com/science/article/pii/S0020025508004520) by (Lucas Antiqueira, Olvaldo N. Oliveira Jr, Luciano da Fontoura Costa, and Maria das Gracas Volpe Nunes, 2009). The paper describes an ensemble of 14 graph techniques that are used to predict an extractive summary for the document.

The document is modeled as a graph, with nodes corresponding to sentences, and edges corresponding to the co-occurrence of commonly occurring nouns across the sentence.

### Code

* [01-preprocess-story.ipynb](src/01-preprocess-story.ipynb) -- converts `.story` file into `sentences.txt` and `summary.text`.
* [02-create-graph.ipynb](src/02-create-graph.ipynb) -- converts `sentences.txt` into `nodes.csv` and `edges.csv`, which are loaded into a Neo4j database.
* [03-summarize-document.ipynb](src/03-summarize-document.ipynb) -- applies graph techniques to generate multiple recommendations for sentences in document summary, and ensembles via majority voting to provide final summary recommendation.

### Data

The documents to summarize come from the [DeepMind Q+A Dataset](https://cs.nyu.edu/~kcho/DMQA/), a corpus of News Stories from CNN. 5 of these stories are provided in the `data` directory, and the `src` directory contains Jupyter notebooks to preprocess the `.story` file into sentences, convert to a graph, and apply graph techniques for the summarizers.

### Environment

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


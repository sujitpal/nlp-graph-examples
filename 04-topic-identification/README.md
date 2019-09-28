## 04-topic-identification

### Introduction

This project is inspired by the paper [Using Encyclopedic Knowledge for Automatic Topic Identification](https://www.aclweb.org/anthology/W09-1126) (Coursey, Mihalcea, and Moen, 2009). The paper presents a method for automatic topic identification by using a Knowledge Graph (KG) derived from Wikipedia.

The general idea is to annotate a document against this KG and retrieve any matched concepts. Then, we run a [Personalized PageRank (PPR)](https://neo4j.com/docs/graph-algorithms/current/algorithms/page-rank/#algorithms-pagerank-personalized) on the KG, using the matched concepts as the source nodes, i.e., the set of nodes that the algorithm will randomly choose to jump back to when it teleports. This is as opposed to regular PageRank, where teleportation can happen to any node in the graph. PPR is used in recommender systems, and the intuition is that by fixing the set of source nodes, you constrain the PageRank algorithm to give high ranks to nodes in the neighborhood of your source nodes. Once these nodes have been predicted by PPR, we do some sort of roll-up to find the categories of these nodes. The node categories thus found constitute the topics identified for the document.

A more straightforward way that I have been using prior to learning about this technique was to just rollup the matched concepts to find the document categories. The additional PPR step introduces a degree of serendipity into the concepts, and therefore into the document categories.

For this project, I am going to use a company-proprietary KG of clinical healthcare, which I will not be able to share (sorry). However, as long as you can provide a node list and edge list with the minimal information described below, you should be able to replicate the code here with minor changes.

    # node.CSV
    # id,name

    # edge.CSV
    # src_id,rel_name,dst_id,rel_weight

### Code

* [01-annotate-stories.ipynb](src/01-annotate-stories.ipynb) -- use Aho-Corasick algorithm to construct dictionary of terms from proprietary Knowledge Graph (KG), and stream selected articles against it. Output is a file `story-concepts.tsv` of concepts matched against each article.
* [02-create-graphs.ipynb](src/02-create-graphs.ipynb) -- read CSV files of KG nodes and edges, and rewrite it to format readable by `neo4j-admin` tool. Ingest and build Neo4j graph of KG. Two versions of the graph are extracted, one containing all lateral relations (no parent or child), and the other containing only parent relationships.
* [03-run-ppr.ipynb](src/03-run-ppr.ipynb) -- for each article, set source nodes for concepts matched for the article, and run Personalized PageRank (PPR) on the lateral relations graph to get highly ranked concepts that are biased by the source nodes. Save the top k (k=5) concepts most highly ranked by PPR to file `story-concepts-ppr.tsv`.
* [04-find-categories.ipynb](src/04-find-categories.ipynb) -- the proprietary KG contains all disease concepts as children of the concept "Diseases", so we navigate from top concepts found in files `story-concepts.tsv` and `story-concepts-ppr.tsv` to the children of the "Diseases" concepts so we can roll these concepts up to the appropriate disease category. Top disease categories are topics.

### Data

We choose the following four articles from ScienceDaily magazine. Data was captured by navigating to the page on the browser and copy pasting the text. They are provided in the `data` folder for this project.

- [Genetic Regions associated with Left-Handedness Identified](https://www.sciencedaily.com/releases/2019/09/190904194433.htm)
- [Transplanted Brain Stem Cells Survive Without Anti-rejection drugs in mice](https://www.sciencedaily.com/releases/2019/09/190916092109.htm)
- [Why People gain weight as they get older](https://www.sciencedaily.com/releases/2019/09/190909193211.htm)
- [How Memories form and fade](https://www.sciencedaily.com/releases/2019/08/190823140729.htm)

These articles are streamed against a dictionary data structure of synonyms, provided by the `ahocorasick` library, from the company-proprietary KG. A single concept may have multiple synonyms, and a match in the text against a synonym will result in the span of text in the article marked up with the corresponding ID of the node (which we call a concept). 

We then construct two Neo4j graphs with the node and edge data from the KG, removing `isParentOf` and `isChildOf` relationships in the first case, and removing all but `isChildOf` relationships in the second case. We run the PPR algorithm on the first graph for each article, setting the source nodes as the ones that were found by streaming against the `ahocorasick` dictionary data structure.

The next step is to rollup the concepts with high page rank predicted by the PPR algorithm. In case of our KG, immediate children of a particular node are known to be "category" nodes, representing disease classes (endocrine disease, vascular disease, etc). So we navigate the tree to find the "category" nodes and report them as the "topics" for the articles.

I notice that while rollups from PPR predictions had a certain amount of serendipity, it may be preferable to augment the original categories found by rolling up the original matched concepts.

### Results

Topics predicted for each article via straight rollup vs. rolling up concepts predicted by PPR are shown below. As can be seen, while the PPR topics seem believable given the article title and contents, they tend to complement the topics predicted by straight rollup rather than replace them altogether.

| Article Title                                              | Topics predicted from annotations | Topics predicted after PPR        |
|------------------------------------------------------------|-----------------------------------|-----------------------------------|
| [Genetic Regions associated with Left-Handedness Identified](https://www.sciencedaily.com/releases/2019/09/190904194433.htm) | 'neoplasm and/or hamartoma', 'female genital and obstetric disorder' | 'neoplasm and/or hamartoma', 'disorder characterized by pain', 'disorder by body site', 'physical disorder', 'inflammatory disorder' |
| [Transplanted Brain Stem Cells Survive Without Anti-rejection drugs in mice](https://www.sciencedaily.com/releases/2019/09/190916092109.htm) | 'hereditary disorder', 'neoplasm and/or hamartoma', 'physical disorder' | 'degenerative disorder', 'disorder characterized by pain', 'female genital and obstetric disorder', 'disorder by body site', 'physical disorder', 'inflammatory disorder' |
| [Why People gain weight as they get older](https://www.sciencedaily.com/releases/2019/09/190909193211.htm) | 'nutrition and metabolism disorders', 'neoplasm and/or hamartoma', 'disorder by body site' | 'degenerative disorder', 'disorder characterized by pain', 'disorder by body site', 'physical disorder', 'inflammatory disorder' |
| [How Memories form and fade](https://www.sciencedaily.com/releases/2019/08/190823140729.htm) | 'mental disorder', 'neoplasm and/or hamartoma', 'disorder by body site', 'physical disorder' | 'disorder characterized by pain', 'disorder by body site', 'physical disorder', 'inflammatory disorder' |



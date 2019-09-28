## 02-docs-clustering

### Introduction

This project attempts to do clustering of documents from the 20-newsgroup dataset. It is inspired by the paper [Language Model-Based Document Clustering using Random Walks](https://www.aclweb.org/anthology/N06-1061) (Erkan, 2006). Documents are initially vectorized using [TF-IDF](https://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.TfidfTransformer.html#sklearn.feature_extraction.text.TfidfTransformer). Using the resulting Term Document (TD) Matrix, the document Similarity Matrix is computed. The Similarity Matrix is then sparsified by discarding all but the top c similarities called top generators (Kurland and Lee, 2005), and removing all diagonal elements. The first restricts each document's neighbors to the top c similar documents, and the second removes the possibility of self-loops for random walks. Here c is a hyperparameter -- the paper reports that values of c from 80-100 gave good values, so we use c=80 in our experiment.

The Similarity Matrix is then re-normalized so that each row sums to 1 (or 0 if all elements in the row are 0). Thus each row i of the Similarity Matrix represents the transition probability distribution of moving to some other document in the corpus. We then execute c random walks of path lengths 1..3 starting with each document. As before c can be a hyperparameter, but following the paper, we have set c=80 here as well. The paper observes that random walks of lengths higher than 3 lead to poor results, indicating perhaps that 3 is some sort of boundary on semantic relatedness.

The source and target nodes for the random walks can be used to compute empirical probabilities for generating a target document j from a source document i. The resulting matrix G of Generation Probabilities can be used similar to a Language Model to predict that a document j will be generated from document i.

We cluster the graph corresponding to the adjacency matrix G using [Louvain's Community Detection Algorithm](https://neo4j.com/docs/graph-algorithms/current/algorithms/louvain/). We also cluster the documents, treating each document as a vector of generation probabilities (row of G) using [Mini Batch K-Means Algorithm](https://scikit-learn.org/stable/modules/generated/sklearn.cluster.MiniBatchKMeans.html) for comparison.

Clusterings are compared using the [Silhouette score](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.silhouette_score.html), which measures how well-separated the clusters are.

### Code

* [01-preprocess-data.ipynb](src/01-preprocess-data.ipynb) -- parses out text portion of newsgroup post and writes it out as one single chunk of text, one per line to `texts.tsv` and newsgroup labels (folder name) to `labels.tsv`. Document IDs are based on folder and file names.
* [02-tfidf-similarity.ipynb](src/02-tfidf-similarity.ipynb) -- Create matrix T of TF-IDF vectors, compute cosine similarity matrix S, sparsify S by retaining only top generators, and remove self-edges, then re-normalize to make it a probability matrix.
* [03-generation-probs.ipynb](src/03-generation-probs.ipynb) -- generate c=80 random walks of path lengths t=1, 2, 3 starting from each node in the graph represented by the adjacency matrix S. Generate transition probability matrix G1, G2, G3 corresponding to t=1..3, corresponding to a generative model for documents with proximity depdendency t.
* [04-create-graph.ipynb](src/04-create-graph.ipynb) -- creates CSV file for nodes and edges for translating matrices G1..G3 to corresponding Neo4j graphs using `neo4j-admin` tool.
* Ingest CSV files to create Neo4j graph.
* [05a-cluster-louvain.ipynb](src/05a-cluster-louvain.ipynb) -- apply the Louvain clustering algorithm on each graph. This notebook needs to be run separately for G1, G2, and G3. Writes out predicted cluster IDs into output file.
* [05b-cluster-kmeans.ipynb](src/05b-cluster-kmeans.ipynb) -- apply K-Means clustering against document vectors from the similarity matrix S, G1, G2, and G3, computed using multiple runs. Writes out predicted cluster IDs into output file.
* [06-evaluate.ipynb](src/06-evaluate.ipynb) -- evaluate Silhouette Score for the different clusterings.

### Data

Dataset is the [20-newsgroups dataset](http://qwone.com/~jason/20Newsgroups/) consisting of approximately 18k newsgroup postings from 20 different categories.

Download the 20news-bydate.tar.gz into the `data/20-newsgroups` directory (below current directory) and expand it.

### Results

| Matrix | Algorithm | Which | Silhouette Score |
|--------|-----------|-------|------------------|
| TD     | KMeans    | Label |          0.00443 |
| TD     | KMeans    | Pred  |          0.01674 |
| G1     | Louvain   | Pred  |          0.05862 |
| G1     | KMeans    | Pred  |          0.05757 |
| G2     | Louvain   | Pred  |          0.04596 |
| G2     | KMeans    | Pred  |          0.04433 |
| G3     | Louvain   | Pred  |          0.08849 |
| G3     | KMeans    | Pred  |          0.08620 |

Based on Silhouette scores, it looks like the data is very overlapping to begin with. We could have perhaps done a better job of feature identification to remove extraneous words that occur across multiple categories. However, the important thing to note is the change in score across different experiments rather than the values themselves.

As the paper also notes, generating a language model-like matrix of generation probabilities results in better clustering as shown by the higher silhouette score. Increasing the number of hops for the random walks used to generate these matrices seems to result overall in better performance (however, performance seems to fall between G1 and G2). Louvain community detection seems to build better clusters compared to K-Means.


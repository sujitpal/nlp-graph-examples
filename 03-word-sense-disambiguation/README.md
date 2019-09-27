## 03-word-sense-disambiguation

### Introduction

This project was inspired by the paper [Word Sense Disambiguation using Label Propagation Based Semi-supervised Learning](https://www.aclweb.org/anthology/P05-1049) (Niu, Ji, and Tan, 2005). It describes a technique for doing Word Sense Disambiguation using [Label Propagation](https://neo4j.com/docs/graph-algorithms/current/algorithms/label-propagation/) and semi-supervised learning.

Given an ambiguous word, such as these found in this [list of Ambiguous Words](https://muse.dillfrog.com/lists/ambiguous), we collect sentences containing the word from some dataset. We then manually annotate a subset of these sentences to indicate the sense it indicates in the given sentence. We then construct a graph, where each sentence is a node, and the edges between the sentences are computed as the similarity between the feature vectors for the sentences. We then sparsify the graph so that we consider only the top 5 edges between any two sentences. We then apply the Label Propagation algorithm on the graph, and after a sufficient number of iterations, the Label Propagation algorithm should converge and mark the unannotated sentences as belonging to one of the senses of the word. The similarity measures used in the paper were [Cosine Similarity](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.pairwise.cosine_similarity.html) and [Jensen-Shannon Divergence](https://docs.scipy.org/doc/scipy/reference/generated/scipy.spatial.distance.jensenshannon.html?highlight=jensenshannon#scipy.spatial.distance.jensenshannon).

### Data and Methods

In our implementation, we extracted 668 sentences containing the ambiguous word `compound` from sentences from the ScienceDirect corpus. We then marked up 40 instances (19, 21) of these sentences as either containing (1) compound as in chemical compound, or (2) compound to indicate a group or multiple. For example:

	(1) Each compound was quantified in multiple reaction monitoring (MRM mode), using the protonated molecular ion as the precursor ion.
	(2) Proband II.1 from family A is compound heterozygous for REEP6 variants (M1/M2).

After replacing all punctuation with space, and lowercasing the input, we computed TF-IDF feature vectors for n-grams (n=1..3) for all the words, and 3-grams for the corresponding POS tags. We then computed the matrix of pairwise cosine similarities between the sentences. The similarity matrix was sparsified by discarding all but the top k (k=5) edges.

We then set a new attribute `seed_label` for each node. For the ones corresponding to manually annotated sentences, the attribute were set to the mnual label, and for the rest, it was assigned a unique running number. Label Propagation (considering the graph to be unweighted) was then applied for 1000 iterations, and the predictions extracted for the sentences that were not manually annotated.

### Results

Of 623 unlabeled sentences, Label Propagation returns the following predictions:

* 319 sentences use `compound` as the first sense. Examples -- ORTEP view of the compound [CuL8(ClO4)2] with the numbering scheme adopted.
* 7 sentences use `compound` in the second sense. Example -- Sensitive to compound fluorescence.
* 298 sentences remain unclassified. Based on a quick check, many of these should really belong to sense 1.

Results are not great, but it is possible that it can be improved with more manual labeling. Another possibility might be to have a denser network, i.e., discard all but top 10 instead of top 5 highly weighted rows, etc. We did not investigate further because of shortage of time.


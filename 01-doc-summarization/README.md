## 01-doc-summarization

### Introduction

This sub-project is inspired by the paper [A Complex Network approach to Text Summarization](https://www.sciencedirect.com/science/article/pii/S0020025508004520) (Lucas Antiqueira, Olvaldo N. Oliveira Jr, Luciano da Fontoura Costa, and Maria das Gracas Volpe Nunes, 2009). The paper describes an ensemble of 14 graph techniques that are used to predict an extractive summary for the document.

The document is modeled as a graph, with nodes corresponding to sentences, and edges corresponding to the co-occurrence of commonly occurring nouns across the sentence.

### Code

* [01-preprocess-story.ipynb](src/01-preprocess-story.ipynb) -- converts `.story` file into `sentences.txt` and `summary.text`.
* [02-create-graph.ipynb](src/02-create-graph.ipynb) -- converts `sentences.txt` into `nodes.csv` and `edges.csv`, which are loaded into a Neo4j database.
* [03-summarize-document.ipynb](src/03-summarize-document.ipynb) -- applies graph techniques to generate multiple recommendations for sentences in document summary, and ensembles via majority voting to provide final summary recommendation.

### Data

The documents to summarize come from the [DeepMind Q+A Dataset](https://cs.nyu.edu/~kcho/DMQA/), a corpus of News Stories from CNN. 5 of these stories are provided in the `data` directory, and the `src` directory contains Jupyter notebooks to preprocess the `.story` file into sentences, convert to a graph, and apply graph techniques for the summarizers.

### Results

<table cellspacing=2 cellpadding=2 border=1>
  <tr>
    <th>Story ID</th>
    <th>Highlights</th>
    <th>Generated Summary</th>
  </tr>
  <tr valign="top">
    <td width="10%">be8fc9fffd65a5a38153e83acc304a83c2e206e1</td>
    <td width="30%">President Mahmoud Ahmadinejad begins a four-nation Latin America tour. The trip is the latest step in a longstanding effort to shore up support in the region. Analyst: "Iran has an extremely active diplomatic move afoot". Iran recently launched a Spanish-language television network.</td>
    <td width="60%">Well before the Iranian leader's arrival in Caracas, his plans for a Latin America tour grabbed global attention as tensions grow between many Western powers and Iran over the nation's nuclear program. Spanish-language headlines on the network's website last week described Israeli spies, foreign intervention in Syria, a report that Japan plans to "disobey" U.S. sanctions against Iran and an allegation that airport security screening machines in the United States cause death. Officials in the United States and other Western nations have ratcheted up sanctions against Iran several times since a November report by the U.N. nuclear watchdog agency said the Iranian government was developing the technology needed to build a nuclear weapon. Some U.S. government officials and Washington analysts allege that Iran could be using new business relationships and energy deals with Latin American countries as a cover for more illicit projects, such as training Hezbollah militants and developing nuclear weapons. Iran and its Bolivarian allies (Venezuela, Bolivia, Nicaragua and Ecuador) in Latin America are systematically engaged in a pattern of financial behavior, recruitment exercises and business activities that are not economically rational and could be used for the movement and/or production of (weapons of mass destruction) and the furthering of Iran's stated aim of avoiding international sanctions on its nuclear program," Farah wrote in a May 2011 report for the U.S. Defense Department.</td>
  </tr>
  <tr valign="top">
    <td>1151e28352e5d92937eeefb9ede8ad63137b9a20</td>
    <td>Scot Case answers your questions on greenwashing. Has green become a new form of "premium brand"? What green words and phrases should raise a red flag?. Click here to read more answers to your questions.</td>
    <td>There are cleaning products and paints, for example, that have been certified as meeting tough environmental standards by EcoLogo or Green Seal that deliver the same high-quality performance one expects without costing any extra. Some particularly savvy green consumers, however, want additional information beyond knowing that a product has been certified as meeting a standard. They are seeking information presented in a nutrition-label format that allows them to compare two certified products to determine which is greener. Government purchasers in New York, Illinois, California, Minnesota, and other places, for example, require cleaning products to meet the Green Seal or EcoLogo cleaning-product standards. Other programs -- including EcoLogo, Green Seal, and the Chlorine Free Products Association -- independently review product test data and visit the manufacturing facilities to ensure compliance with the standard.</td>
  </tr>
  <tr valign="top">
    <td>23f24292b366f81b1e4277d51e56f52644cc5b61</td>
    <td>"It will happen again, unless something fundamental changes," group says. A firm says it is working on a civil case against Penn State. Report: Second Mile records for several years are missing. Attorneys say more alleged victims may come forward.</td>
    <td>(CNN) -- Experts said Thursday that the alleged child sexual abuse scandals at Penn State University and another at The Citadel in South Carolina underscore the frailty and inconsistency of the legal system intended to protect children, while some lawmakers called for changes in reporting such crimes. In the Penn State case, Pennsylvania's attorney general has charged a former Penn State football coach, Jerry Sandusky, with 40 counts in what authorities allege was the sexual abuse of eight boys. The Child Abuse Prevention and Treatment Act requires states to develop laws mandating that child abuse be reported. Changes should include tightening requirements among the states about who must report suspicions that a child is being sexually abused, said Lisa Fontes, a lecturer at University Without Walls at the University of Massachusetts - Amherst and author of "Child Abuse and Culture -- Working with Diverse Families. "The Department of Health and Human Services' website says that, in Pennsylvania, professionals "required to report include, but are not limited to: licensed physicians, osteopaths, medical examiners, coroners, funeral directors, dentists, optometrists, chiropractors, podiatrists, interns, nurses, or hospital personnel, Christian Science practitioners or members of the clergy; school administrators, teachers, school nurses, social services workers, daycare center workers, or any other child care or foster care workers; mental health professionals; peace officers or law enforcement officials."</td>
  </tr>
  <tr valign="top">
    <td>7db40e6c46d3f7c460bd8d43fe492d2ce505d777</td>
    <td>NEW: France's foreign minister will try to persuade the U.N. "to fully assume its responsibilities". Clinton calls on the U.N. Security Council to show Syrians "we stand with you". Monday's death toll reaches 100, an opposition group says. Syria's Interior Ministry says security forces are conducting operations against terrorists.</td>
    <td>The state-run Syrian Arab News Agency (SANA), citing an official source at the Foreign and Expatriates Ministry, reported Tuesday that "the U.S.-Western hostile statements" are being espoused to "target Syria and create a different image about the ... Syrian crisis." One of the Syrian reports also cited Russian Deputy Foreign Minister Gennady Gatilov as calling on the Security Council "to study in detail the report of the Arab League Observer Mission on Syria" before discussing the draft resolution the Arab League has presented to the Security Council. The group also reported violence in Rastan, Daraa, and other towns and cities across Syria. On state media, Syria routinely blames violence in the country on "armed terrorist groups." A similar statement, also attributed to the Interior Ministry, read Monday by a host on state television said security forces had "conducted operations" over the prior three days in several cities, pursuing members of the "armed terrorist groups that committed the most horrific crimes of killing and kidnapping, and planted landmines and detonated them on streets."</td>
  </tr>
  <tr valign="top">
    <td>25645a2944b1ef1743d8b7582f6ede70aed84753</td>
    <td>Diane Wood has a long, relatively liberal judicial record. Wood has sat on the 7th Circuit U.S. Court of Appeals in Chicago since 1995. Rulings on abortion, church-state disputes could result in tough confirmation battle. She speaks French, German, and some Russian; plays the oboe and French horn.</td>
    <td>In 2001, Wood wrote the opinion upholding a lower court decision that applied anti-racketeering laws against a group of anti-abortion protesters. The only dissent by the high court in support of Wood's views was Stevens himself (National Organization for Women vs. Scheidler, 2001). "A Wood nomination would return the abortion wars to the Supreme Court," Americans United for Life announced in a statement. Amazingly, because of her powerful dissent, the entire appeals court agreed to rehear the case and reversed unanimously, adopting Wood's original position. Wood was interviewed by the president last year, a finalist for the high court seat that went to Justice Sonia Sotomayor.</td>
  </tr>
</table>


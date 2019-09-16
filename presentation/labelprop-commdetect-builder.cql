MATCH (n) DETACH DELETE n

MERGE (nA:Node {id:'A'}) SET nA.seed_label=52
MERGE (nB:Node {id:'B'}) SET nB.seed_label=21
MERGE (nC:Node {id:'C'}) SET nC.seed_label=43
MERGE (nD:Node {id:'D'}) SET nD.seed_label=21
MERGE (nE:Node {id:'E'}) SET nE.seed_label=19
MERGE (nF:Node {id:'F'}) SET nF.seed_label=52

MERGE (nA)-[:REL]->(nB)
MERGE (nA)-[:REL]->(nC)
MERGE (nE)-[:REL]->(nD)
MERGE (nB)-[:REL]->(nF)
MERGE (nD)-[:REL]->(nE)
MERGE (nF)-[:REL]->(nA)
MERGE (nA)-[:REL]->(nF)
MERGE (nB)-[:REL]->(nA)
MERGE (nF)-[:REL]->(nB)
MERGE (nC)-[:REL]->(nD)

MATCH (a) RETURN a

CALL algo.labelPropagation.stream("Node", "REL", {direction: "OUTGOING", iterations: 10}) 
YIELD nodeId, label 
RETURN algo.asNode(nodeId).id AS name, label

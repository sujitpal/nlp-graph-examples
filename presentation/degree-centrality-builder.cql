MATCH (n) DETACH DELETE n

MERGE (nA:Node {id:'A'})
MERGE (nB:Node {id:'B'})
MERGE (nC:Node {id:'C'})
MERGE (nD:Node {id:'D'})
MERGE (nE:Node {id:'E'})
MERGE (nF:Node {id:'F'})

MERGE (nA)-[:REL]->(nD)
MERGE (nA)-[:REL]->(nB)
MERGE (nA)-[:REL]->(nC)
MERGE (nE)-[:REL]->(nD)
MERGE (nE)-[:REL]->(nF)
MERGE (nB)-[:REL]->(nD)
MERGE (nC)-[:REL]->(nD)
MERGE (nF)-[:REL]->(nD)
 
MATCH (a) RETURN a

CALL algo.degree.stream("Node", "REL", {direction: "incoming"})
YIELD nodeId, score
RETURN algo.asNode(nodeId).id AS name, score AS degree_centrality
ORDER BY score DESC


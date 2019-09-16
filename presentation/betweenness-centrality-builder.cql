MATCH (n) DETACH DELETE n

MERGE (nA:Node {id:'A'})
MERGE (nB:Node {id:'B'})
MERGE (nC:Node {id:'C'})
MERGE (nD:Node {id:'D'})
MERGE (nE:Node {id:'E'})
MERGE (nF:Node {id:'F'})

MERGE (nA)-[:REL]->(nB)
MERGE (nA)-[:REL]->(nC)
MERGE (nA)-[:REL]->(nD)
MERGE (nE)-[:REL]->(nA)
MERGE (nC)-[:REL]->(nF)

MATCH (a) RETURN a

CALL algo.betweenness.stream('Node','REL',{direction:'out'})
YIELD nodeId, centrality
MATCH (n:Node) WHERE id(n) = nodeId
RETURN n.id AS name, centrality AS betweenness_centrality
ORDER BY centrality DESC

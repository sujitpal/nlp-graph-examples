MATCH (n) DETACH DELETE n

MERGE (nA:Node {id:'A'})
MERGE (nB:Node {id:'B'})
MERGE (nC:Node {id:'C'})
MERGE (nD:Node {id:'D'})
MERGE (nE:Node {id:'E'})
MERGE (nF:Node {id:'F'})

MERGE (nA)-[:REL]->(nB)
MERGE (nA)-[:REL]->(nC)
MERGE (nE)-[:REL]->(nD)
MERGE (nB)-[:REL]->(nF)
MERGE (nC)-[:REL]->(nE)
MERGE (nA)-[:REL]->(nF)
MERGE (nC)-[:REL]->(nD)

MATCH (a) RETURN a

CALL algo.louvain.stream('Node', 'REL', {})
YIELD nodeId, community
RETURN algo.asNode(nodeId).id AS user, community
ORDER BY community

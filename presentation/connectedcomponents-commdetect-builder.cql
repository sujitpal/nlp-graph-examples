MATCH (n) DETACH DELETE n

MERGE (nA:Node {id:'A'})
MERGE (nB:Node {id:'B'})
MERGE (nC:Node {id:'C'})
MERGE (nD:Node {id:'D'})
MERGE (nE:Node {id:'E'})
MERGE (nF:Node {id:'F'})

MERGE (nA)-[:REL {weight:0.5}]->(nB)
MERGE (nA)-[:REL {weight:4}]->(nC)
MERGE (nE)-[:REL {weight:1}]->(nD)
MERGE (nE)-[:REL {weight:2}]->(nF)

MATCH (a) RETURN a

CALL algo.unionFind.stream('Node', 'REL', {})
YIELD nodeId,setId
RETURN algo.asNode(nodeId).id AS user, setId AS component
ORDER BY component

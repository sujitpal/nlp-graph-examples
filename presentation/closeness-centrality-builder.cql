MATCH (n) DETACH DELETE n

MERGE (a:Node{id:"A"})
MERGE (b:Node{id:"B"})
MERGE (c:Node{id:"C"})
MERGE (d:Node{id:"D"})
MERGE (e:Node{id:"E"})

MERGE (a)-[:REL]->(b)
MERGE (b)-[:REL]->(a)
MERGE (b)-[:REL]->(c)
MERGE (c)-[:REL]->(b)
MERGE (c)-[:REL]->(d)
MERGE (d)-[:REL]->(c)
MERGE (d)-[:REL]->(e)
MERGE (e)-[:REL]->(d)

MATCH (a) RETURN a

CALL algo.closeness.stream('Node', 'REL')
YIELD nodeId, centrality
RETURN algo.asNode(nodeId).id AS name, centrality AS closeness_centrality
ORDER BY centrality DESC
LIMIT 20

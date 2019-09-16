MATCH (n) DETACH DELETE n

MERGE (e:Node {name:'E'})
MERGE (f:Node {name:'F'})
MERGE (g:Node {name:'G'})
MERGE (h:Node {name:'H'})
MERGE (a:Node {name:'A'})
MERGE (b:Node {name:'B'})
MERGE (c:Node {name:'C'})
MERGE (d:Node {name:'D'})

MERGE (e)-[:REL]->(f)
MERGE (f)-[:REL]->(e)
MERGE (g)-[:REL]->(e)
MERGE (e)-[:REL]->(g)
MERGE (h)-[:REL]->(e)
MERGE (e)-[:REL]->(h)
MERGE (h)-[:REL]->(a)
MERGE (a)-[:REL]->(e)
MERGE (h)-[:REL]->(b)
MERGE (b)-[:REL]->(e)
MERGE (h)-[:REL]->(c)
MERGE (c)-[:REL]->(e)
MERGE (h)-[:REL]->(d)
MERGE (d)-[:REL]->(e)

MATCH (a) RETURN a

CALL algo.pageRank.stream('Node', 'REL', {iterations:20, dampingFactor:0.85})
YIELD nodeId, score
RETURN algo.asNode(nodeId).name AS page,score AS page_rank
ORDER BY score DESC


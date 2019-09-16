MATCH (n) DETACH DELETE n

MERGE (h:Node {name:'H'})
MERGE (e:Node {name:'E'})
MERGE (f:Node {name:'F'})
MERGE (g:Node {name:'G'})
MERGE (a:Node {name:'A'})
MERGE (b:Node {name:'B'})
MERGE (c:Node {name:'C'})
MERGE (d:Node {name:'D'})

MERGE (h)-[:REL]->(e)
MERGE (e)-[:REL]->(h)
MERGE (f)-[:REL]->(h)
MERGE (h)-[:REL]->(f)
MERGE (g)-[:REL]->(h)
MERGE (h)-[:REL]->(g)
MERGE (g)-[:REL]->(a)
MERGE (a)-[:REL]->(h)
MERGE (g)-[:REL]->(b)
MERGE (b)-[:REL]->(h)
MERGE (g)-[:REL]->(c)
MERGE (c)-[:REL]->(h)
MERGE (g)-[:REL]->(d)
MERGE (d)-[:REL]->(h)


MATCH (a) RETURN a

MATCH (h:Node {name: "H"})
CALL algo.randomWalk.stream(id(h), 5, 5)
YIELD nodeIds
RETURN [x IN nodeIds | algo.asNode(x).name] AS path


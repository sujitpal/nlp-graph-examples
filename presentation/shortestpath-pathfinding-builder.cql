MATCH (n) DETACH DELETE n

MERGE (a:Node {name:'A'})
MERGE (b:Node {name:'B'})
MERGE (c:Node {name:'C'})
MERGE (d:Node {name:'D'})
MERGE (e:Node {name:'E'})
MERGE (f:Node {name:'F'})

MERGE (a)-[:REL {cost:50}]->(b)
MERGE (a)-[:REL {cost:50}]->(c)
MERGE (a)-[:REL {cost:100}]->(d)
MERGE (b)-[:REL {cost:40}]->(d)
MERGE (c)-[:REL {cost:40}]->(d)
MERGE (c)-[:REL {cost:80}]->(e)
MERGE (d)-[:REL {cost:30}]->(e)
MERGE (d)-[:REL {cost:80}]->(f)
MERGE (e)-[:REL {cost:40}]->(f);

MATCH (a) RETURN a

MATCH (start:Node{name:'A'}), (end:Node{name:'F'})
CALL algo.shortestPath.stream(start, end, 'cost')
YIELD nodeId, cost
RETURN algo.asNode(nodeId).name AS name, cost AS cost_from_A

--
CALL algo.allShortestPaths.stream('cost',{nodeQuery:'Node', defaultValue:1.0})
YIELD sourceNodeId, targetNodeId, distance
WITH sourceNodeId, targetNodeId, distance
WHERE algo.isFinite(distance) = true
MATCH (source:Node) WHERE id(source) = sourceNodeId
MATCH (target:Node) WHERE id(target) = targetNodeId
WITH source, target, distance 
WHERE source <> target AND source.name < target.name AND distance > 0
RETURN source.name AS source, target.name AS target, distance AS path_length
ORDER BY distance ASC
LIMIT 5

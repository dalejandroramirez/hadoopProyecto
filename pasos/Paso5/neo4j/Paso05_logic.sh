## entrar a  http://localhost:7474/
# user : neo4j
# pass: zeppelin
  
  CREATE (a:Place {id: 'A'}),
       (b:Place {id: 'B'}),
       (c:Place {id: 'C'}),
       (d:Place {id: 'D'}),
       (e:Place {id: 'E'}),
       (f:Place {id: 'F'}),
       (g:Place {id: 'G'}),
       (d)-[:LINK {cost:4}]->(b),
       (d)-[:LINK {cost:6}]->(e),
       (b)-[:LINK {cost:1}]->(a),
       (b)-[:LINK {cost:3}]->(c),
       (a)-[:LINK {cost:2}]->(c),
       (c)-[:LINK {cost:5}]->(e),
       (f)-[:LINK {cost:1}]->(g);
  
# Lo siguiente proyectará y almacenará un gráfico con nombre:

CALL gds.graph.project(
  'graph',
  'Place',{
    LINK: {
      properties: 'cost',
      orientation: 'UNDIRECTED'}})

#      

MATCH (n:Place {id: 'D'})
CALL gds.beta.spanningTree.stats.estimate('graph', {sourceNode: id(n),relationshipWeightProperty:'cost'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory
RETURN nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory


## Lo siguiente ejecutará el algoritmo del árbol de expansión de peso mínimo en modo de transmisión y devolverá resultados para cada nodo válido.

MATCH (n:Place{id: 'D'})
CALL gds.beta.spanningTree.stream('graph', {
  sourceNode: id(n),
  relationshipWeightProperty: 'cost'
})
YIELD nodeId,parentId, weight
RETURN gds.util.asNode(nodeId).id AS node, gds.util.asNode(parentId).id AS parent,weight
ORDER BY node

## Lo siguiente ejecutará el algoritmo del árbol de expansión de peso mínimo y devolverá sus estadísticas.

MATCH (n:Place{id: 'D'})
CALL gds.beta.spanningTree.stats('graph', {
  sourceNode: id(n),
  relationshipWeightProperty: 'cost'
})
YIELD effectiveNodeCount, totalWeight
RETURN effectiveNodeCount, totalWeight

## Lo siguiente ejecutará el algoritmo del árbol de expansión de peso mínimo y escribirá el resultado en el gráfico.
MATCH (n:Place {id: 'D'})
CALL gds.beta.spanningTree.write('graph', {
  sourceNode: id(n),
  relationshipWeightProperty: 'cost',
  writeProperty: 'writeCost',
  writeRelationshipType: 'MINST'
})
YIELD preProcessingMillis, computeMillis, writeMillis, effectiveNodeCount
RETURN preProcessingMillis, computeMillis, writeMillis, effectiveNodeCount;

## Para encontrar las relaciones incluidas en el árbol de expansión mínimo, podemos ejecutar la siguiente consulta:
MATCH path = (n:Place {id: 'D'})-[:MINST*]-()
WITH relationships(path) AS rels
UNWIND rels AS rel
WITH DISTINCT rel AS rel
RETURN startNode(rel).id AS Source, endNode(rel).id AS Destination, rel.writeCost AS Cost

MATCH (n) DETACH DELETE n


# Crea el grafo con los costos mensionados

CREATE (a:Location {name: 'A'}),
			   (b:Location {name: 'B'}),
			   (c:Location {name: 'C'}),
			   (d:Location {name: 'D'}),
			   (e:Location {name: 'E'}),
			   (f:Location {name: 'F'}),
			   (a)-[:ROAD {cost: 50}]->(b),
			   (b)-[:ROAD {cost: 50}]->(a),
			   (a)-[:ROAD {cost: 50}]->(c),
			   (c)-[:ROAD {cost: 50}]->(a),
			   (a)-[:ROAD {cost: 100}]->(d),
			   (d)-[:ROAD {cost: 100}]->(a),
			   (b)-[:ROAD {cost: 40}]->(d),
			   (d)-[:ROAD {cost: 40}]->(b),
			   (c)-[:ROAD {cost: 40}]->(d),
			   (d)-[:ROAD {cost: 40}]->(c),
			   (c)-[:ROAD {cost: 80}]->(e),
			   (e)-[:ROAD {cost: 80}]->(c),
			   (d)-[:ROAD {cost: 30}]->(e),
			   (e)-[:ROAD {cost: 30}]->(d),
			   (d)-[:ROAD {cost: 80}]->(f),
			   (f)-[:ROAD {cost: 80}]->(d),
			   (e)-[:ROAD {cost: 40}]->(f),
			   (f)-[:ROAD {cost: 40}]->(e);


# Llama el grafo con el nombre migrafo
CALL gds.graph.project(
			'miGrafo',
			'Location',
			'ROAD',
			{
				relationshipProperties: 'cost'
			}
		)


MATCH (l:Location) RETURN l					

## llamamos al grafo que creamos para encotrar el camino mas corto
## con relacion de costo el cost
### Usamos 'id(source)' para obtener el ID del nodo fuente
### Usamos 'id(target)' para obtener el ID del nodo destino
MATCH (source :Location {name: 'A'}), (target :Location {name: 'F'})
CALL gds.shortestPath.dijkstra.write.estimate('miGrafo', {
  sourceNode: id(source), 
  targetNode: id(target),  
  relationshipWeightProperty: 'cost',
  writeRelationshipType: 'PATH'})
YIELD nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory
RETURN nodeCount, relationshipCount, bytesMin, bytesMax, requiredMemory

# nodeCount: El número de nodos involucrados en el cálculo del camino más corto, es decir, el número de nodos que se han considerado en el proceso.

# relationshipCount: El número de relaciones entre los nodos que se han considerado en el cálculo del camino más corto.

# bytesMin: La cantidad mínima de memoria utilizada en el cálculo del camino más corto.

# bytesMax: La cantidad máxima de memoria utilizada en el cálculo del camino más corto.

# requiredMemory: La cantidad de memoria que se requirió para llevar a cabo el cálculo del camino más corto.


###################################################################
# Repetiomos el proceso

MATCH (source:Location {name: 'A'}), (target:Location {name: 'E'})
CALL gds.shortestPath.dijkstra.stream('miGrafo', {
			sourceNode: source,
			targetNode: target,
			relationshipWeightProperty: 'cost'})
YIELD index, sourceNode, targetNode, totalCost, nodeIds, costs, path
		RETURN
			index,
			gds.util.asNode(sourceNode).name AS sourceNodeName,
			gds.util.asNode(targetNode).name AS targetNodeName,
			totalCost,
			[nodeId IN nodeIds | gds.util.asNode(nodeId).name] AS nodeNames,
			costs,
			nodes(path) as path
		ORDER BY index


### comandos que encontre

### Llamar el nodo 11
MATCH (node)
WHERE id(node) = 11
RETURN node

# eliminar grafo con sus relaciones
MATCH (l:Location)
OPTIONAL MATCH (l)-[r]-()
DELETE l, r
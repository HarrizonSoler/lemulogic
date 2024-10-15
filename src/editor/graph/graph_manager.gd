class_name GraphManager extends Node

const save_resource = preload("res://src/editor/saving/routine_save.gd")

@export var graph: GraphFacade

var node_id_count: int = 0

func _ready() -> void:
	EditorSingleton.ADD_NODE.connect(add_node)

func get_routine() -> Routine:
	var routine := Routine.new()
	
	routine.set_nodes(graph.get_routine_nodes())
	routine.connections = graph.get_routine_connections()
	
	return routine

func add_node(_node: RoutineNode, keep_position: bool = false) -> void:
	if keep_position == false:
		_node.position_offset = (graph.scroll_offset + graph.size / 2) / graph.zoom - _node.size / 2
		
	_node.set_id(node_id_count)
	node_id_count += 1
	
	graph.add_child(_node)
	
func load_nodes(_nodes: Array[RoutineNode]) -> void:
	for _node in _nodes:
		add_node(_node, true)

func set_graph_state(_nodes: Array[RoutineNode], _connections: Array[Dictionary]) -> void:
	# Reset graph
	graph.clear()
	
	# Set nodes
	for _node in _nodes:
		_node.reparent(graph)
	
	# Set connections
	graph.set_connections(_connections)
	
func set_new_id_count(count: int) -> void:
	print("GraphManager: ", count)
	node_id_count = count

func save_graph() -> save_resource:
	var scene := PackedScene.new()
	
	for child in graph.get_children():
		child.set_owner(graph)
	
	scene.pack(graph)
	
	var save := save_resource.new()
	
	save.set_params(
		scene,
		graph.get_connection_list(),
		RoutineSingleton.get_variables(),
		node_id_count
	)
	
	return save

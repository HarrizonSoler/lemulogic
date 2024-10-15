class_name GraphFacade extends GraphEdit

# TODO: fix machetazo
@export var context_type = preload("res://ui/editor/node/types/context.tres")

func _ready() -> void:
	OS.low_processor_usage_mode = true
	_enable_right_disconnect()

func _enable_right_disconnect() -> void:
	for type in RoutineNodeSlot.Type.size():
		add_valid_right_disconnect_type(type)
	
func delete_node(_node: RoutineNode) -> void:
	for connection in _get_node_connections(_node.name):
		disconnect_node(
			connection.from_node, connection.from_port, 
			connection.to_node, connection.to_port
		)
		
	_node.selected = false
	remove_child(_node)
	_node.queue_free()
	
func _get_node_connections(node_name: StringName) -> Array[Dictionary]:
	return get_connection_list().filter(func(connection: Dictionary):
		return (connection.from_node == node_name) or (connection.to_node == node_name)
	)

func get_routine_nodes() -> Array[RoutineNode]:
	var result: Array[RoutineNode]
	result.assign(get_children().filter(func (node): return node is RoutineNode))
	
	return result

func get_routine_connections() -> Array[RoutineConnection]:
	var result: Array[RoutineConnection]
	
	result.assign(get_connection_list().map(_build_connection))
	return result

func _build_connection(_connection: Dictionary) -> RoutineConnection:
	var data = _get_connection_data(
		_connection.from_node, _connection.from_port, 
		_connection.to_node, _connection.to_port
	)
	
	var connection := RoutineConnection.new()
	connection.set_args(data.from_node.name, data.from_slot.name, data.to_node.name, data.to_slot.name)
	
	return connection

func _on_connection_request(from_node_name: StringName, from_port: int, to_node_name: StringName, to_port: int) -> void:
	# Should not connect to itself
	if from_node_name == to_node_name: return
	
	var data = _get_connection_data(from_node_name, from_port, to_node_name, to_port)
	
	# Check slot restriction
	# TODO: fix machetazo
	if data.from_slot.type_restriction:
		if data.to_node.type != context_type and data.to_node.type != data.from_slot.type_restriction:
			return

	if data.to_slot.type_restriction:
		if data.from_node.type != context_type and data.from_node.type != data.to_slot.type_restriction:
			return
	
	var connections := get_connection_list()
	
	if data.from_slot.capacity == RoutineNodeSlot.Capacity.SINGLE:
		if connections.any(func(connection):
			return connection.from_node == from_node_name and connection.from_port == from_port
		):
			return
	
	if data.to_slot.capacity == RoutineNodeSlot.Capacity.SINGLE:
		if connections.any(func(connection): 
			return connection.to_node == to_node_name and connection.to_port == to_port
		):
			return
	
	connect_node(from_node_name, from_port, to_node_name, to_port)

func _on_disconnection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	disconnect_node (from_node, from_port, to_node, to_port)

func _get_connection_data(from_node_name: StringName, from_port: int, to_node_name: StringName, to_port: int) -> Dictionary:
	var from_node: RoutineNode = get_node(NodePath(from_node_name))
	var to_node: RoutineNode = get_node(NodePath(to_node_name))
	
	return {
		"from_node": from_node,
		"to_node": to_node,
		"from_slot": from_node.get_output_port_routine_slot(from_port),
		"to_slot": to_node.get_input_port_routine_slot(to_port)
	}

func clear() -> void:
	for _node in get_routine_nodes():
		delete_node(_node)

func set_connections(_connections: Array[Dictionary]) -> void:
	for _connection in _connections:
		connect_node(_connection.from_node, _connection.from_port, _connection.to_node, _connection.to_port)

func _on_delete_nodes_request(nodes: Array[StringName]) -> void:
	for node_name in nodes:
		var _node: RoutineNode = get_node(NodePath(node_name))
		delete_node(_node)

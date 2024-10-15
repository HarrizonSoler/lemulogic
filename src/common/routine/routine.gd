class_name Routine extends Resource

# key: StringName, value: RoutineNode
@export var nodes: Dictionary
@export var connections: Array[RoutineConnection]

#func _init(_nodes: Array[RoutineNode], _connections: Array[RoutineConnection]) -> void:
	#nodes = get_nodes_as_dict(_nodes)
	#connections = _connections

func set_nodes(_nodes: Array[RoutineNode]) -> void:
	nodes = map_nodes_to_dict(_nodes)

func map_nodes_to_dict(_nodes: Array[RoutineNode]) -> Dictionary:
	var dict: Dictionary = {}
	
	for node in _nodes:
		dict[node.name] = node
	
	return dict

func get_node_parent(node_id: StringName) -> StringName:
	var search := connections.filter(func(connection: RoutineConnection):
		return connection.to_node == node_id
	)
	
	if search.size() != 1:
		printerr("Routine: get_node_parent unsuccessful search for node ", node_id)
		return ""
	
	return search[0].from_node

func get_connected_node_name(node_id: StringName, slot_name: StringName) -> StringName:
	var result = connections.filter(func(connection: RoutineConnection):
		return connection.has_node_and_slot(node_id, slot_name)
	)
	
	if result.is_empty():
		printerr("Routine: get_connected_node_name: connections with node ", node_id, " and slot ", slot_name, " not found")
		return ""
	
	return result[0].get_opposite_node(node_id)

func get_connected_node_names(node_id: StringName, slot_name: StringName) -> Array:
	var result = connections.filter(func(connection: RoutineConnection):
		return connection.has_node_and_slot(node_id, slot_name)
	).map(func(connection: RoutineConnection):
		return connection.get_opposite_node(node_id)
	)
	
	# Sort by Y position in graph
	result.sort_custom(func(a, b):
		return nodes[a].position_offset.y < nodes[b].position_offset.y
	)
	
	return result

func check_variables_assigned(variables: Array[StringName]) -> Dictionary:
	var search_assign_nodes = nodes.values().filter(func(node: RoutineNode):
		return node.keyword == "VARIABLE_ASSIGN"
	)
	
	for variable in variables:
		if not search_assign_nodes.any(func(node: RoutineNode): return node.variable_name == variable):
			return {
				"success": false,
				"error": "Variable " + variable + " has not been assigned any value"
			}
	
	return {
		"success": true
	}

func check_slots() -> Dictionary:
	if not nodes.has("BaseStart"): 
		return {
			"success": false,
			"error": "Start node not found" 
		}
	
	var slot_check_result := check_node_slots_recursive("BaseStart", "")
	if not slot_check_result.success: return slot_check_result
	
	return {
		"success": true
	}

func check_node_slots_recursive(node_id: StringName, from_slot: StringName) -> Dictionary:
	var _node: RoutineNode = nodes[node_id]
	
	# Remove slot where checking came from
	var _filtered_slots := _node.slots.filter(func(slot): return slot.name != from_slot)
	#print("    Routine: slots: ", _node.slots.map(func(slot): return slot.name), " filtered ", _filtered_slots)
	
	for slot in _filtered_slots:
		var _connected_nodes := get_data_from_slot(node_id, slot.name)
		if not slot.is_optional and _connected_nodes.is_empty(): return {
			"success": false,
			"error": "The required slot " + slot.name + " on node " + str(_node.id) + " is not connected to anything"
		}
		
		var node_check_result: Dictionary
		for node_data in _connected_nodes:
			node_check_result = check_node_slots_recursive(node_data.node, node_data.slot)
			if not node_check_result.success: return node_check_result
	
	return {
		"success": true
	}

func get_data_from_slot(node_id: StringName, slot: StringName) -> Array:
	return connections.filter(func(connection: RoutineConnection):
		return connection.has_node_and_slot(node_id, slot)
	).map(func(connection: RoutineConnection):
		return {
			"node": connection.get_opposite_node(node_id),
			"slot": connection.get_opposite_slot(node_id)
		}
	)

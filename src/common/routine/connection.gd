class_name RoutineConnection extends Resource

var from_node: StringName
var from_slot: StringName
var to_node: StringName
var to_slot: StringName

func set_args(_from_node: StringName, _from_slot: StringName, _to_node: StringName, _to_slot: StringName) -> void:
	from_node = _from_node
	to_node = _to_node
	from_slot = _from_slot
	to_slot = _to_slot

func has_node_and_slot(node_id: StringName, slot_name: StringName) -> bool:
	if from_node != node_id and to_node != node_id: return false
	
	if from_node == node_id and from_slot != slot_name: return false
	if to_node == node_id and to_slot != slot_name: return false
	
	return true

func has_node(node_id: StringName) -> bool:
	return from_node == node_id or to_node == node_id

func get_opposite_node(node_id: StringName) -> StringName:
	if not has_node(node_id): return ""
	
	if from_node == node_id: 
		return to_node
	
	return from_node

func get_opposite_slot(node_id: StringName) -> StringName:
	if not has_node(node_id): return ""
	
	if from_node == node_id: 
		return to_slot
	
	return from_slot

func to_dictionary() -> Dictionary:
	return {
		"from_node": from_node,
		"from_slot": from_slot,
		"to_node": to_node,
		"to_slot": to_slot
	}

func _to_string() -> String:
	return "from_node: " + from_node + " to_node: " + to_node + " from_slot: " + from_slot + " to_slot: " + to_slot

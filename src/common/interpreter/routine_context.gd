class_name RoutineContext extends Node

enum ExecutionResult {
	NODE_END_REACHED,
	ROUTINE_END_REACHED,
	LOOP_END_REACHED,
	LOOP_START_REACHED
}

var routine: Routine
var variables: Dictionary = {}
# Only used for "for" nodes
var started_nodes: Array[StringName] = []

func _init(_routine: Routine, _variables: Array[StringName]) -> void:
	routine = _routine
	_set_variables(_variables)

func _set_variables(_variables: Array[StringName]) -> void:
	for variable in _variables:
		variables[variable] = "NaN"

func execute_node(node_id: StringName, loop_node_id: StringName = "") -> Dictionary:
	if not routine.nodes.has(node_id):
		printerr("RoutineContext: Node ID ", node_id, " does not exist in routine")
		return {}
	
	var node: RoutineNode = routine.nodes[node_id]
	var result = node.execute(self, loop_node_id)
	
	if result.status == ExecutionResult.LOOP_END_REACHED:
		var parent_id := routine.get_node_parent(node_id)
		
		return routine.nodes[parent_id].execute(self, node_id)
	
	return result

func get_value_from_slot(caller: RoutineNode, slot_name: StringName):
	#print("RoutineContext: get_value_from_slot with caller ", caller, " slot ", slot_name)
	return routine.nodes[get_node_name_from_slot(caller, slot_name)].get_value(self)

func get_node_names_from_slot(caller: RoutineNode, slot_name: StringName, loop_node: StringName = "") -> Array:
	#print("RoutineContext: get_node_names_from_slot with caller ", caller, " slot ", slot_name, " loop_node:", loop_node)
	var nodes := routine.get_connected_node_names(caller.name, slot_name)
	
	if not loop_node.is_empty():
		var found := nodes.find(loop_node)
		
		if found == -1:
			printerr("RoutineContext: loop_node ", loop_node, " not found in node", caller.name)
		else:
			nodes = nodes.slice(found + 1)
	
	return nodes

func get_node_name_from_slot(caller: RoutineNode, slot_name: StringName) -> StringName:
	#print("RoutineContext: get_node_name_from_slot: caller ", caller, " slot ", slot_name)
	return routine.get_connected_node_name(caller.name, slot_name)

func get_variable_value(variable_name: StringName):
	if variables.has(variable_name): return variables[variable_name]

func set_variable_value(variable_name: StringName, value) -> void:
	if not variables.has(variable_name):
		printerr("RoutineContext: set_variable_value: variable ", variable_name, " does not exist")
		return
	
	variables[variable_name] = value

func set_variable_value_on_node_start(caller: RoutineNode, variable: StringName, value) -> void:
	if not started_nodes.has(caller.name):
		started_nodes.append(caller.name)
		set_variable_value(variable, value)

func remove_from_started_nodes(caller: RoutineNode) -> void:
	if started_nodes.has(caller.name):
		started_nodes.erase(caller.name)

func execute_environment_function(_name: StringName, args: Dictionary = {}):
	return EnvironmentSingleton.call_function(_name, args)

extends RoutineNode

func execute(context: RoutineContext, loop_node_id: StringName = "") -> Dictionary:
	#print("LogicWhile ", name, ": executed with loop_node(", loop_node_id, ")")
	if not context.get_value_from_slot(self, "CONDITION"):
		return {
			"status": RoutineContext.ExecutionResult.LOOP_END_REACHED
		}
	
	for node_id in context.get_node_names_from_slot(self, "THEN", loop_node_id):
		#print("LogicWhile: ", name, " executing node: ", node_id)
		var result := context.execute_node(node_id)
		if result.status == RoutineContext.ExecutionResult.LOOP_START_REACHED or result.status == RoutineContext.ExecutionResult.LOOP_END_REACHED: 
			return result
	
	return {
		"status": RoutineContext.ExecutionResult.LOOP_START_REACHED,
		"loop_node": name
	}

extends RoutineNode

func execute(context: RoutineContext, loop_node_id: StringName = "") -> Dictionary:
	for node_id in context.get_node_names_from_slot(self, "START", loop_node_id):
		var result := context.execute_node(node_id)
		if result.status == RoutineContext.ExecutionResult.LOOP_START_REACHED or result.status == RoutineContext.ExecutionResult.LOOP_END_REACHED: 
			return result
	
	return {
		"status": RoutineContext.ExecutionResult.ROUTINE_END_REACHED
	}

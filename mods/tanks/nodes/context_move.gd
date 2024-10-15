extends RoutineNode

func execute(context: RoutineContext, _loop_node_id: StringName = "") -> Dictionary:
	context.execute_environment_function("MOVE", {
		"angle": context.get_value_from_slot(self, "ANGLE")
	})
	
	return {
		"status": RoutineContext.ExecutionResult.ROUTINE_END_REACHED
	}

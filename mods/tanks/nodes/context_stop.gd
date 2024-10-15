extends RoutineNode

func execute(context: RoutineContext, _loop_node_id: StringName = "") -> Dictionary:
	context.execute_environment_function("STOP")
	
	return {
		"status": RoutineContext.ExecutionResult.ROUTINE_END_REACHED
	}

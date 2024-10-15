extends RoutineNode

func get_value(context: RoutineContext) -> int:
	return context.execute_environment_function("GET_HEALTH")

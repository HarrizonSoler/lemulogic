extends RoutineNode

func get_value(context: RoutineContext) -> bool:
	var angle = context.get_value_from_slot(self, "ANGLE")
	
	return context.execute_environment_function("SCAN", {
		"angle": angle
	})

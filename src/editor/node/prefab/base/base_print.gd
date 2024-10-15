extends RoutineNode

func execute(context: RoutineContext, _loop_node_id: StringName = "") -> Dictionary:
	#print("BasePrint: executed with loop_node(", _loop_node_id, ")")
	print(context.get_value_from_slot(self, "VALUE"))
	
	return {
		"status": RoutineContext.ExecutionResult.NODE_END_REACHED
	}

extends RoutineNode

@export var variable_option: OptionButton
@export var step_input: SpinBox

func execute(context: RoutineContext, loop_node_id: StringName = "") -> Dictionary:
	var variable = variable_option.get_item_text(variable_option.selected)
	
	if loop_node_id == "": 
		context.set_variable_value_on_node_start(
			self,
			variable, 
			context.get_value_from_slot(self, "START_VALUE")
		)
	
	if not context.get_value_from_slot(self, "CONDITION"):
		context.remove_from_started_nodes(self)
		
		return {
			"status": RoutineContext.ExecutionResult.LOOP_END_REACHED
		}
	
	for node_id in context.get_node_names_from_slot(self, "THEN", loop_node_id):
		var result := context.execute_node(node_id)
		if result.status == RoutineContext.ExecutionResult.LOOP_START_REACHED or result.status == RoutineContext.ExecutionResult.LOOP_END_REACHED: 
			return result
	
	context.set_variable_value(
			variable, 
			context.get_variable_value(variable) + step_input.value
	)
	
	return {
		"status": RoutineContext.ExecutionResult.LOOP_START_REACHED,
		"loop_node": name
	}

extends RoutineNode

enum Evaluation {
	AND,
	OR
}

@export var type_input: OptionButton

func get_value(context: RoutineContext) -> bool:
	#print("LogicEvaluation: executed")
	var value_1 = context.get_value_from_slot(self, "VALUE_1")
	var value_2 = context.get_value_from_slot(self, "VALUE_2")
	
	match type_input.selected as Evaluation:
		Evaluation.AND:
			return value_1 and value_2
		Evaluation.OR:
			return value_1 or value_2
		_:
			printerr("LogicEvaluation: Invalid type_input ", type_input.selected)
			return false

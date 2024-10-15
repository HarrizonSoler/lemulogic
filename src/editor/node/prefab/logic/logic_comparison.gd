extends RoutineNode

enum Comparation {
	EQUAL,
	DIFFERENT,
	LESS_THAN,
	LESS_THAN_EQUAL,
	GREATER_THAN,
	GREATER_THAN_EQUAL
}

@export var type_input: OptionButton

func get_value(context: RoutineContext) -> bool:
	#print("LogicComparison: executed")
	var value_1 = context.get_value_from_slot(self, "VALUE_1")
	var value_2 = context.get_value_from_slot(self, "VALUE_2")
	
	match type_input.selected as Comparation:
		Comparation.EQUAL:
			return value_1 == value_2
		Comparation.DIFFERENT:
			return value_1 != value_2
		Comparation.LESS_THAN:
			return value_1 < value_2
		Comparation.LESS_THAN_EQUAL:
			return value_1 <= value_2
		Comparation.GREATER_THAN:
			return value_1 > value_2
		Comparation.GREATER_THAN_EQUAL:
			return value_1 >= value_2
		_:
			printerr("LogicComparison: Invalid type_input ", type_input.selected)
			return false

extends RoutineNode

enum Operation {
	ADDITION,
	SUBSTRACTION,
	MULTIPLICATION,
	DIVISION
}

@export var type_input: OptionButton

func get_value(context: RoutineContext):
	#print("MathOperation: executed")
	var value_1 = context.get_value_from_slot(self, "VALUE_1")
	var value_2 = context.get_value_from_slot(self, "VALUE_2")
	
	match type_input.selected as Operation:
		Operation.ADDITION:
			return value_1 + value_2
		Operation.SUBSTRACTION:
			return value_1 - value_2
		Operation.MULTIPLICATION:
			return value_1 * value_2
		Operation.DIVISION:
			return value_1 / value_2
		_:
			printerr("MathOperation: Invalid type_input ", type_input)
			return false

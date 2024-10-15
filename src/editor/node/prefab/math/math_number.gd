extends RoutineNode

@export var input: SpinBox

func get_value(_context: RoutineContext):
	#print("MathNumber: executed")
	return input.value

extends RoutineNode

enum Axis {
	X,
	Y
}

@export var axis_input: OptionButton

func get_value(context: RoutineContext) -> int:
	match axis_input.selected as Axis:
		Axis.X:
			return context.execute_environment_function("GET_X")
		Axis.Y:
			return context.execute_environment_function("GET_Y")
		_:
			printerr("ContextGetPosition: Invalid type_input ", axis_input.selected)
			return -1

extends RoutineNode

enum Bool {
	TRUE,
	FALSE
}

@export var input: OptionButton

func get_value(_context: RoutineContext):
	match input.selected:
		Bool.TRUE: 
			return true
		Bool.FALSE: 
			return false
		_: 
			printerr("LogicBool: Invalid option")
			return

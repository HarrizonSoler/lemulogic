class_name VariablesManager extends Resource

var variables: Array[StringName] = []

func is_in_variables(_name: StringName) -> bool:
	return variables.any(func(variable: StringName): return variable == _name)

func add(_name: StringName) -> void:
	if is_in_variables(_name): return
	
	variables.append(_name)
	
	RoutineSingleton.VARIABLE_ADDED.emit(_name)

func set_variables(_names: Array[StringName]) -> void:
	clear()
	
	for _name in _names:
		add(_name)

func remove(_name: StringName) -> void:
	if is_in_variables(_name):
		variables.erase(_name)
		RoutineSingleton.VARIABLE_REMOVED.emit(_name)

func clear() -> void:
	for variable in variables:
		RoutineSingleton.VARIABLE_REMOVED.emit(variable)
	
	variables = []

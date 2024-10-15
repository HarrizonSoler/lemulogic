extends OptionButton

func _ready() -> void:
	repopulate()
	
	RoutineSingleton.VARIABLE_ADDED.connect(_on_variable_added)
	RoutineSingleton.VARIABLE_REMOVED.connect(_on_variable_removed)

func _on_variable_added(variable: StringName) -> void:
	repopulate()

func _on_variable_removed(variable: StringName) -> void:
	repopulate()

func repopulate() -> void:
	clear()
	
	for variable in RoutineSingleton.get_variables():
		add_item(variable)

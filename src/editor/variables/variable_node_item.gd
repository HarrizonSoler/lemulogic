extends NodeSidebarItem

var variable_name: String

func set_var(_variable_name: StringName) -> void:
	RoutineSingleton.VARIABLE_REMOVED.connect(_check_removed_var)
	variable_name = _variable_name

func _check_removed_var(removed_variable: StringName) -> void:
	if removed_variable == variable_name: queue_free()

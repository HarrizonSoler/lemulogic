extends HBoxContainer

@export var variable_label: Label

var variable_name: StringName

func _ready() -> void:
	variable_label.text = variable_name
	RoutineSingleton.VARIABLE_REMOVED.connect(check_deleted_var)

func set_var(_variable_name: StringName) -> void:
	variable_name = _variable_name

func check_deleted_var(_name: StringName) -> void:
	if _name == variable_name:
		queue_free()

func _on_delete_button_pressed() -> void:
	RoutineSingleton.variables_manager.remove(variable_name)
	queue_free()

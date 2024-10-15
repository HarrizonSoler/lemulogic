extends RoutineNode

@export var variable_name: String
@export var variable_label: Label

func _ready() -> void:
	super._ready()
	variable_label.text = variable_name
	RoutineSingleton.VARIABLE_REMOVED.connect(_check_removed_var)

func set_variable(_name: StringName) -> void:
	variable_name = _name
	variable_label.text = _name

func _check_removed_var(removed_variable: StringName) -> void:
	if removed_variable == variable_name: queue_free()

func get_value(context: RoutineContext):
	#print("GetVariable: executed")
	return context.get_variable_value(variable_name)

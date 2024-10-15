extends RoutineNode

@export var variable_name: StringName
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

func execute(context: RoutineContext, _loop_node_id: StringName = "") -> Dictionary:
	#print("VariableAssign: executed with loop_node(", _loop_node_id, ")")
	context.set_variable_value(variable_name, context.get_value_from_slot(self, "VALUE"))
	
	return {
		"status": RoutineContext.ExecutionResult.NODE_END_REACHED
	}

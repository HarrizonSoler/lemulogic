extends Node

var routine: Routine
var graph: GraphFacade
var variables_manager: VariablesManager = VariablesManager.new()

signal VARIABLE_ADDED(name: StringName)
signal VARIABLE_REMOVED(name: StringName)

func set_routine(_routine: Routine) -> void:
	routine = _routine

func get_routine() -> Routine:
	return routine

func get_variables() -> Array[StringName]:
	return variables_manager.variables
	
func set_graph(_graph: GraphFacade) -> void:
	graph = _graph

func get_graph():
	return graph

func announce_variables() -> void:
	for variable in variables_manager.variables:
		VARIABLE_ADDED.emit(variable)

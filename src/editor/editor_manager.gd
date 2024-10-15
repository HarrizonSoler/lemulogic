class_name EditorManager extends Node

const SAVE_RESOURCE_PATH = "res://src/editor/saving/routine_save.gd"
const EXECUTION_SCENE = "res://ui/execution/execution.tscn"

@export var continue_button: Button
@export var graph_manager: GraphManager
@export var graph: GraphFacade
@export var error_popup: ErrorPopup

@export var save_button: Button
@export var load_button: Button

func _ready() -> void:
	# Re create variables
	RoutineSingleton.announce_variables()
	
	var singleton_graph: GraphFacade = RoutineSingleton.get_graph()
	
	# If have already a graph in memory
	if singleton_graph != null:
		graph_manager.set_graph_state(
			singleton_graph.get_routine_nodes(),
			singleton_graph.get_connection_list(),
		)
	
	continue_button.pressed.connect(_finish_requested)
	save_button.pressed.connect(_save_graph)
	load_button.pressed.connect(_load_graph)

func _finish_requested() -> void:
	var routine = graph_manager.get_routine()
	
	if not _is_routine_valid(routine):
		return
		
	RoutineSingleton.set_routine(routine)
	RoutineSingleton.set_graph(graph)
	
	graph.reparent(RoutineSingleton)
	graph.hide()
	
	get_tree().change_scene_to_file(EXECUTION_SCENE)

func _is_routine_valid(routine: Routine) -> bool:
	var vars_assign_check = routine.check_variables_assigned(RoutineSingleton.get_variables())
	
	if not vars_assign_check.success:
		#printerr("EditorManager: error checking variables: ", vars_assign_check.error)
		error_popup.show_error(vars_assign_check.error)
		return false
	
	var slots_check = routine.check_slots()
	
	if not slots_check.success:
		#printerr("EditorManager: error checking routine: ", slots_check.error)
		error_popup.show_error(slots_check.error)
		return false
	
	return true

func _save_graph() -> void:
	var save := graph_manager.save_graph()
	ResourceSaver.save(save, "user://routine_save.tres")

func _load_graph() -> void:
	if ResourceLoader.exists("user://routine_save.tres"):
		var save := ResourceLoader.load("user://routine_save.tres", SAVE_RESOURCE_PATH)
		var saved_graph: GraphFacade = save.graph.instantiate()
		
		# Set variables or reset
		if not save.variables.is_empty():
			RoutineSingleton.variables_manager.set_variables(save.variables)
		else:
			RoutineSingleton.variables_manager.clear()
		
		graph_manager.set_new_id_count(save.node_id_count)
	
		graph_manager.set_graph_state(
			saved_graph.get_routine_nodes(),
			save.connections
		)

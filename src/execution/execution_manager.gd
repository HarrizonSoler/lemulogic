extends PanelContainer

const editor_scene: PackedScene = preload("res://ui/editor/editor.tscn")

@export var return_button: Button
@export var start_button: Button
@export var viewport: SubViewport
@export var environment_container: Container
@export var pre_start_container: Container

var interpreter: RoutineInterpreter

var is_routine_on: bool = false
var is_routine_finished: bool = false

func _ready() -> void:
	interpreter = RoutineInterpreter.new(
		RoutineSingleton.get_routine(), 
		RoutineSingleton.get_variables()
	)
	
	return_button.pressed.connect(_return_to_editor)
	start_button.pressed.connect(_on_start_button_pressed)
	
	EnvironmentSingleton.ENVIRONMENT_ENDED.connect(_on_environment_ended)
	
	environment_container.hide()
	pre_start_container.show()
	
	get_tree().paused = true

func _process(_delta: float) -> void:
	if is_routine_on and not is_routine_finished:
		if interpreter.tick() == RoutineInterpreter.TickReturn.ROUTINE_ENDED: 
			is_routine_finished = true

func get_environment_scene() -> Dictionary:
	var path := EnvironmentSingleton.mod_path
	
	if path.is_empty(): 
		printerr("ExecutionManager: Mod path is empty")
		return {
			"success": false
		}
	
	path += "/scene.tscn"
	
	if not ResourceLoader.exists(path):
		printerr("ExecutionManager: Mod scene file not found")
		return {
			"success": false
		}
	
	return {
		"success": true,
		"scene": ResourceLoader.load(path)
	}

func _return_to_editor() -> void:
	get_tree().change_scene_to_file("res://ui/editor/editor.tscn")

func _on_start_button_pressed() -> void:
	get_tree().paused = false
	load_scene()
	
	pre_start_container.hide()
	environment_container.show()
	
	is_routine_on = true
	start_button.disabled = true

func load_scene() -> void:
	var mod_scene_result := get_environment_scene()
	if not mod_scene_result.success: return
	
	var mod_scene = mod_scene_result.scene.instantiate()
	viewport.add_child(mod_scene)

func _on_environment_ended() -> void:
	get_tree().paused = true
	is_routine_on = false

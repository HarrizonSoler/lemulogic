extends PanelContainer

@export var creation_dialog: Window

@export var var_items_container: VBoxContainer
@export var var_nodes_container: VBoxContainer

@export var item_scene: PackedScene

@export var var_node_item_scene: PackedScene

@export var get_var_node_scene: PackedScene
@export var assign_var_node_scene: PackedScene

func _ready() -> void:
	RoutineSingleton.VARIABLE_ADDED.connect(_create_variable)
	
func _create_variable(variable_name: StringName) -> void:
	_create_item(variable_name)
	_create_node_item(variable_name)
	
func _create_item(variable_name: StringName) -> void:
	var variable_item := item_scene.instantiate()
	variable_item.set_var(variable_name)
	
	var_items_container.add_child(variable_item)

func _create_node_item(variable_name: StringName) -> void:
	var get_var_node := get_var_node_scene.instantiate()
	get_var_node.set_variable(variable_name)
	
	var get_var_node_item := var_node_item_scene.instantiate()
	get_var_node_item.set_title("get " + variable_name)
	get_var_node_item.set_var(variable_name)
	get_var_node_item.set_node(get_var_node)
	
	var assign_var_node := assign_var_node_scene.instantiate()
	assign_var_node.set_variable(variable_name)
	
	var assign_var_node_item := var_node_item_scene.instantiate()
	assign_var_node_item.set_title("assign " + variable_name)
	assign_var_node_item.set_var(variable_name)
	assign_var_node_item.set_node(assign_var_node)
	
	var_nodes_container.add_child(get_var_node_item)
	var_nodes_container.add_child(assign_var_node_item)

func _on_create_button_pressed() -> void:
	creation_dialog.show()

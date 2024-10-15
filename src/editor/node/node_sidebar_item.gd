class_name NodeSidebarItem extends Button

var node: RoutineNode

func set_title(_text: String) -> void:
	text = _text

func set_node(_node: RoutineNode) -> void:
	node = _node

func _on_pressed() -> void:
	EditorSingleton.ADD_NODE.emit(node.duplicate())

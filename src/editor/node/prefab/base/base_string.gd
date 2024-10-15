extends RoutineNode

#@export var text: String
@export var text_input: TextEdit

#func _ready() -> void:
#	text_input.text = text

func get_value(_context: RoutineContext) -> String:
	return text_input.text

func _on_text_edit_text_changed() -> void:
	pass
	#text = text_input.text

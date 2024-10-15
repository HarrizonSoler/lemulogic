extends PopupPanel

const WINDOW_EXPANDED_HEIGHT = 116
const WINDOW_COMPACT_HEIGHT = 90

@export var var_name_input: LineEdit
@export var error_label: Label

func _on_close_requested() -> void:
	_exit()

func _on_ok_button_pressed() -> void:
	if var_name_input.text.is_empty(): 
		_show_error("invalid empty var name")
		return
	
	if var_name_input.text.contains(" "):
		_show_error("invalid var name with spaces")
		return
	
	if RoutineSingleton.variables_manager.is_in_variables(var_name_input.text):
		_show_error("var already exists")
		return
	
	RoutineSingleton.variables_manager.add(var_name_input.text)
	_exit()

func _on_cancel_button_pressed() -> void:
	_exit()

func _show_error(error: String) -> void:
	error_label.text = error
	size.y = WINDOW_EXPANDED_HEIGHT
	error_label.show()
	
func _hide_error() -> void:
	error_label.text = ""
	error_label.hide()
	size.y = WINDOW_COMPACT_HEIGHT

func _exit() -> void:
	var_name_input.clear()
	_hide_error()
	hide()

func _on_focus_entered() -> void:
	var_name_input.grab_focus.call_deferred()

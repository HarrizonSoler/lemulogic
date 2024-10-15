class_name RoutineNodeType extends Resource

const PANEL_STYLE: StyleBoxFlat = preload("res://ui/assets/styles/node_panel.tres")
const TITLEBAR_STYLE: StyleBoxFlat = preload("res://ui/assets/styles/node_titlebar.tres")
const SELECTED_TITLEBAR_STYLE: StyleBoxFlat = preload("res://ui/assets/styles/node_titlebar_selected.tres")

@export var title: String = ""
@export var color: Color = Color.DEEP_PINK:
	set(_color): 
		_set_styles_color(_color)
		color = _color

var panel_stylebox: StyleBoxFlat = PANEL_STYLE.duplicate()
var titlebar_stylebox: StyleBoxFlat = TITLEBAR_STYLE.duplicate()
var selected_titlebar_stylebox: StyleBoxFlat = SELECTED_TITLEBAR_STYLE.duplicate()

func _set_styles_color(_color: Color) -> void:
	panel_stylebox.border_color = _color
	titlebar_stylebox.bg_color = _color
	selected_titlebar_stylebox.bg_color = _color

func get_styles() -> Dictionary:
	return {
		"panel": panel_stylebox,
		"titlebar": titlebar_stylebox,
		"titlebar_selected": selected_titlebar_stylebox
	}

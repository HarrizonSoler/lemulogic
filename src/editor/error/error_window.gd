class_name ErrorPopup extends Window

@export var error_label: Label

func show_error(error: String) -> void:
	error_label.text = error
	show()

func exit() -> void:
	error_label.text = ""
	hide()

func _on_close_requested() -> void:
	exit()

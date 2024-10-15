class_name EndingUI extends CanvasLayer

@export var winner_box: Control
@export var loser_box: Control

@export var time_label: Label

func show_winner(milisec_elapsed: int) -> void:
	var seconds = int(milisec_elapsed / 1000)
	var minutes = int(seconds / 60)
	time_label.text = '%02d:%02d' % [minutes, seconds]
	
	loser_box.hide()
	winner_box.show()
	show()

func show_loser() -> void:
	winner_box.hide()
	loser_box.show()
	show()

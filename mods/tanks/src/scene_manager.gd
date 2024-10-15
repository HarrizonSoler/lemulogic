extends Node

@export var context_factory: ContextFactory
@export var game_timer: Timer
@export var ending_ui: EndingUI

@export var msec_at_start: int
func _ready() -> void:
	EnvironmentSingleton.set_functions(context_factory.get_functions())
	ArenaEvents.TANK_DAMAGED.connect(_check_winner)
	msec_at_start = Time.get_ticks_msec()

func _check_winner(damaged_tank_id: StringName, health: int) -> void:
	if health > 0: return
	
	if damaged_tank_id == "PLAYER":
		ending_ui.show_loser()
	else:
		var msec_elapsed: int = Time.get_ticks_msec() - msec_at_start
		ending_ui.show_winner(msec_elapsed)
		
	EnvironmentSingleton.ENVIRONMENT_ENDED.emit()
	get_tree().paused = true

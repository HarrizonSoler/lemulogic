extends CanvasLayer

@export var player_bar: ProgressBar
@export var enemy_bar: ProgressBar

var health_bars: Dictionary = {}

func _ready() -> void:
	health_bars = {
		"PLAYER": player_bar,
		"ENEMY": enemy_bar
	}
	
	ArenaEvents.TANK_DAMAGED.connect(_on_tank_damaged)

func _on_tank_damaged(damaged_id: StringName, health: int) -> void:
	if health_bars.keys().has(damaged_id):
		health_bars[damaged_id].value = health

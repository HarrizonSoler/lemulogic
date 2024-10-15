class_name ContextFactory extends Node

@export var player_tank: Tank
#@export var enemy_tank: Tank

func get_functions() -> Dictionary:
	return {
		"SHOOT": Callable.create(self, "player_shoot"),
		"MOVE": Callable.create(self, "player_move"),
		"SCAN": Callable.create(self, "player_scan"),
		"STOP": Callable.create(self, "player_stop"),
		"GET_X": Callable.create(self, "player_get_x"),
		"GET_Y": Callable.create(self, "player_get_y"),
		"GET_HEALTH": Callable.create(self, "player_get_health")
	}

func player_shoot(_args: Dictionary) -> void:
	player_tank.shoot(_args.angle)

func player_move(_args: Dictionary) -> void:
	player_tank.move(_args.angle)

func player_scan(_args: Dictionary) -> bool:
	return player_tank.scan(_args.angle)

func player_stop(_args: Dictionary) -> void:
	player_tank.stop()

func player_get_x(_args: Dictionary) -> int:
	return player_tank.global_position.x

func player_get_y(_args: Dictionary) -> int:
	return player_tank.global_position.y

func player_get_health(_args: Dictionary) -> int:
	return player_tank.health

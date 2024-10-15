extends PathFollow2D

@export var enemy: Tank

func _physics_process(delta: float) -> void:
	progress += enemy.speed * delta

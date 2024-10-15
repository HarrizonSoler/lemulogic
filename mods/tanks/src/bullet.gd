extends Area2D

var speed: int = 800

func _physics_process(delta: float) -> void:
	position += Vector2.from_angle(rotation) * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
		
	queue_free()

func _on_area_entered(_area: Area2D) -> void:
	queue_free()

func _on_timer_timeout() -> void:
	queue_free()

class_name Tank extends CharacterBody2D

@export var tank_tint: Color
@export var id: StringName = ""

@export var raycast: RayCast2D
@export var scan_line: Line2D
@export var bullet_scene: PackedScene
@export var gun_timer: Timer
@export var scan_line_timer: Timer
@export var bullet_spawn: Marker2D
@export var turret: Node2D

@export var body_sprite: Sprite2D
@export var turret_sprite: Sprite2D

@export var speed: int = 100
@export var health: int = 100
@export var gun_cooldown: float = 0.5
@export var scan_cooldown: float = 0.2
@export_range(0, 360) var shoot_angle: int = 0
#@export_range(0, 360) var move_angle: int = 0

func _ready() -> void:
	gun_timer.wait_time = gun_cooldown
	scan_line_timer.wait_time = scan_cooldown
	tint_sprites(tank_tint)
	
func tint_sprites(color: Color) -> void:
	body_sprite.modulate = color
	turret_sprite.modulate = color
	
func _physics_process(delta: float) -> void:
	if id == "PLAYER" and Input.is_key_pressed(KEY_S):
		print(scan(shoot_angle))
	move_and_collide(velocity * speed * delta)

func scan(_angle: float) -> bool:
	_angle = _convert_rotation(_angle)
	turret.global_rotation = _angle
	scan_line.show()
	
	scan_line_timer.start()
	
	return raycast.is_colliding()

func move(_angle: int) -> void:
	rotation = _convert_rotation(_angle)
	velocity = Vector2.from_angle(rotation)

func stop() -> void:
	velocity = Vector2.ZERO

func shoot(_angle: float) -> void:
	_angle = _convert_rotation(_angle)
	turret.global_rotation = _angle
	
	if not gun_timer.is_stopped():
		return
	
	_instance_bullet(_angle)
	gun_timer.start()

func _instance_bullet(_angle: float) -> void:
	var bullet = bullet_scene.instantiate()
	bullet.global_position = bullet_spawn.global_position
	bullet.rotation = _angle
	#var add_later = func():
	get_parent().add_child.call_deferred(bullet)
	#add_later.call_deferred()

func take_damage() -> void:
	health -= 10
	ArenaEvents.TANK_DAMAGED.emit(id, health)
	
	if health <= 0:
		queue_free()

func _convert_rotation(_angle: float) -> float:
	return deg_to_rad(360 - _angle)

func _on_scan_timer_timeout() -> void:
	scan_line.hide()

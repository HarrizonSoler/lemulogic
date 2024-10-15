extends Tank

const navigation_points: Array = [
	Vector2(100,  100),
	Vector2(550, 100),
	Vector2(550, 550),
	Vector2(100,  550)
]

@export var navigation: NavigationAgent2D

var points_index: int = 0
var attack_target: Node2D

func _ready() -> void:
	set_physics_process(false)
	super._ready()
	call_deferred("setup_navigation")

func setup_navigation() -> void:
	await get_tree().physics_frame
	set_physics_process(true)
	navigation.target_position = get_next_coord()

func _physics_process(_delta: float) -> void:
	process_attack()
	process_navigation()
	move_and_slide()

func process_attack() -> void:
	if attack_target:
		var angle = 360 - rad_to_deg(global_position.angle_to_point(attack_target.global_position))
		#print("Enemy: target ", attack_target.global_position, " self ", global_position, " angle ", angle)
		shoot(angle)
	
func process_navigation() -> void:
	if navigation.is_navigation_finished():
		navigation.target_position = get_next_coord()
	
	var next_path_pos := navigation.get_next_path_position()
	var new_velocity = global_position.direction_to(next_path_pos) * speed
	
	if navigation.avoidance_enabled:
		navigation.set_velocity(new_velocity)
		rotation = new_velocity.angle()
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)

func get_next_coord() -> Vector2:
	points_index = points_index + 1 if points_index + 1 < navigation_points.size() else 0
	return navigation_points[points_index]

func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2) -> void:
	rotation = safe_velocity.angle()
	velocity = safe_velocity

func _on_area_2d_body_entered(body: Node2D) -> void:
	attack_target = body

func _on_area_2d_body_exited(_body: Node2D) -> void:
	attack_target = null

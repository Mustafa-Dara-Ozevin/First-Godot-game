extends Actor
# warning-ignore:unused_argument
export var stomp_impulse: = 1000.0
var wall_falling_speed: = 80



func _on_EnemyDetector_area_entered(area):
	_velocity = calculate_stomp_velocity(_velocity,stomp_impulse)
	
	
func _on_EnemyDetector_body_entered(body):
	Die()

func _physics_process(delta): 
	var is_wall_jumping := Input.is_action_just_pressed("jump") and is_on_wall()
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction = get_direction() 
	
	_velocity = calculate_move_velocity(_velocity,direction,
	speed,is_jump_interrupted,is_wall_jumping)
	_velocity = move_and_slide(_velocity,Vector2.UP)

func get_direction():
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0)
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool,
	is_wall_jumping: bool):
		var out: = linear_velocity
		out.x = speed.x * direction.x
		out.y += gravity * get_physics_process_delta_time()
		if direction.y == -1.0:
			out.y = speed.y * direction.y
		if is_jump_interrupted:
			out.y = 0.0
		if is_on_wall() and Input.is_action_pressed("move_left"):
			out.y = wall_falling_speed
		if is_wall_jumping:
			out.x = speed.x * 5
			out.y = -Input.get_action_strength("jump") * speed.y
			print('is wall jumping')
			print('speed is:',out.y)
		return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float):
	var out = linear_velocity
	out.y = -impulse
	return out

func Die() ->void:
	PlayerData.deaths += 1
	PlayerData.score = 0
	queue_free()
	get_tree().change_scene("res://src/Levels/Level01.tscn")




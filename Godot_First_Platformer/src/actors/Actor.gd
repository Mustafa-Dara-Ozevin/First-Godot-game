extends KinematicBody2D
class_name Actor
const FLOOR_NORMAL = Vector2.UP

export var speed: = Vector2(800.0,2000.0)
export var gravity: = 4000.0

var _velocity: = Vector2.ZERO

func _physics_process(delta):
	_velocity.y += gravity * delta
	

extends Area2D

export var _score: = 25

onready var AnimationPlayer: = get_node("AnimationPlayer")

func _on_body_entered(body):
	picked()

func picked() -> void:
	AnimationPlayer.play("fade_out")
	PlayerData.score += _score

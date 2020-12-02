extends CanvasLayer

onready var label: Label = $Label

func _ready():
	PlayerData.connect("score_updated", self, "update_interface")
	


func update_interface() -> void:
	label.text = "score: %s" % [PlayerData.score]

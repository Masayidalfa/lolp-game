extends Area2D

@export var target_background: String
@onready var bg_manager = get_node("../../Background")

func _on_body_entered(body):
	if body.name == "Player":
		bg_manager.set_background(target_background)

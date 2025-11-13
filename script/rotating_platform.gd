extends Node2D

@export var radius: float = 45.0
@export var rotate_speed: float = 1.2
@export var clockwise: bool = true

var angle: float = 0.0
var start_position: Vector2
var player_on_top: CharacterBody2D = null

func _ready():
	start_position = global_position

func _process(delta: float):
	angle += (rotate_speed * delta) * (1 if clockwise else -1)
	var offset = Vector2(cos(angle), sin(angle)) * radius
	var new_position = start_position + offset
	var delta_move = new_position - global_position

	global_position = new_position

	if player_on_top:
		player_on_top.global_position += delta_move

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_on_top = body

func _on_area_2d_body_exited(body):
	if body == player_on_top:
		player_on_top = null

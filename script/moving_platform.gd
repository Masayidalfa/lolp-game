extends Node2D

@export var move_speed := 50
@export var move_distance := 64
var direction := 1
var start_y := 0
var player_on_top = null

func _ready():
	start_y = position.y

func _process(delta):
	var new_y = position.y + direction * move_speed * delta
	if abs(new_y - start_y) > move_distance:
		direction *= -1
	position.y += direction * move_speed * delta

	# Gerakkan player bersamaan
	if player_on_top:
		player_on_top.position.y += direction * move_speed * delta

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_on_top = body

func _on_area_2d_body_exited(body):
	if body == player_on_top:
		player_on_top = null

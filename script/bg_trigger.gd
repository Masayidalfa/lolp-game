extends Area2D

@export var target_background: String
@onready var bg_manager = get_node("../../Background")

var player_inside: bool = false
var last_background: String = ""


func _on_body_entered(body: Node2D) -> void:
	if body.name != "Player" or player_inside:
		return

	player_inside = true

	# Simpan background asal sebelum berubah
	last_background = bg_manager.current_bg_name

	if target_background != bg_manager.current_bg_name:
		bg_manager.set_background(target_background)
		print("➡️ Masuk area:", target_background)


func _on_body_exited(body: Node2D) -> void:
	if body.name != "Player" or not player_inside:
		return

	player_inside = false

	# Pastikan tidak kembali ke dirinya sendiri
	if last_background != bg_manager.current_bg_name:
		bg_manager.set_background(last_background)
		print("⬅️ Kembali ke:", last_background)

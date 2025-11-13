extends Node2D

@onready var fade_rect = $Manager/FadeRect
@onready var backgrounds = {
	"Beach": $Beach,
	"Grassland": $Grassland,
}

var current_bg_name: String = "Beach"
var is_fading: bool = false


func _ready() -> void:
	for bg in backgrounds.values():
		bg.visible = false

	if backgrounds.has(current_bg_name):
		backgrounds[current_bg_name].visible = true
	else:
		push_error("Background default '%s' tidak ditemukan!" % current_bg_name)

	fade_rect.visible = false


func set_background(target_name: String, use_fade: bool = true) -> void:
	if is_fading or target_name == current_bg_name:
		return

	if not backgrounds.has(target_name):
		push_error("Background '%s' tidak ditemukan!" % target_name)
		return

	is_fading = true
	var new_bg = backgrounds[target_name]
	var old_bg = backgrounds[current_bg_name]

	if use_fade:
		await _fade_out()

	old_bg.visible = false
	new_bg.visible = true
	current_bg_name = target_name

	if use_fade:
		await _fade_in()

	is_fading = false


func _fade_out() -> void:
	fade_rect.visible = true
	fade_rect.modulate.a = 0.0
	var tween = get_tree().create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 0.5)
	await tween.finished


func _fade_in() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 0.5)
	await tween.finished
	fade_rect.visible = false

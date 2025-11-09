extends Node2D

@onready var all_backgrounds = get_children()

func _ready():
	# Saat mulai game, pastikan hanya background pertama yang aktif
	for i in range(all_backgrounds.size()):
		all_backgrounds[i].visible = (i == 0)
	set_background("Beach")
func set_background(name: String):
	for bg in all_backgrounds:
		bg.visible = (bg.name == name)

extends Control
@export var menu_scene:PackedScene

func _ready():
	MusicController.credits()

func _on_volver_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

extends MarginContainer

@export var lobby_scene:PackedScene


func _ready():
	MusicController.play_music()

func _on_start_pressed():
	get_tree().change_scene_to_packed(lobby_scene)
	

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/credits.tscn")


func _on_settings_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()


func _on_how_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/how.tscn")

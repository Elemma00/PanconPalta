extends MarginContainer

@export var lobby_scene:PackedScene

func _on_start_pressed():
	get_tree().change_scene_to_packed(lobby_scene)
	


func _on_credits_pressed():
	pass # Replace with function body.


func _on_settings_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()

extends Area2D

func _ready():
	pass
	
func _on_body_entered(area:Node2D) -> void:
	if area.is_in_group("player"):
		print("lolaso")
		

#@rpc("call_remote","reliable")
#func _fail():
#	var current_scene = get_tree().get_current_scene()
#	var new_scene = load(current_scene.filename).instance()
#	get_tree().root.add_child(new_scene)
#	get_tree().set_current_scene(new_scene)
#	current_scene.queue_free()

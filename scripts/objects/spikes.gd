extends Area2D


func _ready():
	pass

func _on_body_entered(body: Node2D) -> void:
	if !body.is_in_group("players"):
		return
	
	if !is_multiplayer_authority():
		return
	
	print("Murio")
	
	_restart_level.rpc()

@rpc("call_local","reliable")
func _restart_level() -> void:
	get_tree().reload_current_scene()

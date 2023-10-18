extends Area2D

var players_in: Array[Player] = []
@export var win_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if players_in.size() == 4:
		_win.rpc()


func _on_body_entered(body: Node2D) -> void:
	if !body.is_in_group("players"):
		return
	
	if !is_multiplayer_authority():
		return
	
	players_in.append(body)
	


func _on_body_exited(body: Node2D) -> void:
	if !body.is_in_group("players"):
		return
	
	if !is_multiplayer_authority():
		return
	
	players_in.erase(body)


@rpc("call_local","reliable")
func _win() -> void:
	print("Win")
	get_tree().change_scene_to_packed(win_scene)

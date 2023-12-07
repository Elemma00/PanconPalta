extends Area2D

var players_in: Array[Player] = []
var key
@export var win_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	key = get_parent().contador_llaves

func _process(delta: float) -> void:
	if players_in.size() == 4 and key == 1:
		_win.rpc()


func _on_body_entered(body: Node2D) -> void:
	if !body.is_in_group("players"):
		return
	
	if !is_multiplayer_authority():
		return
	
	players_in.append(body)
	
	print("player entered to goal", players_in.size())
	print("keys:  ", get_parent().contador_llaves, ";  total:   ", get_parent().keys_amount)
	if players_in.size() == Game.players.size() and get_parent().contador_llaves == get_parent().keys_amount:
		_win.rpc()


func _on_body_exited(body: Node2D) -> void:
	if !body.is_in_group("players"):
		return
	
	if !is_multiplayer_authority():
		return
	
	players_in.erase(body)


@rpc("call_local","reliable")
func _win() -> void:
	print("Win")
	# get_tree().change_scene_to_packed(win_scene)
	LevelManager.go_to_win()

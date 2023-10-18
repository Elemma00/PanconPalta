extends RigidBody2D


@export var picked = false: 
	set(value):
		picked = value
		freeze = picked

var playerC
@onready var caja_1 = $"."

func _input(event):
	if Input.is_action_just_pressed("skill") and picked == false:
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("playerC"):
				playerC = body
				if body.canPick == true:
					playerC.setremotepath.rpc(get_path())
					Debug.dprint("pick")
					request_pick.rpc_id(1,true)
					body.canPick = false

	elif Input.is_action_just_pressed("drop") and picked == true:
		request_pick.rpc_id(1,false)
		playerC.canPick = true
		playerC.setremotepath.rpc("")
		playerC.setremotepathdrop.rpc(get_path())
		playerC.setremotepathdrop.rpc("")

	
@rpc("reliable","any_peer","call_local")
func request_pick(value):
	picked = value

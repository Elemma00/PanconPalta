extends CharacterBody2D

var acceleration = 50
var gravity = 200


@export var picked = false: 
	set(value):
		picked = value

var playerC
@onready var caja_2 = $"."

@onready var collision_shape_2d = $CollisionShape2D

@export var collision_enabled = true:
	set(value):
		collision_enabled = value
		collision_shape_2d.disabled = not value

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
			
	if Input.is_action_just_pressed("skill") and picked == false:
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("playerC"):
				playerC = body
				if body.canPick == true:
					collision_enabled = false
					playerC.setremotepath.rpc(get_path())
					Debug.dprint("pick")
					request_pick.rpc_id(1,true)
					body.canPick = false
					
	elif Input.is_action_just_pressed("drop") and picked == true:
		request_pick.rpc_id(1,false)
		playerC.canPick = true
		collision_enabled = true
		playerC.setremotepath.rpc("")
		playerC.setremotepathdrop.rpc(get_path())
		playerC.setremotepathdrop.rpc("")
	move_and_slide()
	
@rpc("reliable","any_peer","call_local")
func request_pick(value):
	picked = value

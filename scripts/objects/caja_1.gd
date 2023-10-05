extends RigidBody2D


@export var picked = false: 
	set(value):
		picked = value
		freeze = picked

var playerC
@onready var caja_1 = $"."
@onready var collision_shape_2d = $CollisionShape2D

"
func _physics_process(delta):
	position_info()
"
func _input(event):
	if Input.is_action_just_pressed("skill") and picked == false:
		Debug.dprint("aaaa h")
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
		drop.rpc()


@rpc("reliable","call_local")
func position_info():
	if picked == true:
		var marker = playerC.get_node("Marker2D")
		self.position = marker.global_position
		collision_shape_2d.disabled = true
	else: 
		collision_shape_2d.disabled = false

@rpc("reliable","call_local")
func drop():
	var drop_zone = playerC.get_node("drop_zone")
'	self.position = drop_zone.global_position'
	
@rpc("reliable","any_peer","call_local")
func request_pick(value):
	picked = value

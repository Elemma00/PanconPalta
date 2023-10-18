extends Player

@onready var marker_2d = $Marker2D
@onready var drop_zone = $DropZone
@onready var direccion = $Direccion
@onready var pick_area = $Direccion/Pick_area

@export var isHolding = false:
	set(value):
		isHolding = value

var caja_cargada: Caja

@rpc("call_local","reliable")
func sign_drop(value):
	drop_zone.position.x = value * 15
	if(value == 1):
		direccion.position.x = 15
	else:
		direccion.position.x = 5

@rpc("call_local","reliable","any_peer")
func setremotepath(value):
	marker_2d.remote_path = value

@rpc("call_local","reliable","any_peer")
func setremotepathdrop(value):
	drop_zone.remote_path = value

func _process(delta: float) -> void:
	if is_multiplayer_authority():
		if Input.is_action_just_pressed("skill") and isHolding == false:
			var bodies = pick_area.get_overlapping_bodies()
			for body in bodies:
				if body is Caja:
					caja_cargada = body
					setremotepath.rpc(body.get_path())
					body.collision_enabled = false
					body.request_collision.rpc(1,false)
					isHolding = true
					
		elif Input.is_action_just_pressed("drop") and isHolding == true:
					Debug.dprint("drop")
					caja_cargada.position = drop_zone.position
					caja_cargada.collision_enabled = true
					caja_cargada.request_collision.rpc(1,true)
					setremotepath.rpc("")
					setremotepathdrop.rpc(caja_cargada.get_path())
					setremotepathdrop.rpc("")
					isHolding = false
				

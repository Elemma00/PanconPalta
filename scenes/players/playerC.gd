extends Player

@onready var drop_zone = $DropZone
@onready var marker_2d = $Marker2D

@rpc("call_local","reliable","any_peer")
func sign_drop():
	Debug.dprint("sign drop")
	var lastposition = drop_zone.position.x 
	drop_zone.scale.x * lastDir
	

@rpc("call_local","reliable","any_peer")
func setremotepath(value):
	marker_2d.remote_path = value

@rpc("call_local","reliable","any_peer")
func setremotepathdrop(value):
	drop_zone.remote_path = value

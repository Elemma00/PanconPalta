extends Player

@onready var marker_2d = $Marker2D
@onready var drop_zone = $DropZone

@rpc("call_local","reliable")
func sign_drop(value):
	drop_zone.position.x = value * 15
	Debug.dprint(value)

@rpc("call_local","reliable","any_peer")
func setremotepath(value):
	marker_2d.remote_path = value

@rpc("call_local","reliable","any_peer")
func setremotepathdrop(value):
	drop_zone.remote_path = value

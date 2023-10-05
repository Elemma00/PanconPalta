extends Player
@onready var drop_zone = $drop_zone
@onready var marker_2d = $Marker2D

@rpc("call_remote")
func sign_drop():
	Debug.dprint("sign drop")
	var lastposition = drop_zone.position.x 
	drop_zone.position.x = lastposition * lastDir

@rpc("call_local","reliable","any_peer")
func setremotepath(value):
	marker_2d.remote_path = value

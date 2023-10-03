extends Player
@onready var drop_zone = $drop_zone

@rpc("call_remote")
func sign_drop():
	Debug.dprint("sign drop")
	var lastposition = drop_zone.position.x 
	drop_zone.position.x = lastposition * lastDir


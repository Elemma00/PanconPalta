extends Player
@onready var drop_zone = $drop_zone

@rpc("reliable")
func sign_drop():
	drop_zone.position.x =  drop_zone.position.x * lastDir



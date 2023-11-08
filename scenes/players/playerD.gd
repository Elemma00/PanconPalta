extends Player

@onready var aim: Node2D = $Aim
@onready var cuerda: Line2D = $Cuerda


func _process(delta: float) -> void:
	if is_multiplayer_authority():
		aim.global_position = get_global_mouse_position()

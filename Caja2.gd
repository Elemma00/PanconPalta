extends CharacterBody2D

var acceleration = 3000
var gravity = 900

@export var picked = false: 
	set(value):
		picked = value


func _physics_process(delta: float) -> void:
		if not is_on_floor():
			velocity.y += gravity * delta
		

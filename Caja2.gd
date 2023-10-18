class_name Caja
extends CharacterBody2D

var acceleration = 50
var gravity = 200
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
	move_and_slide()
	
	
@rpc("reliable","any_peer","call_local")
func request_collision(value):
	collision_enabled = value
	

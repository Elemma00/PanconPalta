extends RigidBody2D

var picked = false
var playerC
@onready var caja_1 = $"."
@onready var collision_shape_2d = $CollisionShape2D


func _physics_process(delta):
	
	if picked == true:
		collision_shape_2d.disabled = true
		var marker = playerC.get_node("Marker2D")
		self.position = marker.global_position
	else: 
		collision_shape_2d.disabled = false

func _input(event):
	if Input.is_action_just_pressed("skill") and picked == false:
		var bodies = $Area2D.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("playerC"):
				playerC = body
				if body.canPick == true:
					picked = true
					body.canPick = false
					
				
	elif Input.is_action_just_pressed("drop") and picked == true:
		picked = false
		playerC.canPick = true
		var drop_zone = playerC.get_node("drop_zone")
		self.position = drop_zone.global_position
			
	if Input.is_action_just_pressed("throw") and picked == true:
		picked = false
		playerC.canPick = true
		if playerC.sprite_2d.flip_h == false:
			apply_impulse(Vector2(),Vector2(150,-200))
		else:
			apply_impulse(Vector2(),Vector2(-150,-200))
			


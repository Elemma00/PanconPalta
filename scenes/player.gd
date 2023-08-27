class_name Player
extends CharacterBody2D

var max_speed = 100
var jump_speed = 500
var acceleration = 3000
var gravity = 1000

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	animation_tree.active = true


func _physics_process(delta: float) -> void:
	if is_multiplayer_authority():
		var move_input = Input.get_axis("move_left", "move_right")
		if not is_on_floor():
			velocity.y += gravity * delta
		
		if Input.is_action_just_pressed("jump"):
			velocity.y = -jump_speed
	
		velocity.x = move_toward(velocity.x, max_speed * move_input, acceleration * delta)
		move_and_slide()
		send_info.rpc(global_position)
		
		# Animation
		if velocity.x != 0:
			sprite_2d.scale.x = sign(velocity.x)
		
		if is_on_floor():
			if abs(velocity.x) > 10 or move_input:
				playback.travel("walk")
			else:
				playback.travel("idle")
		
#	else:
#		pass


func _input(event: InputEvent) -> void:
	if is_multiplayer_authority():
		if event.is_action_pressed("test"):
			test.rpc_id(1)


@rpc("unreliable_ordered")
func send_info(pos: Vector2) -> void:
	global_position = pos

func setup(player_data: Game.PlayerData):
	set_multiplayer_authority(player_data.id)
	name = str(player_data.id)
	Debug.dprint(player_data.name, 30)
	Debug.dprint(player_data.role, 30)



@rpc
func test():
#	if is_multiplayer_authority():
	Debug.dprint("test - player: %s" % name, 30)

class_name Player
extends CharacterBody2D

var max_speed = 100
var jump_speed = 300
var acceleration = 3000
var gravity = 1000

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	animation_tree.active = true


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_multiplayer_authority():
		var move_input = Input.get_axis("move_left", "move_right")
		
		if Input.is_action_just_pressed("jump"):
			jump.rpc()
	
		velocity.x = move_toward(velocity.x, max_speed * move_input, acceleration * delta)
		send_info.rpc(global_position,velocity)
		
		# Animation
		if velocity.x != 0:
			sign_sprite.rpc()
		
		if is_on_floor():
			if abs(velocity.x) > 10 or move_input:
				playback.travel("walk")
			else:
				playback.travel("idle")
		
		
	#movemos el move and slide afuera para poder simular los movimientos
	#tanto en el servidor como en un cliente
	move_and_slide()


func _input(event: InputEvent) -> void:
	if is_multiplayer_authority():
		if event.is_action_pressed("test"):
			test.rpc_id(1)


@rpc("unreliable_ordered")
func send_info(pos: Vector2, vel:Vector2) -> void:
	#interpolamos la posicion y la velocidad  del personaje 
	global_position = lerp(global_position, pos, 0.5)
	velocity = lerp(velocity,vel,0.5)


#funcion para enviar info de hacia donde mira el player
@rpc("call_local","reliable")
func sign_sprite():
	sprite_2d.scale.x = sign(velocity.x)

@rpc("call_local","reliable")
func jump():
	velocity.y = -jump_speed

func setup(player_data: Game.PlayerData):
	set_multiplayer_authority(player_data.id)
	name = str(player_data.id)
	Debug.dprint(player_data.name, 30)
	Debug.dprint(player_data.role, 30)



@rpc
func test():
#	if is_multiplayer_authority():
	Debug.dprint("test - player: %s" % name, 30)

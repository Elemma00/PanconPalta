class_name Player
extends CharacterBody2D

var max_speed = 80
var jump_speed = 250
var acceleration = 3000
var gravity = 900
@export var max_jump = 1
var jumps = 0

var lastDir = 1
var dropDir = 1
var isDashing = false
var canDash = false
var canPick = false

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	animation_tree.active = true


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_multiplayer_authority():
		var dash_input= Input.is_action_just_pressed("Dash")
		var move_input = Input.get_axis("move_left", "move_right")
				
		if Input.is_action_just_pressed("move_left"):
			if canDash:
				lastDir=-1
			dropDir=-1
			sign_drop.rpc(dropDir)
		if Input.is_action_just_pressed("move_right"):
			if canDash:
				lastDir=1
			dropDir=1
			sign_drop.rpc(dropDir)
			
		if dash_input:
			dash.rpc()
			
		if isDashing and $Timer.time_left > 0.1:
				velocity.y = 0
				velocity.x = lastDir* 500
				
		if is_on_floor():
			if jumps != 0:
				jumps = 0
			if abs(velocity.x) > 10 or move_input:
				walk_animation.rpc()

			else:
				idle_animation.rpc()
				
		if Input.is_action_just_pressed("jump") and jumps < max_jump:
			jumps += 1
			jump.rpc()
	
		velocity.x = move_toward(velocity.x, max_speed * move_input, acceleration * delta)
		send_info.rpc(global_position,velocity)
		
		# Animation
		if velocity.x != 0:
			sign_sprite.rpc()
			
			
		
		if Input.is_action_just_pressed("skill"):
			skill.rpc()
			
	#movemos el move and slide afuera para poder simular los movimientos
	#tanto en el servidor como en un cliente
	move_and_slide()


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
	
@rpc("call_local","reliable")
func walk_animation():
	playback.travel("walk")
	
@rpc("call_local","reliable")
func idle_animation():
	playback.travel("idle")

@rpc("call_local","reliable")
func dash():
	if canDash:
		$Timer.start()
		canDash = false
		isDashing = true
		
func setup(player_data: Game.PlayerData):
	set_multiplayer_authority(player_data.id)
	name = str(player_data.id)
	Debug.dprint(player_data.name, 30)
	Debug.dprint(player_data.role, 30)
	if(player_data.role== Game.Role.ROLE_B):
		canDash=true
	if(player_data.role == Game.Role.ROLE_C):
		canPick=true

@rpc
func test():
#	if is_multiplayer_authority():
	Debug.dprint("test - player: %s" % name, 30)
	
@rpc("reliable","call_local")
func skill():
	pass

@rpc("call_local","reliable")
func sign_drop(value):
	pass
	

func _on_timer_timeout():
	canDash=true

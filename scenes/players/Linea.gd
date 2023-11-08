extends Line2D

@onready var aim: Node2D = $"../Aim"
@onready var horizontal: Line2D = $"../Aim/Horizontal"
@onready var vertical: Line2D = $"../Aim/Vertical"

@onready var player: CharacterBody2D = $".."
@onready var timer: Timer = $"../Timer"

@onready var rope_sound = $"../rope"


var destination: Vector2
var isRopeCreated: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.add_point(Vector2(0,0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_multiplayer_authority():
		return
	
	if Input.is_action_just_pressed("skill"):
		if self.isRopeCreated:
			remove_rope.rpc()
		else:
			create_rope.rpc(aim.global_position)
	
	_update_rope.rpc()
	
	queue_redraw()

@rpc("call_local","reliable")
func _update_rope():
	if !self.isRopeCreated:
		return
		
	self.remove_point(1)
	self.add_point(to_local(self.destination))

@rpc("call_local","reliable")
func create_rope(destination: Vector2):
	var space_state = get_world_2d().direct_space_state
	# use global coordinates, not local to node
	var query = PhysicsRayQueryParameters2D.create(self.global_position, destination)
	query.exclude = [self, player, aim]
	var result = space_state.intersect_ray(query)
	
	if result.is_empty():
		horizontal.default_color = Color(1, 0, 0)
		vertical.default_color = Color(1, 0, 0)
		aim.rotate(-0.785)
		timer.start()
		return
	
	destination = result.position
	self.destination = destination
	self.add_point(to_local(self.destination))
	self.isRopeCreated = true
	rope_sound.play()


@rpc("call_local","reliable")
func remove_rope():
	self.remove_point(1)
	self.isRopeCreated = false


func _on_area_body_entered(body: Node2D) -> void:
	if body == player:
		return
	
	if !body.is_in_group("players"):
		return
	
	if !self.isRopeCreated:
		return
	
	body.global_position = destination


func _on_timer_timeout() -> void:
	horizontal.default_color = Color(1, 1, 1)
	vertical.default_color = Color(1, 1, 1)
	aim.rotate(0.785)


extends Area2D

@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var asprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var icon: Sprite2D = $Sprite2D

func _on_body_entered(body: Node2D) -> void:
	if !body.is_in_group("players"):
		return
	
	if !is_multiplayer_authority():
		return
	
	print("A player pick the key")
	
	# Llamar a la función en el nodo global
	get_parent().incrementar_contador()
	# Destruir la llave
	destroy_key.rpc()


@rpc("call_local", "reliable")
func destroy_key():
	collision.set_disabled(true)
	icon.hide()

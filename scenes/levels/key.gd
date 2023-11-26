extends Area2D

func _on_Area2D_body_entered(body):
	if body.is_in_group("jugador"):
		# Llamar a la función en el nodo global
		get_parent().incrementar_contador()
		# Destruir la llave
		queue_free()

extends Camera2D

var personaje: CharacterBody2D  # Ajusta el tipo de nodo según tu estructura de nodos

func _ready():
	personaje =   # Ajusta esto para reflejar la ruta correcta al nodo del personaje

func _process(delta):
	# Asegurémonos de que el nodo del personaje exista
	if personaje:
		# Centra suavemente la cámara en la posición del personaje
		position = personaje.global_position

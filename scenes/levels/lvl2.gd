extends Node2D

@export var contador_llaves = 0
signal llave_recogida
# Función para incrementar el contador
func incrementar_contador():
	contador_llaves += 1
	

# Singleton: instancia única del nodo
func _ready():
	# Asegúrate de que solo haya una instancia del Singleton
	if self != get_tree().get_root():
		queue_free()
		

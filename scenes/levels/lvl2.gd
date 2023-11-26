extends Node2D

var contador_llaves = 0

# Función para incrementar el contador
func incrementar_contador():
	contador_llaves += 1
	print("Llaves recogidas: ", contador_llaves)

# Singleton: instancia única del nodo
func _ready():
	# Asegúrate de que solo haya una instancia del Singleton
	if self != get_tree().get_root():
		queue_free()

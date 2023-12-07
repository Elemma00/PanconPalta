extends Node2D

@export var playerA: PackedScene
@export var playerB: PackedScene
@export var playerC: PackedScene
@export var playerD: PackedScene
@onready var players: Node2D = $Players
@onready var spawn: Node2D = $Spawn
@onready var camera_2d: Camera2D = $Camera2D


@export var contador_llaves = 0
signal llave_recogida

# Función para incrementar el contador
func incrementar_contador():
	contador_llaves += 1

# Singleton: instancia única del nodo
func _ready():
	MusicController.level1()
	Game.sort_players()
	for i in Game.players.size():
		var player_data = Game.players[i]
		
		# Acá vemos que Rol le toca a cada jugador
		if(player_data.role == Game.Role.ROLE_A):
			var player = playerA.instantiate()
			players.add_child(player)
			player.update_camera(self.camera_2d)
			player.setup(player_data)
			player.global_position = spawn.get_child(i).global_position
			
		elif(player_data.role == Game.Role.ROLE_B):
			var player = playerB.instantiate()
			players.add_child(player)
			player.update_camera(self.camera_2d)
			player.setup(player_data)
			player.global_position = spawn.get_child(i).global_position
			
		elif(player_data.role == Game.Role.ROLE_C):
			var player = playerC.instantiate()
			players.add_child(player)
			player.update_camera(self.camera_2d)
			player.setup(player_data)
			player.global_position = spawn.get_child(i).global_position
		
		elif(player_data.role == Game.Role.ROLE_D):
			var player = playerD.instantiate()
			players.add_child(player)
			player.update_camera(self.camera_2d)
			player.setup(player_data)
			player.global_position = spawn.get_child(i).global_position




extends Control
signal start_all_animations

@onready var a = $MarginContainer/Label/movimiento/A
@onready var w = $MarginContainer/Label/movimiento/W
@onready var s = $MarginContainer/Label/movimiento/S
@onready var d = $MarginContainer/Label/movimiento/D
@onready var jump = $MarginContainer/Label/saltar/jump
@onready var habilidad = $MarginContainer/Label/habilidad/habilidad
@onready var j = $MarginContainer/Label/habilidad/J
@onready var dinored = $MarginContainer/Label/doble_salto/dinored
@onready var bluedino = $MarginContainer/Label/dash/bluedino
@onready var shift = $MarginContainer/Label/dash/shift
@onready var greendino = $MarginContainer/Label/cuerda/greendino
@onready var yellowdino = $MarginContainer/Label/fuerza/yellowdino


func _ready():
	MusicController.play_how()
	a.play("default")
	w.play("default")
	s.play("default")
	d.play("default")
	jump.play("default")
	habilidad.play("default")
	j.play("default")
	dinored.play("default")
	bluedino.play("default")
	shift.play("default")
	greendino.play("default")
	yellowdino.play("default")


func _on_volver_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")

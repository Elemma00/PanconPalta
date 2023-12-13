extends Node


@onready var canvas_layer  = CanvasLayer.new()
@onready var container = VBoxContainer.new()

func _ready() -> void:
	add_child(canvas_layer)
	canvas_layer.layer = 100
	canvas_layer.add_child(container)


func dprint(message: Variant, seconds: int = 2) -> void:
	return

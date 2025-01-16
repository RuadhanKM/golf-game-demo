@tool
extends Sprite2D

class_name mapinfo

@export var p1_spawn: Vector2
@export var p2_spawn: Vector2

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	GameManager.map_info = self

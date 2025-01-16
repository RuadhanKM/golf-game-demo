extends Area2D

class_name golfhole

signal goal
var scored = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered", area_entered)
	
	GameManager.golf_hole = self
	
func area_entered(area: Area2D) -> void:
	if scored:
		return
	scored = true

	$GPUParticles2D.emitting = true
	
	emit_signal("goal", area.get_parent().PLAYER_TYPE)

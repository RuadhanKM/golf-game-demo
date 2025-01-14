extends Sprite2D

signal golf_swing
const ORBIT_DIS = 50

var cur_orbit = 0
var parent_rot = 0
var orbiting = false
var p1 = true

func _input(event: InputEvent) -> void:	
	if (event.is_action_pressed("P1_Swing") and p1) or (event.is_action_pressed("P2_Swing") and not p1):
		orbiting = true
		cur_orbit = -PI/2
		visible = orbiting
	if (event.is_action_released("P1_Swing") and p1) or (event.is_action_released("P2_Swing") and not p1):
		orbiting = false
		visible = orbiting
		emit_signal("golf_swing", cur_orbit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !orbiting:
		return
	
	cur_orbit += (-delta if p1 else delta) * PI
	var vis_orbit = cur_orbit - parent_rot
	
	transform = Transform2D(vis_orbit, Vector2(0.12, 0.12), 0, -Vector2(cos(vis_orbit), sin(vis_orbit))*ORBIT_DIS)
	

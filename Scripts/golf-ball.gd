@tool
extends RigidBody2D

class_name golfball

enum PLAYER_TYPES {
	PLAYER1,
	PLAYER2
}

@export var PLAYER_TYPE : PLAYER_TYPES = PLAYER_TYPES.PLAYER1

@onready var ARROW = $Arrow
@onready var BALL_SHADOW = $"Golf-ball/Sprite2D"

const SWING_FORCE = 10

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	ARROW.connect("golf_swing", on_golf_swing)
	ARROW.set_player(PLAYER_TYPE == PLAYER_TYPES.PLAYER1)
	
	if PLAYER_TYPE == PLAYER_TYPES.PLAYER1:
		GameManager.p1 = self
	if PLAYER_TYPE == PLAYER_TYPES.PLAYER2:
		GameManager.p2 = self

func on_golf_swing(angle: float, force: float):
	apply_central_impulse(-Vector2(cos(angle), sin(angle)) * SWING_FORCE * force)

func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	ARROW.parent_rot = rotation
	BALL_SHADOW.rotation = -rotation

@tool
extends RigidBody2D

class_name golfball

@export var PLAYER_TYPE : GameManager.PLAYER_TYPES = GameManager.PLAYER_TYPES.PLAYER1

@onready var ARROW = $Arrow
@onready var BALL_SHADOW = $"Golf-ball/Sprite2D"

var s_swing_force = 10
var s_bounce = 0.2
var s_mass = 0.043
var s_scale = 1
var s_ability_cooldown = 5

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	ARROW.connect("golf_swing", on_golf_swing)
	ARROW.set_player(PLAYER_TYPE == GameManager.PLAYER_TYPES.PLAYER1)
	
	if PLAYER_TYPE == GameManager.PLAYER_TYPES.PLAYER1:
		GameManager.p1 = self
	if PLAYER_TYPE == GameManager.PLAYER_TYPES.PLAYER2:
		GameManager.p2 = self

func on_golf_swing(angle: float, force: float):
	apply_central_impulse(-Vector2(cos(angle), sin(angle)) * s_swing_force * force)

func _physics_process(delta: float) -> void:	
	if Engine.is_editor_hint():
		return
	
	physics_material_override.bounce = s_bounce
	
	$CollisionShape2D.scale = Vector2.ONE*1.3*s_scale
	$"Golf-ball".scale = Vector2.ONE*0.1*s_scale
	$Area2D.scale = Vector2.ONE*1.3*s_scale
	
	mass = s_mass
	
	ARROW.parent_rot = rotation
	BALL_SHADOW.rotation = -rotation

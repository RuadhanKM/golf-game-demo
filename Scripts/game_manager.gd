extends Node

enum GAME_STATES {
	GAMEPLAY,
	WIN_ANIMATION,
	PICKING_CARD
}

enum PLAYER_TYPES {
	PLAYER1,
	PLAYER2
}

var game_state: GAME_STATES = GAME_STATES.GAMEPLAY

var p1: golfball
var p2: golfball
var golf_hole: golfhole
var map_info: mapinfo
var ui_control: ui

func _ready() -> void:
	randomize()
	get_node("/root/").connect("ready", on_ready)

func on_ready() -> void:
	assert(p1 != null)
	assert(p2 != null)
	assert(golf_hole != null)
	assert(map_info != null)
	assert(ui_control != null)
	
	golf_hole.connect("goal", on_goal)
	ui_control.connect("card_picked", on_card_picked)
	spawn_players()
	
func spawn_players():
	p1.position = map_info.p1_spawn
	p2.position = map_info.p2_spawn
	
	p1.linear_velocity = Vector2.ZERO
	p1.angular_velocity = 0
	p2.linear_velocity = Vector2.ZERO
	p2.angular_velocity = 0

func on_goal(player: PLAYER_TYPES):
	game_state = GAME_STATES.WIN_ANIMATION
	Engine.time_scale = 0.3
	
	await get_tree().create_timer(1.0).timeout
	
	Engine.time_scale = 1
	spawn_players()
	golf_hole.scored = false
	golf_hole.get_node("GPUParticles2D").restart()
	golf_hole.get_node("GPUParticles2D").emitting = false
	game_state = GAME_STATES.PICKING_CARD
	ui_control.emit_signal(
		"begin_card_pick", 
		PLAYER_TYPES.PLAYER1 if player == PLAYER_TYPES.PLAYER2 else PLAYER_TYPES.PLAYER2
	)

func on_card_picked(card):
	game_state = GAME_STATES.GAMEPLAY

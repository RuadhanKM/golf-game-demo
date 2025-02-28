extends Node

var card_name = "Big Arm"

func _ready():
	CaddyManager.impls[card_name] = self

func on_pick(player: golfball):
	player.s_swing_force += player.s_swing_force*0.2

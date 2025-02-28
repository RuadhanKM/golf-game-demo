extends Node

var card_name = "Bouncy Ball"

func _ready():
	CaddyManager.impls[card_name] = self

func on_pick(player: golfball):
	player.s_bounce += 0.3

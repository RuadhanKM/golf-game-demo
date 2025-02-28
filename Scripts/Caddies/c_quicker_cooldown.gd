extends Node

var card_name = "Quicker Cooldown"

func _ready():
	CaddyManager.impls[card_name] = self

func on_pick(player: golfball):
	player.s_mass += player.s_mass*0.1

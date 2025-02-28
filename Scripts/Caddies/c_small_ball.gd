extends Node

var card_name = "Small Ball"

func _ready():
	CaddyManager.impls[card_name] = self

func on_pick(player: golfball):
	player.s_scale -= player.s_scale*0.2
	player.s_mass -= player.s_mass*0.2

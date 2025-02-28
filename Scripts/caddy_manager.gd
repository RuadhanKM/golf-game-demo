extends Node

var p1_caddies = []
var p2_caddies = []

var impls = {}

func on_card_pick(card, player):
	if player == GameManager.PLAYER_TYPES.PLAYER1:
		p1_caddies.push_back(card)
		impls[card.name].on_pick(GameManager.get_plr(player))
	else:
		p2_caddies.push_back(card)
		impls[card.name].on_pick(GameManager.get_plr(player))
	

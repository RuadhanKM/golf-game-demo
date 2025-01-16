extends Node

enum RARITIES {
	COMMON,
	RARE,
	EPIC,
	LEGENDARY,
	
	EXOTIC,
	SECRET,
}

var rarity_prob = {
	RARITIES.COMMON: {"prob": 800, "bbcode": "Common"},
	RARITIES.RARE: {"prob": 800, "bbcode": "Common"},
	RARITIES.EPIC: {"prob": 800, "bbcode": "Common"},
	RARITIES.LEGENDARY: {"prob": 800, "bbcode": "Common"},
	
	RARITIES.EXOTIC: {"prob": 800, "bbcode": "Common"},
	RARITIES.SECRET: {"prob": 800, "bbcode": "Common"}
}	

func get_rarity(rarity: int):
	for i in rarity_prob:
		if rarity < rarity_prob[i]:
			return i
		rarity -= rarity_prob[i]
	assert(false)

var rarity_total = 0

var rich_text_formats = {
	"bgn": "[color=green]",
	"egn": "[/color]",
	"bs": "[color=Darkorange]",
	"es": "[/color]",
	"oa": "[color=Lightskyblue]On Ability[/color]",
	"os": "[color=Lightskyblue]On Swing[/color]"
}

var items = {
	RARITIES.COMMON: [
		{
			"name": "Big Arm",
			"desc": "{bgn}+15%{egn} {bs}Swing Power{es}".format(rich_text_formats),
		},
		{
			"name": "Bouncy Ball",
			"desc": "{bgn}+10%{egn} {bs}Bouncyness{es}".format(rich_text_formats),
		},
		{
			"name": "Heavy Ball",
			"desc": "{bgn}+10%{egn} {bs}Mass{es}".format(rich_text_formats),
		},
	],
	RARITIES.RARE: [
		{
			"name": "Small Ball",
			"desc": "{bgn}-15%{egn} {bs}Ball Size{es}\n{bgn}-15%{egn} {bs}Ball Mass{es}".format(rich_text_formats),
			"rarity": RARITIES.RARE
		},
		{
			"name": "Dash",
			"desc": "{oa}, dash forward".format(rich_text_formats),
			"rarity": RARITIES.RARE
		},
		{
			"name": "Double Jump",
			"desc": "{oa}, jump upwards".format(rich_text_formats),
			"rarity": RARITIES.RARE
		},
	],
	RARITIES.EPIC: [
		{
			"name": "Repulsion",
			"desc": "{bgn}-10%{egn} Enemy attraction".format(rich_text_formats),
		},
		{
			"name": "Attraction",
			"desc": "{bgn}+10%{egn} Enemy attraction".format(rich_text_formats),
		},
		{
			"name": "Sticky Ball",
			"desc": "Ball {bs}sticks{es} to walls".format(rich_text_formats),
			"rarity": RARITIES.EPIC
		},
	],
	RARITIES.LEGENDARY: [],
	RARITIES.EXOTIC: [],
	RARITIES.SECRET: [],
}

func _ready() -> void:
	for i in rarity_prob:
		rarity_total += rarity_prob[i]

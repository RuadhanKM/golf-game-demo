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
	RARITIES.COMMON: {"prob": 6000, "bbcode": "Common"},
	RARITIES.RARE: {"prob": 4000, "bbcode": "Rare"},
	RARITIES.EPIC: {"prob": 1000, "bbcode": "Epic"},
	RARITIES.LEGENDARY: {"prob": 300, "bbcode": "Legendary"},
	
	RARITIES.EXOTIC: {"prob": 25, "bbcode": "Exotic"},
	RARITIES.SECRET: {"prob": 1, "bbcode": "Secret"}
}	

func get_rarity(rarity: int):
	for i in rarity_prob:
		if rarity <= rarity_prob[i].prob:
			return i
		rarity -= rarity_prob[i].prob
	assert(false)

var rarity_total = 0

var rich_text_formats = {
	"bgn": "[color=green]",
	"egn": "[/color]",
	"bbn": "[color=red]",
	"ebn": "[/color]",
	"bs": "[color=Darkorange]",
	"es": "[/color]",
	"oa": "[color=Lightskyblue]On Ability[/color]",
	"os": "[color=Lightskyblue]On Swing[/color]"
}

var items = {
	RARITIES.COMMON: [
		{
			"name": "Big Arm",
			"desc": "{bgn}+20%{egn} {bs}Swing Power{es}".format(rich_text_formats),
		},
		{
			"name": "Bouncy Ball",
			"desc": "{bgn}+0.3{egn} {bs}Bouncyness{es}".format(rich_text_formats),
		},
		{
			"name": "Quicker Cooldown",
			"desc": "{bgn}-10%{egn} {bs}Ability Cooldown Time{es}\n{bbn}+30%{ebn} {bs}Mass{es}".format(rich_text_formats),
		},
	],
	RARITIES.RARE: [
		{
			"name": "Small Ball",
			"desc": "{bgn}-20%{egn} {bs}Ball Size{es}\n{bgn}-20%{egn} {bs}Ball Mass{es}".format(rich_text_formats),
		},
		{
			"name": "Dash",
			"desc": "{oa}, dash forward".format(rich_text_formats),
		},
		{
			"name": "Double Jump",
			"desc": "{oa}, jump upwards".format(rich_text_formats),
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
		},
	],
	RARITIES.LEGENDARY: [
		{
			"name": "Sniper",
			"desc": "{oa}, snipe the enemy and send them flying!\n{bbn}+15%{ebn} {bs}Ability Cooldown{es}".format(rich_text_formats)
		},
		{
			"name": "Bouncy Blocker",
			"desc": "{oa}, build a bouncer next to the enemy and bounce them away!\n{bbn}+15%{ebn} {bs}Ability Cooldown{es}".format(rich_text_formats)
		},
		{
			"name": "Snake Launcher",
			"desc": "{os}, launch a flying snake to discombobulate the enemy!".format(rich_text_formats)
		},
	],
	RARITIES.EXOTIC: [],
	RARITIES.SECRET: [],
}

func _ready() -> void:
	for i in rarity_prob:
		rarity_total += rarity_prob[i].prob

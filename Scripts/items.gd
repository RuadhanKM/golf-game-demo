extends Node

enum RARITIES {
	COMMON,
	RARE,
	EPIC,
	LEGENDARY,
}

var rich_text_formats = {
	"bgn": "[color=green]",
	"egn": "[/color]",
	"bs": "[color=Darkorange]",
	"es": "[/color]",
	"oa": "[color=Lightskyblue]On Ability[/color]",
	"os": "[color=Lightskyblue]On Swing[/color]"
}

var items = [
	{
		"name": "Big Arm",
		"desc": "{bgn}+15%{egn} {bs}Swing Power{es}".format(rich_text_formats),
		"rarity": RARITIES.COMMON
	},
	{
		"name": "Bouncy Ball",
		"desc": "{bgn}+10%{egn} {bs}Bouncyness{es}".format(rich_text_formats),
		"rarity": RARITIES.COMMON
	},
	{
		"name": "Small Ball",
		"desc": "{bgn}-15%{egn} {bs}Ball Size{es}\n{bgn}-15%{egn} {bs}Ball Mass{es}".format(rich_text_formats),
		"rarity": RARITIES.RARE
	},
	{
		"name": "Sticky Ball",
		"desc": "Ball {bs}sticks{es} to walls".format(rich_text_formats),
		"rarity": RARITIES.EPIC
	},
	{
		"name": "Dash",
		"desc": "{oa}, dash forward",
		"rarity": RARITIES.RARE
	},
	{
		"name": "Repulsion",
		"desc": "{bgn}-10%{egn} Enemy attraction",
		"rarity": RARITIES.EPIC
	},
		{
		"name": "Attraction",
		"desc": "{bgn}+10%{egn} Enemy attraction",
		"rarity": RARITIES.EPIC
	},
]

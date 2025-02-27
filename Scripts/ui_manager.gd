extends Panel

class_name ui

signal card_picked
signal begin_card_pick

var max_cards = 3
var selected_card = 1
var avaliable_cards = [null, null, null]
var player_choosing: GameManager.PLAYER_TYPES = GameManager.PLAYER_TYPES.PLAYER1

func test_rarity_pulls():
	var rarities = {}
	
	for i in Items.rarity_prob:
		rarities[i] = 0
	
	for i in range(5000):
		rarities[Items.get_rarity(randi_range(0, Items.rarity_total))] += 1
	
	for i in rarities:
		print("%s: %d" % [Items.rarity_prob[i].bbcode, rarities[i]])

func _ready() -> void:
	GameManager.ui_control = self

	test_rarity_pulls()
	
	visible = false
	connect("begin_card_pick", on_begin_card_pick)
	
func _input(event: InputEvent) -> void:
	if GameManager.game_state != GameManager.GAME_STATES.PICKING_CARD:
		if event is InputEventKey and event.pressed:
			if event.keycode == KEY_BRACKETLEFT:
				GameManager.p1.global_position = GameManager.golf_hole.global_position
			if event.keycode == KEY_BRACKETRIGHT:
				GameManager.p2.global_position = GameManager.golf_hole.global_position
		return
	
	var p_string = "P1" if player_choosing == GameManager.PLAYER_TYPES.PLAYER1 else "P2"
	
	if event.is_action_released(p_string + "_Right"):
		get_child(selected_card).scale = Vector2(1, 1)
		selected_card = posmod((selected_card + 1), max_cards)
		get_child(selected_card).scale = Vector2(1.2, 1.2)
	if event.is_action_released(p_string + "_Left"):
		get_child(selected_card).scale = Vector2(1, 1)
		selected_card = posmod((selected_card - 1), max_cards)
		get_child(selected_card).scale = Vector2(1.2, 1.2)
	if event.is_action_released(p_string + "_Swing"):
		visible = false
		get_child(selected_card).scale = Vector2(1, 1)
		emit_signal("card_picked", avaliable_cards[selected_card], player_choosing)
		avaliable_cards = [null, null, null]

func on_begin_card_pick(player: GameManager.PLAYER_TYPES):
	player_choosing = player
	visible = true
	selected_card = 1
	get_child(selected_card).scale = Vector2(1.2, 1.2)
	
	var selected_rarities = {}
	
	for i in range(max_cards):
		var rarity = Items.get_rarity(randi_range(0, Items.rarity_total))
		var card
		
		if selected_rarities.has(rarity):
			var cardi = randi_range(0, selected_rarities[rarity].size()-1)
			card = Items.items[rarity][selected_rarities[rarity].pop_at(cardi)]
		else:
			selected_rarities[rarity] = range(Items.items[rarity].size())
			var cardi = randi_range(0, selected_rarities[rarity].size()-1)
			card = Items.items[rarity][selected_rarities[rarity].pop_at(cardi)]
		
		var cardUI: RichTextLabel = get_child(i).get_child(0)
		avaliable_cards[i] = card
		
		cardUI.text = "{name}\n{desc}\n{rarity}".format({
			"rarity": Items.rarity_prob[rarity].bbcode,
			"name": card.name,
			"desc": card.desc
		})

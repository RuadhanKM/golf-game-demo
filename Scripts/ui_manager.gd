extends Panel

class_name ui

signal card_picked
signal begin_card_pick

var max_cards = 3
var selected_card = 1
var player_choosing: GameManager.PLAYER_TYPES = GameManager.PLAYER_TYPES.PLAYER1

func _ready() -> void:
	GameManager.ui_control = self
	
	visible = false
	connect("begin_card_pick", on_begin_card_pick)

func _input(event: InputEvent) -> void:
	if GameManager.game_state != GameManager.GAME_STATES.PICKING_CARD:
		return
	
	var p_string = "P1" if player_choosing == GameManager.PLAYER_TYPES.PLAYER1 else "P2"
	
	if event.is_action_released(p_string + "_Right"):
		selected_card = posmod((selected_card + 1), max_cards)
	if event.is_action_released(p_string + "_Left"):
		selected_card = posmod((selected_card - 1), max_cards)
	if event.is_action_released(p_string + "_Swing"):
		visible = false
		emit_signal("card_picked", selected_card)
		
	

func on_begin_card_pick(player: GameManager.PLAYER_TYPES):
	player_choosing = player
	visible = true
	selected_card = 1
	
	for i in range(max_cards):
		var rarity = Items.get_rarity(randi_range(0, Items.rarity_total))
		
		print(rarity)
		
		var card: RichTextLabel = get_child(i).get_child(0)
		
		card.text = "{name}\n{desc}\n{rarity}"

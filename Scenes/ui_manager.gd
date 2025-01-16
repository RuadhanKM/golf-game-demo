extends Panel

class_name ui

signal card_picked

func _ready() -> void:
	GameManager.ui_control = self

func _input(event: InputEvent) -> void:
	pass

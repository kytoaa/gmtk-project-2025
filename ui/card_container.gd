extends HBoxContainer

const CARD_CONTROL := preload("res://ui/card_control.tscn")

var cards: Array = []

func add_card(card) -> void:
	var control := CARD_CONTROL.instantiate()
	self.add_child(control)
	control.add_card(card)

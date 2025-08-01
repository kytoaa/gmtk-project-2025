extends Control

var card

func add_card(card) -> void:
	self.add_child(card)
	self.card = card
	card.position = Vector2(20.0, 28.0)

func get_card() -> Variant:
	return self.card

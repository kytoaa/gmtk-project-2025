extends Control

func add_card(card) -> void:
	self.add_child(card)
	card.position = Vector2(20.0, 28.0)

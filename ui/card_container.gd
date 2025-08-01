extends HBoxContainer

const CARD_CONTROL := preload("res://ui/card_control.tscn")

func add_card(card) -> void:
	var control := CARD_CONTROL.instantiate()
	self.add_child(control)
	control.add_card(card)

func get_card_with_index(index: int) -> Variant:
	for child in self.get_children():
		if child.get_card().index == index:
			return child
	printerr("no child with index ", index)
	return null

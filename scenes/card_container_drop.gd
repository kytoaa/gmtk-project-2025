extends ColorRect

signal on_drop_card(Card)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data[1].itemtype == InventoryItem.ItemType.Card

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var item
	match data[1].itemtype:
		InventoryItem.ItemType.Card:
			item = Card.build(data[1].type, data[1].suit)
			on_drop_card.emit(item)
	data[0].remove_item(item)

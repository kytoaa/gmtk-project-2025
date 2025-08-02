extends ColorRect

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data[1].itemtype == InventoryItem.ItemType.Card

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var item
	match data[1].itemtype:
		InventoryItem.ItemType.Card:
			item = Card.build(data[1].type, data[1].suit)
		InventoryItem.ItemType.GummyBear:
			item = GummyBear.new(data[1].colour)
		InventoryItem.ItemType.MokeponCard:
			item = MokeponCard.build(data[1].mokepon)
		InventoryItem.ItemType.Chip:
			item = Chip.new(data[1].colour)
	data[0].remove_item(item)

extends ColorRect

signal dropped_on_inventory(data)

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var item
	match data[1].itemtype:
		InventoryItem.ItemType.Card:
			item = Card.build(data[1].type, data[1].suit)
		InventoryItem.ItemType.MokeponCard:
			item = MokeponCard.build(data[1].mokepon)
	data[0].remove_item(item)
	GameData.inventory.add_item(item)
	dropped_on_inventory.emit(data[1])

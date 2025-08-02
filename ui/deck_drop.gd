extends Button

const DragDropLocation := preload("res://scenes/game_scene.gd").DragDropLocation

signal on_drop_card(Variant, DragDropLocation)

var can_drop: bool = true

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return (data[1].itemtype == InventoryItem.ItemType.Card or data[1].itemtype == InventoryItem.ItemType.MokeponCard) and can_drop

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var item
	match data[1].itemtype:
		InventoryItem.ItemType.Card:
			item = Card.build(data[1].type, data[1].suit)
			on_drop_card.emit(item, data[2])
		InventoryItem.ItemType.MokeponCard:
			item = MokeponCard.build(data[1].mokepon)
			on_drop_card.emit(item, data[2])
	data[0].remove_item(item)

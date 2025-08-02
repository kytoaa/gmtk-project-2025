extends HBoxContainer

const CARD_CONTROL := preload("res://ui/card_control.tscn")
const CARD_SCENE = preload("res://entities/card/card.tscn")
const MOKEPON_CARD_SCENE = preload("res://entities/mokepon/mokepon_card.tscn")
const CONTAINER_SCENE = preload("res://ui/card_container.tscn")
const INVENTORY_CONTAINER_SCENE = preload("res://entities/inventory/inventory_container.tscn")

const DragDropLocation := preload("res://scenes/game_scene.gd").DragDropLocation

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

func convert_to_draggable(cards: Array) -> void:
	for child in self.get_children():
		child.queue_free()
	for item in cards:
		var itemholder = INVENTORY_CONTAINER_SCENE.instantiate()
		if item.itemtype == InventoryItem.ItemType.Card:
			var container = CONTAINER_SCENE.instantiate()
			var card = CARD_SCENE.instantiate()
			self.add_child(itemholder)
			container.add_card(card)
			itemholder.add_item(item, container)
			card.init(item.type, item.suit)
		if item.itemtype == InventoryItem.ItemType.MokeponCard:
			var container = CONTAINER_SCENE.instantiate()
			var card = MOKEPON_CARD_SCENE.instantiate()
			self.add_child(itemholder)
			container.add_card(card)
			itemholder.add_item(item, container)
			card.init(item.mokepon)
		
		itemholder.holder.drag_location = DragDropLocation.HAND
		itemholder.holder.data = self

func remove_item(item) -> void:
	var child = self.get_children().map(func(c): return c.item).find_custom(Hand.compare_cards.bind(item))
	if child != -1:
		self.get_child(child).queue_free()

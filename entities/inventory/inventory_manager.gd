extends Control

var positions: Array[Vector2]
var home_positions: Array[Vector2]

const CARD_SCENE = preload("res://entities/card/card.tscn")
const MOKEPON_CARD_SCENE = preload("res://entities/mokepon/mokepon_card.tscn")
const CONTAINER_SCENE = preload("res://ui/card_container.tscn")
const INVENTORY_CONTAINER_SCENE = preload("res://entities/inventory/inventory_container.tscn")

@onready var grid: GridContainer = $ColorRect/ScrollContainer/MarginContainer/GridContainer

var initialised: bool = false

func init() -> void:
	self.initialised = true
	GameData.inventory.updated.connect(_on_inventory_update)
	_on_inventory_update()

func _process(delta: float) -> void:
	if not initialised:
		return

func _on_inventory_update() -> void:
	for obj in grid.get_children():
		obj.queue_free()
	print(len(GameData.inventory.items))
	for item in GameData.inventory.items:
		var itemholder = INVENTORY_CONTAINER_SCENE.instantiate()
		if item.itemtype == InventoryItem.ItemType.Card:
			var container = CONTAINER_SCENE.instantiate()
			var card = CARD_SCENE.instantiate()
			self.grid.add_child(itemholder)
			container.add_card(card)
			itemholder.add_item(item, container)
			card.init(item.type, item.suit)
		if item.itemtype == InventoryItem.ItemType.MokeponCard:
			var container = CONTAINER_SCENE.instantiate()
			var card = MOKEPON_CARD_SCENE.instantiate()
			self.grid.add_child(itemholder)
			container.add_card(card)
			itemholder.add_item(item, container)
			card.init(item.mokepon)

extends Control

var positions: Array[Vector2]
var home_positions: Array[Vector2]

const CARD_SCENE = preload("res://entities/card/card.tscn")
const CONTAINER_SCENE = preload("res://ui/card_container.tscn")
const INVENTORY_CONTAINER_SCENE = preload("res://entities/inventory/inventory_container.tscn")

@onready var grid: GridContainer = $ColorRect/MarginContainer/GridContainer

var game_data: GameData
var initialised: bool = false

func init(gd: GameData) -> void:
	self.initialised = true
	self.game_data = gd

func _process(delta: float) -> void:
	if not initialised:
		return
	
	for obj in grid.get_children():
		obj.queue_free()
	for item in game_data.inventory.items:
		if item.itemtype == InventoryItem.ItemType.Card:
			var card = CARD_SCENE.instantiate()
			var container = CONTAINER_SCENE.instantiate()
			container.add_card(card)
			var itemholder = INVENTORY_CONTAINER_SCENE.instantiate()
			self.grid.add_child(itemholder)
			itemholder.add_item(item, container)
			card.init(item.type, item.suit)
	initialised = false # to prevent it running every frame
	# ideally, this is in a function that is activated by signal when the inventory is updated

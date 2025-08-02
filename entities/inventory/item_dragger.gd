extends Control

const CARD = preload("res://entities/card/card.tscn")
const MOKEPON_CARD = preload("res://entities/mokepon/mokepon_card.tscn")
const CHIP = preload("res://entities/chip/chip.tscn")
const GUMMY_BEAR = preload("res://entities/gummy_bear/gummy_bear.tscn")

const DragDropLocation := preload("res://scenes/game_scene.gd").DragDropLocation

var drag_location: DragDropLocation = DragDropLocation.INVENTORY
@onready var data = GameData.inventory

func all_children_recurs(node: Node) -> void:
	for N in node.get_children():
		if N.is_class("Control"):
			N.mouse_filter = MOUSE_FILTER_PASS
		all_children_recurs(N)

func add_item(node: Node) -> void:
	self.add_child(node)
	all_children_recurs(self)

func _get_drag_data(at_position: Vector2) -> Variant:
	var item = get_parent().item
	match item.itemtype:
		InventoryItem.ItemType.Card:
			var card = CARD.instantiate()
			add_child(card)
			remove_child(card) # idk how to call _ready without doing this
			card.init(item.type, item.suit)
			set_drag_preview(card)
			return [self.data, item, self.drag_location]
		InventoryItem.ItemType.MokeponCard:
			var card = MOKEPON_CARD.instantiate()
			add_child(card)
			remove_child(card)
			card.init(item.mokepon)
			set_drag_preview(card)
			return [self.data, item, self.drag_location]
		InventoryItem.ItemType.GummyBear:
			var gummy_bear = GUMMY_BEAR.instantiate()
			add_child(gummy_bear)
			remove_child(gummy_bear)
			gummy_bear.init(item.colour)
			gummy_bear.get_child(0).position = Vector2.ZERO
			set_drag_preview(gummy_bear)
			return [self.data, item, self.drag_location]
		InventoryItem.ItemType.Chip:
			var chip = CHIP.instantiate()
			add_child(chip)
			remove_child(chip)
			chip.init(item.colour)
			chip.get_child(0).position = Vector2.ZERO
			set_drag_preview(chip)
			return [self.data, item, self.drag_location]
	return []

func _on_mouse_entered() -> void:
	self.modulate = Color(0.5, 0.5, 0.5)
	
func _on_mouse_exited() -> void:
	self.modulate = Color(1, 1, 1)

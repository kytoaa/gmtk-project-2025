extends ColorRect

var contents: Inventory = Inventory.new()

const CARD = preload("res://entities/card/card.tscn")
const GUMMY = preload("res://entities/gummy_bear/gummy_bear.tscn")
const CHIP = preload("res://entities/chip/chip.tscn")

@onready var pot_amount_label = $Label
var can_add_to_pot: bool = true

var item_children = []

func _ready() -> void:
	self.contents.updated.connect(update_label)

func update_label() -> void:
	self.pot_amount_label.text = "£" + str(contents.money(true))

func total() -> int:
	return contents.money(true)

func clear() -> Array:
	for child in self.item_children:
		child.queue_free()
	
	var items = self.contents.items.map(
		func(item):
			match item.itemtype:
				InventoryItem.ItemType.Chip:
					return Chip.new(item.colour, 2)
				InventoryItem.ItemType.GummyBear:
					return Chip.new(item.colour, 2)
				InventoryItem.ItemType.Card:
					return Chip.new(Chip.Colour.Red
									if item.suit in [Card.CardSuit.HEARTS, Card.CardSuit.DIAMONDS]
									else Chip.Colour.Blue, 2)
	)
	self.contents.items.clear()
	
	self.update_label()
	
	return items

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return self.can_add_to_pot \
			and (data[1].itemtype == InventoryItem.ItemType.Card
			or data[1].itemtype == InventoryItem.ItemType.Chip
			or (data[1].itemtype == InventoryItem.ItemType.GummyBear
				and data[1].colour in GummyBear.BET_COLOURS))

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var item
	var item_sprite
	match data[1].itemtype:
		InventoryItem.ItemType.Card:
			item = Card.build(data[1].type, data[1].suit)
			item_sprite = CARD.instantiate()
			self.add_child(item_sprite)
			self.item_children.append(item_sprite)
			item_sprite.mouse_filter = Control.MOUSE_FILTER_PASS
			item_sprite.init(item.type, item.suit)
		InventoryItem.ItemType.GummyBear:
			item = GummyBear.new(data[1].colour)
			item_sprite = GUMMY.instantiate()
			self.add_child(item_sprite)
			self.item_children.append(item_sprite)
			item_sprite.mouse_filter = Control.MOUSE_FILTER_PASS
			item_sprite.init(item.colour)
		InventoryItem.ItemType.MokeponCard:
			item = MokeponCard.build(data[1].mokepon)
		InventoryItem.ItemType.Chip:
			item = Chip.new(data[1].colour)
			item_sprite = CHIP.instantiate()
			self.add_child(item_sprite)
			self.item_children.append(item_sprite)
			item_sprite.mouse_filter = Control.MOUSE_FILTER_PASS
			item_sprite.init(item.colour)
	data[0].remove_item(item)
	self.contents.add_item(item)
	if item.itemtype == InventoryItem.ItemType.Card:
		item_sprite.global_position = at_position + self.global_position
	else:
		item_sprite.global_position = at_position + self.global_position \
		- Vector2(40, 56)/2

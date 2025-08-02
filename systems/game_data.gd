extends Node

var deck: Deck
var inventory: Inventory
var cheat_meter: float

var shop: Shop

func _init() -> void:
	self.deck = Deck.new()
	self.inventory = Inventory.new()
	self.shop = Shop.new()
	cheat_meter = 20.0

func init():
	self.inventory.add_item(Chip.new(Chip.Colour.White, 10))
	self.inventory.add_item(Chip.new(Chip.Colour.Red, 5))
	self.inventory.add_item(Chip.new(Chip.Colour.Blue, 3))
	self.inventory.add_item(Chip.new(Chip.Colour.Green, 1))
	
	self.inventory.add_item(GummyBear.new(GummyBear.Colour.Red, 3))

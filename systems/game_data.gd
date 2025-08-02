extends Node

signal cheat_meter_changed(int)

var deck: Deck
var inventory: Inventory
var _cheat_meter: int
var cheat_meter: int:
	get: return _cheat_meter
	set(value):
		_cheat_meter = clamp(value, 0, 100)
		cheat_meter_changed.emit(_cheat_meter)

var shop: Shop

func _init() -> void:
	self.deck = Deck.new()
	self.inventory = Inventory.new()
	self.shop = Shop.new()
	self._cheat_meter = 20

func init():
	self.inventory.add_item(Chip.new(Chip.Colour.White, 10))
	self.inventory.add_item(Chip.new(Chip.Colour.Red, 5))
	self.inventory.add_item(Chip.new(Chip.Colour.Blue, 3))
	self.inventory.add_item(Chip.new(Chip.Colour.Green, 1))
	
	self.inventory.add_item(GummyBear.new(GummyBear.Colour.Red, 3))

enum LossReason {
	CHEATING,
	NO_MONEY,
}

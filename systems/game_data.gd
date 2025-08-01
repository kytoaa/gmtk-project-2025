class_name GameData
extends Resource

var deck: Deck
var inventory: Inventory
var cheat_meter: float

func _init() -> void:
	self.deck = Deck.new()
	self.inventory = Inventory.new()
	cheat_meter = 20.0

extends Node

var deck: Deck
var inventory: Inventory
var cheat_meter: float

func init() -> void:
	self.deck = Deck.new()
	self.inventory = Inventory.new()
	cheat_meter = 20.0

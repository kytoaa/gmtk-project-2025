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

func init(): pass

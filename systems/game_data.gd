class_name GameData
extends Resource

var deck: Deck
var inventory
var cheat_meter: float

func _init() -> void:
	self.deck = Deck.new()
	cheat_meter = 20.0

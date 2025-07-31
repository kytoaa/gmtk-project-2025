class_name Chip
extends InventoryItem

enum Colour {
	Blue = 10,
	Green = 50,
	Red = 100,
	Black = 1000
}

var colour: Colour

func _init(colour: Colour, count: int) -> void:
	self.colour = colour
	self.count = count
	self.itemtype = ItemType.Chip

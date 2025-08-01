class_name Chip
extends InventoryItem

enum Colour {
	White = 1,
	Red = 10,
	Blue = 50,
	Green = 100,
	Black = 500,
}

var colour: Colour

func _init(colour: Colour, count: int) -> void:
	self.colour = colour
	self.count = count
	self.itemtype = ItemType.Chip

class_name GummyBear
extends InventoryItem

enum Colour {
	White = 1,
	Red = 10,
	Blue = 50,
	Green = 100,
	Black = 500,
	Yellow,
	Pink,
	Orange,
	Purple,
}

var colour: Colour

func _init(colour: Colour, count: int = 1) -> void:
	self.colour = colour
	self.count = count
	self.itemtype = ItemType.GummyBear

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

func _init(colour: Colour) -> void:
	self.colour = colour

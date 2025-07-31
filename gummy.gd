class_name GummyBear
extends InventoryItem

enum Colour {
	Yellow = 0,
	Pink,
	Orange,
	Purple,
	Blue = 10,
	Green = 50,
	Red = 100,
	Black = 1000,
}

var colour: Colour

func _init(colour: Colour) -> void:
	self.colour = colour

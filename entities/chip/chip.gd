extends Control

const Colour = Chip.Colour

@onready var sprite: Sprite2D = $Sprite2D

func init(colour: Colour) -> void:
	match colour:
		Colour.White:
			sprite.region_rect.position.x = 0
		Colour.Red:
			sprite.region_rect.position.x = 28
		Colour.Blue:
			sprite.region_rect.position.x = 56
		Colour.Green:
			sprite.region_rect.position.x = 84
		Colour.Black:
			sprite.region_rect.position.x = 112

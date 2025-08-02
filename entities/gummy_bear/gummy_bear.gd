extends Control

const Colour = GummyBear.Colour

@onready var sprite: Sprite2D = $Sprite2D

func init(colour: Colour) -> void:
	match colour:
		Colour.White:
			sprite.region_rect.position.x = 0
		Colour.Red:
			sprite.region_rect.position.x = 12 * 1
		Colour.Blue:
			sprite.region_rect.position.x = 12 * 2
		Colour.Green:
			sprite.region_rect.position.x = 12 * 3
		Colour.Black:
			sprite.region_rect.position.x = 12 * 4
		Colour.Yellow:
			sprite.region_rect.position.x = 12 * 5
		Colour.Pink:
			sprite.region_rect.position.x = 12 * 6
		Colour.Orange:
			sprite.region_rect.position.x = 12 * 7
		Colour.Purple:
			sprite.region_rect.position.x = 12 * 8

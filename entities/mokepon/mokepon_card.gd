extends Control

const Mokepon = MokeponCard.Mokepon

@onready var sprite: Sprite2D = $Background/Mokepon

var index: int

func init(mokepon: Mokepon, index: int = 0) -> void:
	self.index = index
	match mokepon:
		Mokepon.MatsuneHiku:
			sprite.texture = preload("res://entities/mokepon/matsune_hiku.png")
		Mokepon.Waarizard:
			sprite.texture = preload("res://entities/mokepon/waarizard.png")
		Mokepon.Pigglyjuff:
			sprite.texture = preload("res://entities/mokepon/pigglyjuff.png")
		Mokepon.MoroGajima:
			sprite.texture = preload("res://entities/mokepon/moro_gajima.png")

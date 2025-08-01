extends Node2D

const Mokepon = MokeponCard.Mokepon

var index: int

func init(mokepon: Mokepon, index: int) -> void:
	self.index = index

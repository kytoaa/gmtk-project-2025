class_name MokeponCard
extends InventoryItem

enum Mokepon {
	Waarizard = 0,
	Cheevee,
	Pigglyjuff,
	MoroGajima,
	MatsuneHiku,
	Marados,
	Vardegoir
}

var mokepon: Mokepon

func _init(mokepon: Mokepon) -> void:
	self.mokepon = mokepon

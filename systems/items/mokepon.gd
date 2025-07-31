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

func _init(mokepon: Mokepon, count: int = 1) -> void:
	self.mokepon = mokepon
	self.count = count
	self.itemtype = ItemType.MokeponCard

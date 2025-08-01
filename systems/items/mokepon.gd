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

static func build(mokepon: Mokepon) -> MokeponCard:
	var card = MokeponCard.new()
	card.mokepon = mokepon
	return card

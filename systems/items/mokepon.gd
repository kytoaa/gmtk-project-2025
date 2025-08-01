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

static func build(mokepon: Mokepon, count: int = 1) -> MokeponCard:
	var card = MokeponCard.new()
	card.mokepon = mokepon
	card.count = count
	card.itemtype = ItemType.MokeponCard
	return card

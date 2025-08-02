class_name MokeponCard
extends InventoryItem

enum Mokepon {
	Waarizard = 0,
	Pigglyjuff,
	MoroGajima,
	MatsuneHiku,
}

var mokepon: Mokepon

static func build(mokepon: Mokepon, count: int = 1) -> MokeponCard:
	var card = MokeponCard.new()
	card.mokepon = mokepon
	card.count = count
	card.itemtype = ItemType.MokeponCard
	return card

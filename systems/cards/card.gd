class_name Card
extends InventoryItem

var type: CardType
var suit: CardSuit
var times_used: int
var marked: bool

func play_card() -> void:
	self.times_used += 1
	
	if self.type == CardType.NUMBER_11 && self.times_used == 2:
		if randi() % 2 == 0:
			self.type = CardType.NUMBER_12
		else:
			self.type = CardType.NUMBER_13

static func build(type: CardType, suit: CardSuit, count: int = 1) -> Card:
	var card = Card.new()
	card.type = type
	card.suit = suit
	card.times_used = 0
	card.marked = false
	card.count = count
	card.itemtype = ItemType.Card
	return card


enum CardType {
	NUMBER_1 = 1,
	NUMBER_2,
	NUMBER_3,
	NUMBER_4,
	NUMBER_5,
	NUMBER_6,
	NUMBER_7,
	NUMBER_8,
	NUMBER_9,
	NUMBER_10,
	NUMBER_11,
	NUMBER_12,
	NUMBER_13,
}

enum CardSuit {
	HEARTS,
	DIAMONDS,
	CLUBS,
	SPADES,
}

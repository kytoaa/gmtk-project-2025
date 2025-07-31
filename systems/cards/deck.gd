class_name Deck
extends Resource


var cards: Array[Card]


func _init() -> void:
	var cards = []
	for suit in CardSuit.values():
		for card in CardType.values():
			cards.append(Card.build(card, suit))
	
	self.cards = cards


enum CardType {
	NUMBER_1,
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
	A,
	B,
	C,
	D,
}

class Card:
	var type: CardType
	var suit: CardSuit
	
	static func build(type: CardType, suit: CardSuit) -> Card:
		var card = Card.new()
		card.type = type
		card.suit = suit
		return card

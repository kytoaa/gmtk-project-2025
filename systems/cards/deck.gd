class_name Deck
extends Resource

const CardSuit = Card.CardSuit
const CardType = Card.CardType

var cards: Array[Card]


func _init() -> void:
	var cards = []
	for suit in CardSuit.values():
		for type in CardType.values():
			cards.append(Card.build(type, suit))
	
	self.cards = cards

func count_suit(suit: CardSuit) -> int:
	return len(self.cards.filter(func(card: Card): card.suit == suit))

func count_type(type: CardType) -> int:
	return len(self.cards.filter(func(card: Card): card.type == type))

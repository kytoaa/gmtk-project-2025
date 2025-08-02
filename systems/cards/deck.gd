class_name Deck
extends Resource

signal reached_max_cards

const CardSuit = Card.CardSuit
const CardType = Card.CardType

const MAX_CARDS := 52

var cards: Array


func _init() -> void:
	var cards := []
	for suit in CardSuit.values():
		for type in CardType.values():
			cards.append(Card.build(type, suit))
	
	self.cards = cards

func count_suit(suit: CardSuit) -> int:
	return len(self.cards.filter(func(card): "suit" in card and card.suit == suit))

func count_type(type: CardType) -> int:
	return len(self.cards.filter(func(card): "type" in card and card.type == type))

func shuffle() -> void:
	self.cards.shuffle()

func draw_card() -> Variant:
	return self.cards.pop_back()

func add_card(card) -> void:
	self.cards.insert(0, card)
	if len(self.cards) == MAX_CARDS:
		reached_max_cards.emit()

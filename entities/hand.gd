class_name Hand
extends Resource

var cards
var sum: int
var base_sum: int          # sum where aces = 1 point


func _init() -> void:
	self.cards = []
	self.sum = 0

func add_card(card) -> void:
	cards.append(card)
	if not "type" in card:
		return
	
	var _sum = self.base_sum
	
	var hand_has_ace = (cards.find(Card.CardType.NUMBER_1) != -1)
	match card.type:
		Card.CardType.NUMBER_11, Card.CardType.NUMBER_12, Card.CardType.NUMBER_13:
			_sum += 10
		Card.CardType.NUMBER_1:
			_sum += 1
			hand_has_ace = true
		_:
			_sum += int(card.type)
	self.base_sum = _sum
	
	var hand_has_eight = (cards.find(Card.CardType.NUMBER_8) != -1)
	
	if hand_has_ace and !hand_has_eight:
		_sum += 10
	
	self.sum = _sum

func has_lost() -> bool:
	return sum > 21

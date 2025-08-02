class_name Hand
extends Resource

var cards
var sum: int
var base_sum: int          # sum where aces = 1 point

const RuleIndex = GameData.RuleIndex

signal hand_empty

func _init() -> void:
	self.cards = []
	self.sum = 0

func add_card(card) -> int:
	cards.append(card)
	if not "type" in card:
		GameData.push_popup_queue(RuleIndex.DrawMokepon)
		return len(self.cards) - 1
	
	if card.type == Card.CardType.NUMBER_13:
		GameData.inventory.add_item(Chip.new(50))
		GameData.push_popup_queue(RuleIndex.KingRich)
	if card.suit == Card.CardSuit.DIAMONDS:
		GameData.push_popup_queue(RuleIndex.DiamondPrickly)
	if len(cards) > 1 and card.suit == Card.CardSuit.HEARTS and cards[len(cards)-2].suit == Card.CardSuit.HEARTS:
		GameData.push_popup_queue(RuleIndex.HeartsBackToBack)
		cards.pop_back()
		var removed: Card = cards.pop_back()
		match removed.type:
			Card.CardType.NUMBER_11, Card.CardType.NUMBER_12, Card.CardType.NUMBER_13:
				self.base_sum -= 10
			Card.CardType.NUMBER_1:
				self.base_sum -= 1
			_:
				self.base_sum -= int(card.type)
		cards.append(Card.build(Card.CardType.NUMBER_1, Card.CardSuit.HEARTS))
	
	var _sum = self.base_sum
	var hand_has_ace = (cards.find_custom(func(card): return "type" in card and card.type == Card.CardType.NUMBER_1) != -1)
	match card.type:
		Card.CardType.NUMBER_11, Card.CardType.NUMBER_12, Card.CardType.NUMBER_13:
			_sum += 10
		Card.CardType.NUMBER_1:
			_sum += 1
			hand_has_ace = true
		_:
			_sum += int(card.type)
	self.base_sum = _sum
	
	var hand_has_eight = (cards.find_custom(func(card): return "type" in card and card.type == Card.CardType.NUMBER_8) != -1)
	print("has ace")
	if hand_has_ace and !hand_has_eight:
		_sum += 10
	
	if hand_has_ace and hand_has_eight:
		GameData.push_popup_queue(RuleIndex.Aces8s)
	
	self.sum = _sum
	
	return len(self.cards) - 1

func remove_card(card) -> void:
	var i = self.cards.find_custom(compare_cards.bind(card))
	if i != -1:
		self.cards.remove_at(i)
		if len(self.cards) == 0:
			self.hand_empty.emit()

func has_lost() -> bool:
	return sum > 21

static func compare_cards(card, card2) -> bool:
	if "type" in card and "type" in card2:
		return card2.type == card.type and card2.suit == card.suit
	elif "mokepon" in card and "mokepon" in card2:
		return card2.mokepon == card.mokepon
	else:
		return false

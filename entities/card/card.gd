extends Node2D

const CardType = Card.CardType
const CardSuit = Card.CardSuit

const DARK_COLOR: Color = Color("0f0030")
const LIGHT_COLOR: Color = Color("d51010")

@onready var number1: Sprite2D = $NumberSuit1/Number
@onready var number2: Sprite2D = $NumberSuit2/Number
@onready var suit1: Sprite2D = $NumberSuit1/Suit
@onready var suit2: Sprite2D = $NumberSuit2/Suit

var index: int

func init(type: CardType, suit: CardSuit, index: int) -> void:
	self.index = index
	number1.offset.x = 0
	number1.region_rect.size.x = 3
	number1.flip_h = false
	number2.offset.x = 0
	number2.region_rect.size.x = 3
	number2.flip_h = false
	match type:
		CardType.NUMBER_1:
			number1.region_rect.position.x = 50.0
			number2.region_rect.position.x = 50.0
		CardType.NUMBER_2:
			number1.region_rect.position.x = 6.0
			number2.region_rect.position.x = 6.0
		CardType.NUMBER_3:
			number1.region_rect.position.x = 10.0
			number2.region_rect.position.x = 10.0
		CardType.NUMBER_4:
			number1.region_rect.position.x = 14.0
			number2.region_rect.position.x = 14.0
		CardType.NUMBER_5:
			number1.region_rect.position.x = 18.0
			number2.region_rect.position.x = 18.0
		CardType.NUMBER_6:
			number1.region_rect.position.x = 22.0
			number2.region_rect.position.x = 22.0
		CardType.NUMBER_7:
			number1.region_rect.position.x = 26.0
			number2.region_rect.position.x = 26.0
		CardType.NUMBER_8:
			number1.region_rect.position.x = 30.0
			number2.region_rect.position.x = 30.0
		CardType.NUMBER_9:
			number1.region_rect.position.x = 34.0
			number2.region_rect.position.x = 34.0
		CardType.NUMBER_10:
			number1.region_rect.position.x = 0.0
			number1.region_rect.size.x = 5.0
			number1.offset.x = 1.0
			number1.flip_h = true
			number2.region_rect.position.x = 0.0
			number2.region_rect.size.x = 5.0
			number2.offset.x = 1.0
			number2.flip_h = true
		CardType.NUMBER_11:
			number1.region_rect.position.x = 38.0
			number2.region_rect.position.x = 38.0
		CardType.NUMBER_12:
			number1.region_rect.position.x = 42.0
			number2.region_rect.position.x = 42.0
		CardType.NUMBER_13:
			number1.region_rect.position.x = 46.0
			number2.region_rect.position.x = 46.0
	
	match suit:
		CardSuit.HEARTS, CardSuit.DIAMONDS:
			number1.self_modulate = LIGHT_COLOR
			suit1.self_modulate = LIGHT_COLOR
			number2.self_modulate = LIGHT_COLOR
			suit2.self_modulate = LIGHT_COLOR
		CardSuit.CLUBS, CardSuit.SPADES:
			number1.modulate = DARK_COLOR
			suit1.self_modulate = DARK_COLOR
			number2.self_modulate = DARK_COLOR
			suit2.self_modulate = DARK_COLOR
	match suit:
		CardSuit.HEARTS:
			suit1.region_rect.position.x = 58
			suit2.region_rect.position.x = 58
		CardSuit.DIAMONDS:
			suit1.region_rect.position.x = 54
			suit2.region_rect.position.x = 54
		CardSuit.CLUBS:
			suit1.region_rect.position.x = 62
			suit2.region_rect.position.x = 62
		CardSuit.SPADES:
			suit1.region_rect.position.x = 66
			suit2.region_rect.position.x = 66

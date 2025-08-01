extends Node

const CardContainer = preload("res://ui/card_container.gd")
const CARD = preload("res://entities/card/card.tscn")

@onready var deck: Deck = Deck.new()
@onready var player_hand: Hand = Hand.new()
@onready var dealer_hand: Hand = Hand.new()

@onready var player_hand_display: CardContainer = $UI/SegmentSplitter/VBoxContainer2/PlayerCards/MarginContainer/CardContainer
@onready var dealer_hand_display: CardContainer = $UI/SegmentSplitter/VBoxContainer2/OpponentCards/MarginContainer/CardContainer


func _ready() -> void:
	self.deck.shuffle()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		draw_dealer_card()

func draw_player_card() -> void:
	self.draw_card(player_hand, player_hand_display, player_lose)
	
func draw_dealer_card() -> void:
	self.draw_card(dealer_hand, dealer_hand_display, dealer_lose)

func draw_card(hand: Hand, card_container: CardContainer, loss_f: Callable) -> void:
	if hand.has_lost():
		return
	
	var card = self.deck.draw_card()
	
	hand.add_card(card)
	
	var card_sprite := CARD.instantiate()
	card_container.add_card(card_sprite)
	card_sprite.init(card.type, card.suit)
	
	if hand.has_lost():
		loss_f.call()
		return


func player_lose() -> void:
	pass

func dealer_lose() -> void:
	pass

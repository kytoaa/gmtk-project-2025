extends Node

const CardContainer = preload("res://ui/card_container.gd")
const CARD = preload("res://entities/card/card.tscn")

var game_data: GameData
@onready var player_hand: Hand = Hand.new()
@onready var dealer_hand: Hand = Hand.new()

@onready var player_hand_display: CardContainer = $UI/SegmentSplitter/VBoxContainer2/PlayerCards/MarginContainer/CardContainer
@onready var dealer_hand_display: CardContainer = $UI/SegmentSplitter/VBoxContainer2/OpponentCards/MarginContainer/CardContainer

var player_turn: bool = true

func _ready() -> void:
	self.init(GameData.new())
	self.game_data.deck.shuffle()

func init(game_data: GameData) -> void:
	self.game_data = game_data

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		draw_dealer_card()

func draw_player_card() -> void:
	if not player_turn:
		return
	
	var card = self.draw_card(player_hand, player_hand_display, player_lose)
	if "mokepon" in card:
		player_turn = false
	
func draw_dealer_card() -> void:
	if player_turn:
		return
	
	var card = self.draw_card(dealer_hand, dealer_hand_display, dealer_lose)
	if "mokepon" in card:
		game_data.cheat_meter += 20.0

func draw_card(hand: Hand, card_container: CardContainer, loss_f: Callable) -> Variant:
	var card = self.game_data.deck.draw_card()
	
	hand.add_card(card)
	
	var card_sprite := CARD.instantiate()
	card_container.add_card(card_sprite)
	card_sprite.init(card.type, card.suit)
	
	if hand.has_lost():
		loss_f.call()
		return card
	
	return card


func player_lose() -> void:
	SignalBus.on_player_loss.emit()

func dealer_lose() -> void:
	SignalBus.on_dealer_loss.emit()

extends Node

const CardContainer = preload("res://ui/card_container.gd")

const CARD_SPRITE = preload("res://entities/card/card.tscn")
const MOKEPON_SPRITE = preload("res://entities/mokepon/mokepon_card.tscn")

var game_data: GameData
@onready var player_hand: Hand = Hand.new()
@onready var dealer_hand: Hand = Hand.new()

@onready var player_hand_display: CardContainer = $UI/SegmentSplitter/VBoxContainer2/PlayerCards/MarginContainer/CardContainer
@onready var player_hand_total: Label = $UI/SegmentSplitter/VBoxContainer2/PlayerCards/TotalDisplay
@onready var dealer_hand_display: CardContainer = $UI/SegmentSplitter/VBoxContainer2/OpponentCards/MarginContainer/CardContainer
@onready var dealer_hand_total: Label = $UI/SegmentSplitter/VBoxContainer2/OpponentCards/TotalDisplay
@onready var inventory: Control = %Inventory

var player_turn: bool = true

func _ready() -> void:
	self.init(GameData.new())
	self.game_data.deck.shuffle()

func init(game_data: GameData) -> void:
	self.game_data = game_data
	self.inventory.init(game_data)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		draw_dealer_card()

func draw_player_card() -> void:
	if not player_turn:
		return
	
	var card = self.draw_card(player_hand, player_hand_display, player_lose)
	player_hand_total.text = "Total: " + str(player_hand.sum)
	if "mokepon" in card:
		player_turn = false

func player_hold() -> void:
	if not player_turn:
		return
	
	player_turn = false

func draw_dealer_card() -> void:
	if player_turn:
		return
	
	var card = self.draw_card(dealer_hand, dealer_hand_display, dealer_lose)
	dealer_hand_total.text = "Total: " + str(dealer_hand.sum)
	if "mokepon" in card:
		game_data.cheat_meter += 20.0

func draw_card(hand: Hand, card_container: CardContainer, loss_f: Callable) -> Variant:
	var card = self.game_data.deck.draw_card()
	
	hand.add_card(card)
	
	var is_mokepon = "mokepon" in card
	
	var card_sprite := MOKEPON_SPRITE.instantiate() if is_mokepon else CARD_SPRITE.instantiate()
	card_container.add_card(card_sprite)
	if is_mokepon:
		card_sprite.init(card.mokepon)
	else:
		card_sprite.init(card.type, card.suit)
	
	if hand.has_lost():
		loss_f.call()
		return card
	
	return card


func player_lose() -> void:
	player_turn = false
	SignalBus.on_player_loss.emit()

func dealer_lose() -> void:
	SignalBus.on_dealer_loss.emit()

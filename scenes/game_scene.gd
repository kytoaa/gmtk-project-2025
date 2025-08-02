extends Node

const CardContainer = preload("res://ui/card_container.gd")

const CARD_SPRITE := preload("res://entities/card/card.tscn")
const MOKEPON_SPRITE := preload("res://entities/mokepon/mokepon_card.tscn")
const ROUND_END_MENU := preload("res://ui/round_end_menu.tscn")

@onready var player_hand: Hand = Hand.new()
@onready var dealer_hand: Hand = Hand.new()

@onready var player_hand_display: CardContainer = $UI/SegmentSplitter/VBoxContainer2/PlayerCards/MarginContainer/CardContainer
@onready var player_hand_total: Label = $UI/SegmentSplitter/VBoxContainer2/PlayerCards/TotalDisplay
@onready var dealer_hand_display: CardContainer = $UI/SegmentSplitter/VBoxContainer2/OpponentCards/MarginContainer/CardContainer
@onready var dealer_hand_total: Label = $UI/SegmentSplitter/VBoxContainer2/OpponentCards/TotalDisplay
@onready var inventory: Control = %Inventory

var player_turn: bool = true

func _ready() -> void:
	SignalBus.go_to_shop.connect(go_to_shop_cleanup)
	
	self.init()
	GameData.deck.shuffle()
	#GameData.inventory.add_item()
	#GameData.inventory.add_item(MokeponCard.build(MokeponCard.Mokepon.MatsuneHiku))
	GameData.inventory.add_item(Card.build(Card.CardType.NUMBER_1, Card.CardSuit.SPADES))
	GameData.inventory.add_item(Card.build(Card.CardType.NUMBER_2, Card.CardSuit.SPADES))
	GameData.inventory.add_item(Card.build(Card.CardType.NUMBER_3, Card.CardSuit.SPADES))
	GameData.inventory.add_item(Card.build(Card.CardType.NUMBER_4, Card.CardSuit.SPADES))

func init() -> void:
	GameData.init()
	self.inventory.init()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		draw_dealer_card()

func draw_player_card() -> void:
	if not player_turn:
		return
	
	var card = self.draw_card(player_hand, player_hand_display)
	
	player_hand_total.text = "Total: " + str(player_hand.sum)
	
	if player_hand.has_lost():
		self.player_lose()
		return
	if player_hand.sum == 21:
		self.dealer_lose()
		return
	
	if "mokepon" in card:
		player_turn = false

func player_hold() -> void:
	if not player_turn:
		return
	
	player_turn = false

func draw_dealer_card() -> void:
	if player_turn:
		return
	
	var card = self.draw_card(dealer_hand, dealer_hand_display)
	
	dealer_hand_total.text = "Total: " + str(dealer_hand.sum)
	
	if dealer_hand.has_lost():
		self.dealer_lose()
		return
	
	if "mokepon" in card:
		GameData.cheat_meter += 20.0

func dealer_hold() -> void:
	if player_turn:
		return
	
	if player_hand.sum > dealer_hand.sum:
		self.dealer_lose()
	else:
		self.player_lose()

func draw_card(hand: Hand, card_container: CardContainer) -> Variant:
	var card = GameData.deck.draw_card()
	return self.add_card_to_hand(hand, card_container, card)


func add_card_to_hand(hand: Hand, card_container: CardContainer, card) -> Variant:
	var card_index := hand.add_card(card)
	
	var is_mokepon = "mokepon" in card
	
	var card_sprite := MOKEPON_SPRITE.instantiate() if is_mokepon else CARD_SPRITE.instantiate()
	card_container.add_card(card_sprite)
	if is_mokepon:
		card_sprite.init(card.mokepon, card_index)
	else:
		card_sprite.init(card.type, card.suit, card_index)
	
	return card

func player_lose() -> void:
	var round_end_menu = ROUND_END_MENU.instantiate()
	$UI.add_child(round_end_menu)
	round_end_menu.init(false)
	SignalBus.on_player_loss.emit()

func dealer_lose() -> void:
	var round_end_menu = ROUND_END_MENU.instantiate()
	$UI.add_child(round_end_menu)
	round_end_menu.init(true)
	SignalBus.on_dealer_loss.emit()

func game_continue() -> void:
	pass

func move_card_from_player_hand_to_deck(card_index: int) -> void:
	var card = player_hand.remove_card(card_index)
	GameData.deck.add_card(card)
	
	var child = self.player_hand_display.get_card_with_index(card_index)
	
	if child == null:
		return
	
	child.queue_free()

func move_card_from_player_hand_to_inventory(card_index: int) -> void:
	var card = player_hand.remove_card(card_index)
	GameData.inventory.add_item(card)
	
	var child = self.player_hand_display.get_card_with_index(card_index)
	
	if child == null:
		return
	
	child.queue_free()

func move_card_from_inventory_to_player_hand(card) -> void:
	if not "suit" in card:
		return
	GameData.inventory.remove_item(card)
	self.add_card_to_hand(player_hand, player_hand_display, card)
	
	player_hand_total.text = "Total: " + str(player_hand.sum)
	
	if player_hand.has_lost():
		self.player_lose()
		return
	if player_hand.sum == 21:
		self.dealer_lose()
		return

func move_card_from_inventory_to_deck(card) -> void:
	if not "suit" in card:
		return
	GameData.inventory.remove_item(card)
	GameData.deck.add_card(card)

func go_to_shop_cleanup() -> void:
	for card_index in range(len(self.player_hand.cards)):
		self.move_card_from_player_hand_to_deck(card_index)

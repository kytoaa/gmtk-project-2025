extends Node

const CardContainer = preload("res://ui/card_container.gd")

const CARD_SPRITE := preload("res://entities/card/card.tscn")
const MOKEPON_SPRITE := preload("res://entities/mokepon/mokepon_card.tscn")
const ROUND_END_MENU := preload("res://ui/round_end_menu.tscn")

enum DragDropLocation {
	HAND,
	DECK,
	INVENTORY,
}

enum GameState {
	PLAYER_TURN,
	OPPONENT_TURN,
	RETURN_CARDS,
	MENU,
}

@onready var player_hand: Hand = Hand.new()
@onready var dealer_hand: Hand = Hand.new()

@onready var player_hand_display: CardContainer = $UI/SegmentSplitter/VBoxContainer2/PlayerCards/MarginContainer/CardContainer
@onready var player_hand_total: Label = $UI/SegmentSplitter/VBoxContainer2/PlayerCards/TotalDisplay
@onready var dealer_hand_display: CardContainer = $UI/SegmentSplitter/VBoxContainer2/OpponentCards/MarginContainer/CardContainer
@onready var dealer_hand_total: Label = $UI/SegmentSplitter/VBoxContainer2/OpponentCards/TotalDisplay
@onready var inventory: Control = %Inventory

var game_state: GameState = GameState.PLAYER_TURN

var dealer_can_play: bool = true

var round_end_menu: Node

func _ready() -> void:
	SignalBus.go_to_shop.connect(go_to_shop_cleanup)
	SignalBus.continue_game.connect(continue_game)
	
	%Inventory.get_child(0).dropped_on_inventory.connect(move_card_from_player_hand_to_inventory)
	
	$UI/SegmentSplitter/VBoxContainer2/PlayerCards/MarginContainer/ColorRect.on_drop_card.connect(
		func(card, location):
			match location:
				DragDropLocation.INVENTORY:
					move_card_from_inventory_to_player_hand(card)
				_: printerr("dragged from ", location, " to hand")
	)
	$UI/SegmentSplitter/RightSide/VBoxContainer/Deck/Sprite2D/Button.on_drop_card.connect(
		func(card, location):
			match location:
				DragDropLocation.HAND:
					move_card_from_player_hand_to_deck(card)
				DragDropLocation.INVENTORY:
					move_card_from_inventory_to_deck(card)
				_: printerr("dragged from ", location, " to deck")
	)
	
	self.init()
	GameData.deck.shuffle()
	GameData.deck.card_count_change.connect(func(count): $UI/SegmentSplitter/RightSide/VBoxContainer/Deck/CardCount.text = str(count))
	#GameData.inventory.add_item()
	#GameData.inventory.add_item(MokeponCard.build(MokeponCard.Mokepon.MatsuneHiku))
	GameData.inventory.add_item(Card.build(Card.CardType.NUMBER_1, Card.CardSuit.SPADES))
	GameData.inventory.add_item(Card.build(Card.CardType.NUMBER_2, Card.CardSuit.SPADES))
	GameData.inventory.add_item(Card.build(Card.CardType.NUMBER_3, Card.CardSuit.SPADES))
	GameData.inventory.add_item(Card.build(Card.CardType.NUMBER_4, Card.CardSuit.SPADES))
	for i in range(20):
		GameData.inventory.add_item(MokeponCard.build(MokeponCard.Mokepon.MatsuneHiku))
	GameData.inventory.add_item(GummyBear.new(GummyBear.Colour.Red, 3))
	GameData.inventory.add_item(GummyBear.new(GummyBear.Colour.Green, 1))
	GameData.inventory.add_item(Chip.new(Chip.Colour.Black, 2))
	GameData.inventory.add_item(Chip.new(Chip.Colour.White, 2))

func init() -> void:
	GameData.init()
	self.inventory.init()

func _process(delta: float) -> void:
	match game_state:
		GameState.PLAYER_TURN:
			$UI/SegmentSplitter/RightSide/VBoxContainer/Deck/Sprite2D/Button.can_drop = false
			$UI/SegmentSplitter/VBoxContainer2/PlayerCards/MarginContainer/ColorRect.can_drop = true
		GameState.OPPONENT_TURN:
			$UI/SegmentSplitter/RightSide/VBoxContainer/Deck/Sprite2D/Button.can_drop = false
			$UI/SegmentSplitter/VBoxContainer2/PlayerCards/MarginContainer/ColorRect.can_drop = false
			if dealer_can_play:
				dealer_turn()
		GameState.MENU:
			$UI/SegmentSplitter/RightSide/VBoxContainer/Deck/Sprite2D/Button.can_drop = false
			$UI/SegmentSplitter/VBoxContainer2/PlayerCards/MarginContainer/ColorRect.can_drop = false
		GameState.RETURN_CARDS:
			$UI/SegmentSplitter/RightSide/VBoxContainer/Deck/Sprite2D/Button.can_drop = true
			$UI/SegmentSplitter/VBoxContainer2/PlayerCards/MarginContainer/ColorRect.can_drop = false
			if len(GameData.deck.cards) == Deck.MAX_CARDS:
				$UI/SegmentSplitter/RightSide/VBoxContainer/Deck/Sprite2D/Button.can_drop = false


func dealer_turn() -> void:
	dealer_can_play = false
	await get_tree().create_timer(1.5).timeout
	if DealerAI.should_draw(dealer_hand.sum, player_hand.sum):
		draw_dealer_card()
	else:
		dealer_hold()
	dealer_can_play = true


func draw_player_card() -> void:
	if game_state != GameState.PLAYER_TURN:
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
		game_state = GameState.OPPONENT_TURN

func player_hold() -> void:
	if game_state != GameState.PLAYER_TURN:
		return
	
	game_state = GameState.OPPONENT_TURN

func draw_dealer_card() -> void:
	if game_state != GameState.OPPONENT_TURN:
		return
	
	var card = self.draw_card(dealer_hand, dealer_hand_display)
	
	dealer_hand_total.text = "Total: " + str(dealer_hand.sum)
	
	if dealer_hand.has_lost():
		self.dealer_lose()
		return
	
	if "mokepon" in card:
		GameData.cheat_meter += 20.0

func dealer_hold() -> void:
	if game_state != GameState.OPPONENT_TURN:
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
	if game_state in [GameState.MENU, GameState.RETURN_CARDS]:
		return
	game_state = GameState.MENU
	var round_end_menu = ROUND_END_MENU.instantiate()
	$UI.add_child(round_end_menu)
	round_end_menu.init(false)
	self.round_end_menu = round_end_menu
	SignalBus.on_player_loss.emit()

func dealer_lose() -> void:
	if game_state in [GameState.MENU, GameState.RETURN_CARDS]:
		return
	game_state = GameState.MENU
	var round_end_menu = ROUND_END_MENU.instantiate()
	$UI.add_child(round_end_menu)
	round_end_menu.init(true)
	self.round_end_menu = round_end_menu
	SignalBus.on_dealer_loss.emit()

func move_card_from_player_hand_to_deck(card) -> void:
	print("moved from hand to deck")
	player_hand.remove_card(card)
	GameData.deck.add_card(card)

func move_card_from_player_hand_to_inventory(card) -> void:
	if not (card.itemtype == InventoryItem.ItemType.MokeponCard
			or card.itemtype == InventoryItem.ItemType.Card):
		return
	print("moved from hand to inv")
	player_hand.remove_card(card)

func move_card_from_inventory_to_player_hand(card) -> void:
	if not "suit" in card:
		return
	self.add_card_to_hand(player_hand, player_hand_display, card)
	
	player_hand_total.text = "Total: " + str(player_hand.sum)
	
	if player_hand.has_lost():
		self.player_lose()
		return
	if player_hand.sum == 21:
		self.dealer_lose()
		return

func move_card_from_inventory_to_deck(card) -> void:
	if not (card.itemtype == InventoryItem.ItemType.MokeponCard
			or card.itemtype == InventoryItem.ItemType.Card):
		return
	GameData.deck.add_card(card)

func go_to_shop_cleanup() -> void:
	for card in self.player_hand.cards:
		self.move_card_from_player_hand_to_deck(card)

func continue_game() -> void:
	game_state = GameState.RETURN_CARDS
	
	for card in self.dealer_hand.cards:
		GameData.deck.add_card(card)
	for child in dealer_hand_display.get_children():
		child.queue_free()
	
	self.player_hand.hand_empty.connect(
		func():
			print("hand empty")
			while len(GameData.deck.cards) < Deck.MAX_CARDS:
				await get_tree().process_frame
			game_state = GameState.PLAYER_TURN
			self.player_hand = Hand.new()
			self.dealer_hand = Hand.new()
			player_hand_total.text = "Total: " + str(0)
			dealer_hand_total.text = "Total: " + str(0)
			GameData.deck.shuffle()
	)
	self.round_end_menu.queue_free()
	self.player_hand_display.convert_to_draggable(self.player_hand.cards)

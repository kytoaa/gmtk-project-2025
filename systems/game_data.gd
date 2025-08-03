extends Node

var deck: Deck
var inventory: Inventory
var cheat_meter: float

var shop: Shop

var popup_queue: Array[int]
var is_popup_present: bool = false

signal accepted

enum RuleIndex {
	StartTurnBet = 0,
	MinimumBet,
	GummyBearLuck,
	GummyBearLie,
	JackKing,
	JackQueen,
	Aces8s,
	KingRich,
	DrawMokepon,
	RoundEnd,
	Waarizard,
	Tesko,
	Bending,
	DiamondPrickly,
	HeartsBackToBack,
	CheatyMeter
}

var rule_strings: Array[String] = [
	"At the start of every turn, you must drag your bet into the pot.\nWhite=£1, red=£10, blue=£50, green=£100 and black=£500.",
	"A minimum amount of £10 must be bet before playing",
	"Gummy bears give luck when eaten. Right-click to eat", 
	"Rule #2 was a lie. Gummy bears do not give luck when eaten.",
	"If the same Jack appears in two different games, it will grow up and become a King, inheriting the throne.",
	"A Jack may also grow up into a Queen. We don't discriminate in this kingdom.",
	"Aces and 8s don't like each other. Any Ace in a hand with an 8 can only be worth 1 point because 8s detract from the true value of an Ace.",
	"Every King in a player's hand grants them £50 immediately. This is because kings are rich and thus prime victims of taxation.",
	"Drawing a Moképon card will immediately terminate your turn",
	"Upon round termination, all cards in play are put back in the deck, the deck is shuffled, and any money in the pot is illegally melted down and sold as scrap metal, thereby removing it from circulation.",
	"Shiny Waarizard cards are omniscient and govern all other cards. They are immune to taxation.",
	"Players may visit Tesko in between rounds to purchase snacks and gamble in other forms",
	"Cards do not like to be bent because it hurts.",
	"Diamond cards are very prickly characters.",
	"Two hearts drawn back-to-back can use the power of friendship to become something greater than themselves.",
	"The state-of-the-art CHEATY-METER increases every time you exploit a loophole. When it reaches the top, you get kicked out."
] # rules 9 and 15 (one-indexed) have not been implemented yet
var rules: Array[Rule]

func _init() -> void:
	self.deck = Deck.new()
	self.inventory = Inventory.new()
	self.shop = Shop.new()
	cheat_meter = 20.0
	for i in range(len(rule_strings)):
		rules.append(Rule.new(rule_strings[i], i+1))

func init():
	self.inventory.add_item(Chip.new(Chip.Colour.White, 10))
	self.inventory.add_item(Chip.new(Chip.Colour.Red, 5))
	self.inventory.add_item(Chip.new(Chip.Colour.Blue, 3))
	self.inventory.add_item(Chip.new(Chip.Colour.Green, 1))
	
	self.inventory.add_item(GummyBear.new(GummyBear.Colour.Red, 3))

func _ready() -> void:
	var game_state_popup = preload("res://ui/game_state_popup.tscn").instantiate()
	self.add_child(game_state_popup)
	SignalBus.player_turn_start.connect(
		func():
			game_state_popup.get_child(0).get_child(0).get_child(0).text = "player turn!"
			var anim: AnimationPlayer = game_state_popup.get_child(1)
			anim.play("popin")
	)
	SignalBus.opponent_turn_start.connect(
		func():
			game_state_popup.get_child(0).get_child(0).get_child(0).text = "opponent turn!"
			var anim: AnimationPlayer = game_state_popup.get_child(1)
			anim.play("popin")
	)
	SignalBus.return_cards_start.connect(
		func():
			game_state_popup.get_child(0).get_child(0).get_child(0).text = "return cards!"
			var anim: AnimationPlayer = game_state_popup.get_child(1)
			anim.play("popin")
	)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		accepted.emit()
	if !popup_queue.is_empty() and !is_popup_present:
		is_popup_present = true
		var p = GameData.rules[popup_queue.pop_front()].get_popup_node()
		if p != null:
			self.add_child(p)
			p.z_index = 2
			await GameData.accepted
			p.disappear()
			await p.ready_to_free
			p.queue_free()
		is_popup_present = false

func push_popup_queue(rule: RuleIndex) -> void:
	if !GameData.rules[rule].revealed:
		GameData.rules[rule].revealed = true
		popup_queue.append(rule)

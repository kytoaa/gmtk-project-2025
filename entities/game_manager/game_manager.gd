extends Node

@onready var deck: Deck = Deck.new()
@onready var playerhand: Hand = Hand.new()

# below all for debug purposes

var is_popup: bool = false
var ref

var rule: Rule = Rule.new("Aces and 8s don't like each other because 8s detract from the true value of an Ace. Any Ace in a hand with an 8 can only be worth 1 point.", 3)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		if not is_popup:
			ref = rule.get_popup_node()
			if ref == null:
				print("NO")
				return
			add_child(ref)
			#print(ref.header.text)
			is_popup = true
		else:
			ref.disappear()
			await ref.ready_to_free
			remove_child(ref)
			ref = null
			is_popup = false

class_name Loophole
extends Object

var revealed: bool
var text: String
var number: int

func _init(text: String, number: int) -> void:
	self.text = text
	self.number = number
	self.revealed = false

func trigger_reveal() -> void:
	if not self.revealed:
		pass  # Show popup for rule here
	self.revealed = true

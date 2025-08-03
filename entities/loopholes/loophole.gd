class_name Loophole
extends Object

var revealed: bool
var text: String
var number: int

const popup: PackedScene = preload("res://entities/popup.tscn")

func _init(text: String, number: int) -> void:
	self.text = text
	self.number = number
	self.revealed = false

func trigger_reveal() -> void:
	if not self.revealed:
		pass  # Show popup for rule here
	self.revealed = true

func get_popup_node() -> Control:
	var ret: Control = popup.instantiate()
	ret.init("LOOPHOLE DISCOVERED!", self.text)
	return ret

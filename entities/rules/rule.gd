class_name Rule
extends Resource

var revealed: bool
var text: String
var number: int

const popup: PackedScene = preload("res://entities/popup.tscn")

func _init(text: String, number: int) -> void:
	self.text = text
	self.number = number
	self.revealed = false

func get_popup_node() -> Control:
	var ret: Control = popup.instantiate()
	ret.init("RULE " + str(self.number), self.text)
	return ret

class_name Rule
extends Object

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
	ret.get_node("Panel/VBoxContainer/HBoxContainer/PanelMain/Label").text = "RULE " + str(self.number)
	ret.get_node("Panel/VBoxContainer/Text/MarginContainer/Label").text = self.text
	return ret

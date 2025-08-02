extends Control

const CARD = preload("res://entities/card/card.tscn")

func _get_drag_data(at_position: Vector2) -> Variant:
	var card = CARD.instantiate()
	add_child(card)
	remove_child(card) # idk how to call _ready without doing this
	card.init(get_parent().item.type, get_parent().item.suit)
	set_drag_preview(card)
	return self

func _on_mouse_entered() -> void:
	print(self.modulate)
	self.modulate = Color(0.5, 0.5, 0.5)
	
func _on_mouse_exited() -> void:
	self.modulate = Color(1, 1, 1)

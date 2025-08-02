extends Control

const CARD = preload("res://entities/card/card.tscn")

func all_children_recurs(node: Node) -> void:
	print(node.name)
	for N in node.get_children():
		if N.is_class("Control"):
			N.mouse_filter = MOUSE_FILTER_PASS
		all_children_recurs(N)

func add_item(node: Node) -> void:
	self.add_child(node)
	all_children_recurs(self)

func _get_drag_data(at_position: Vector2) -> Variant:
	var card = CARD.instantiate()
	add_child(card)
	remove_child(card) # idk how to call _ready without doing this
	card.init(get_parent().item.type, get_parent().item.suit)
	set_drag_preview(card)
	return [GameData.inventory, get_parent().item]

func _on_mouse_entered() -> void:
	print(self.modulate)
	self.modulate = Color(0.5, 0.5, 0.5)
	
func _on_mouse_exited() -> void:
	self.modulate = Color(1, 1, 1)

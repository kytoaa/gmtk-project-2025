extends VBoxContainer

var item: InventoryItem
var initialised: bool = false

@onready var holder = $ItemHolder
@onready var label = $Label
@onready var mouse_getter = $Node2D

func all_children_recurs(node: Node) -> void:
	for N in node.get_children():
		if N.is_class("Control"):
			N.mouse_filter = MOUSE_FILTER_PASS
		all_children_recurs(N)

func add_item(item: InventoryItem, display: Node) -> void:
	self.item = item
	self.holder.add_child(display)
	self.label.text = "X" + str(self.item.count)
	self.initialised = true
	all_children_recurs(self)

func _process(delta: float) -> void:
	if not initialised:
		return

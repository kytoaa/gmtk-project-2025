extends VBoxContainer

var item: InventoryItem
var initialised: bool = false

@onready var holder = $ItemHolder
@onready var label = $Label

func add_item(item: InventoryItem, display: Node) -> void:
	self.item = item
	self.holder.add_item(display)
	self.label.text = "X" + str(self.item.count)
	self.initialised = true

func _process(delta: float) -> void:
	if not initialised:
		return

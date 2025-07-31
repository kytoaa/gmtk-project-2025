class_name Inventory
extends Resource

var items: Array[InventoryItem]

func should_share_slot(item1: InventoryItem, item2: InventoryItem) -> bool:
	if item1.itemtype != item2.itemtype:
		return false
	
	match item1.itemtype:
		InventoryItem.ItemType.MokeponCard:
			return item1.mokepon == item2.mokepon
		InventoryItem.ItemType.GummyBear, InventoryItem.ItemType.Chip:
			return item1.colour == item2.colour
		InventoryItem.ItemType.Card:
			return item1.type == item2.type and item1.suit == item2.suit
		_:
			return false

func add_item(item: InventoryItem) -> void:
	var search = items.filter(func(it): return should_share_slot(it, item))
	
	if len(search) == 0:
		items.append(item)
	else:
		search[0].count += item.count

func remove_item(item: InventoryItem) -> void:
	var index: int = items.find(
		items.filter(func(it): return should_share_slot(it, item))[0]
		)
	var search = items.filter(func(it): return should_share_slot(it, item))
	
	if len(search) == 0:
		print("Err")
		return
	var newcount = search[0].count - item.count
	if newcount < 0:
		print("Err")
		return
	
	search[0].count = newcount

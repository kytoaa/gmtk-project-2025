class_name Inventory
extends Resource

var items: Array[InventoryItem]
signal updated

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
	
	if item.itemtype == InventoryItem.ItemType.GummyBear:
		if !GameData.rules[1].revealed:
			GameData.push_popup_queue(1)
		elif randf() < 0.1:
			GameData.push_popup_queue(2)
	
	if item.itemtype == InventoryItem.ItemType.MokeponCard and item.mokepon == MokeponCard.Mokepon.Waarizard:
		GameData.push_popup_queue(9)
	self.updated.emit()

func remove_item(item: InventoryItem) -> void:
	var index: int = items.find(
		items.filter(func(it): return should_share_slot(it, item))[0]
	)
	var search = items.filter(func(it): return should_share_slot(it, item))
	
	if len(search) == 0:
		printerr("Item not here to remove")
		return
	var newcount = search[0].count - item.count
	if newcount < 0:
		print("Not enough items to remove")
		return
	elif newcount == 0:
		items.remove_at(items.find(search[0]))
		self.updated.emit()
		return
	
	search[0].count = newcount
	self.updated.emit()

func money(include_other: bool = false) -> int:
	var sum: int = 0
	for item in self.items:
		if item.itemtype == InventoryItem.ItemType.Chip:
			sum += item.colour * item.count
		if include_other and (item.itemtype == InventoryItem.ItemType.Card):
			match item.suit:
				Card.CardSuit.HEARTS, Card.CardSuit.DIAMONDS:
					sum += Chip.Colour.Red * item.count
				Card.CardSuit.SPADES, Card.CardSuit.CLUBS:
					sum += Chip.Colour.Blue * item.count
		if include_other and (item.itemtype == InventoryItem.ItemType.GummyBear) \
		and item.colour in GummyBear.BET_COLOURS:
			sum += item.colour * item.count
	return sum

func take_money(price: int) -> void:
	if self.money() < price:
		printerr("Not enough money in inventory")
	var newmoney: int = self.money() - price
	for i in range(len(items)):
		if items[i].itemtype == InventoryItem.ItemType.Chip:
			items.remove_at(i)
	
	const denominations = [500, 100, 50, 10, 1]
	for i in range(len(denominations)):
		while newmoney >= denominations[i]:
			newmoney -= denominations[i]
			self.add_item(Chip.new(denominations[i], 1))
	
	if newmoney != 0:
		printerr("Still money left to take: ", newmoney)

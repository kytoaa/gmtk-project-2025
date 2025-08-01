class_name Shop
extends Object

enum ShopItem {
	MokeponPack,
	BarihoGummies
}

const prices: Dictionary = {
	ShopItem.MokeponPack: 3,
	ShopItem.BarihoGummies: 1
}

const quantities: Dictionary = {
	ShopItem.MokeponPack: 1,
	ShopItem.BarihoGummies: 5
}

func _init() -> void:
	pass

func purchase(item: ShopItem, inventory: Inventory) -> void:
	if inventory.money() < prices[item]:
		return
	
	InventoryItem.ItemType.keys()
	
	inventory.take_money(prices[item])
	
	match item:
		ShopItem.MokeponPack:
			for i in range(quantities[item]):
				var to_add: MokeponCard.Mokepon = MokeponCard.Mokepon.values()[randi() % MokeponCard.Mokepon.keys().size()]
				inventory.add_item(MokeponCard.new(to_add))
		ShopItem.BarihoGummies:
			print(str(quantities[item]))
			for i in range(quantities[item]):
				var to_add: GummyBear.Colour = GummyBear.Colour.values()[randi() % GummyBear.Colour.keys().size()]
				inventory.add_item(GummyBear.new(to_add))

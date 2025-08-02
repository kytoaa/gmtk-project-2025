extends Control

@onready var mokepon_card = $SegmentSplitter/Tesko/Shelf/Items/VBoxContainer/TextureRect
@onready var bariho_node = $SegmentSplitter/Tesko/Shelf/Items/VBoxContainer2/TextureRect2

@onready var mokepon_pricetag = $SegmentSplitter/Tesko/Shelf/Items/VBoxContainer/Label
@onready var bariho_pricetag = $SegmentSplitter/Tesko/Shelf/Items/VBoxContainer2/Label

@onready var description = %Description

var mouseover_mokepon: bool = false
var mouseover_bariho: bool = false

var show_intro_text: bool = true
var rand_dialogue_chosen: bool = false
var cant_pay_for: bool = false

const dialogue_options: Array[String] = [
	"Say, when did you last shower?\nOh wait. You're a gamer.",
	"You ever feel like life is kinda futile sometimes?",
	"BEHIND YOU!\n...just kidding.",
	"I hate this job. People like you have it [i]waaaay[/i] too easy...",
	"These jerks don't pay me enough to keep working here.",
	"Take your time. They pay me by the hour."
]

func _ready() -> void:
	GameData.push_popup_queue(10)
	mokepon_pricetag.text = "£" + str(GameData.shop.prices[Shop.ShopItem.MokeponPack])
	bariho_pricetag.text = "£" + str(GameData.shop.prices[Shop.ShopItem.BarihoGummies])
	%Inventory.init()

func _process(_delta: float) -> void:
	if cant_pay_for:
		description.text = "[b]TESKO SHOPKEEPER[/b]\nHey, you're too poor to afford that!"
		return
	
	if mouseover_bariho and !cant_pay_for:
		description.text = "[b]BARIHO GUMMIES: 5 qty[/b]\nKids and grownups hate it so, the dismal world of BARIHO!"
		show_intro_text = false
		rand_dialogue_chosen = false
	elif mouseover_mokepon and !cant_pay_for:
		description.text = "[b]MOKÉPON CARD: 1 qty[/b]\nGotta catch 'em all! Or not. Up to you."
		show_intro_text = false
		rand_dialogue_chosen = false
	elif show_intro_text:
		description.text = "[b]TESKO SHOPKEEPER[/b]\nWanna buy something?"
		rand_dialogue_chosen = true
	elif !rand_dialogue_chosen:
		description.text = "[b]TESKO SHOPKEEPER[/b]\n" + dialogue_options.pick_random()
		rand_dialogue_chosen = true


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		buy_item()

func buy_item() -> void:
	var item
	if mouseover_bariho:
		item = Shop.ShopItem.BarihoGummies
	elif mouseover_mokepon:
		item = Shop.ShopItem.MokeponPack
	else:
		return
	
	if GameData.shop.prices[item] > GameData.inventory.money():
		cant_pay_for = true
		print("H")
	GameData.shop.purchase(item, GameData.inventory)


func _on_texture_rect_mouse_entered() -> void:
	mouseover_mokepon = true

func _on_texture_rect_mouse_exited() -> void:
	mouseover_mokepon = false
	cant_pay_for = false

func _on_texture_rect_2_mouse_entered() -> void:
	mouseover_bariho = true

func _on_texture_rect_2_mouse_exited() -> void:
	mouseover_bariho = false
	cant_pay_for = false

func back_to_game() -> void:
	NavigationManager.go_to_scene(SceneList.game())

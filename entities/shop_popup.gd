extends Control

signal ready_to_free

@onready var texture = $Panel/MarginContainer/VBoxContainer/Control/TextureRect
@onready var label = $Panel/MarginContainer/VBoxContainer/Label
@onready var anim = $AnimationPlayer

const WAARIZARD = preload("res://entities/mokepon/waarizard.png")
const MATSUNE = preload("res://entities/mokepon/matsune_hiku.png")
const PIGGLYJUFF = preload("res://entities/mokepon/pigglyjuff.png")

const BARIHO = preload("res://systems/shop/gummybear.png")

var txtr
var lbl

func init(item: InventoryItem) -> void:
	match item.itemtype:
		InventoryItem.ItemType.MokeponCard:
			match item.mokepon:
				MokeponCard.Mokepon.Waarizard:
					txtr = WAARIZARD
					lbl = "You got shiny Waarizard!"
				MokeponCard.Mokepon.MatsuneHiku:
					txtr = MATSUNE
					lbl = "You got Matsune Hiku!"
				MokeponCard.Mokepon.Pigglyjuff:
					txtr = PIGGLYJUFF
					lbl = "You got Pigglyjuff!"
				MokeponCard.Mokepon.MoroGajima:
					lbl = "You got Moro Gajima!"
		InventoryItem.ItemType.GummyBear:
			txtr = BARIHO
			lbl = "You got 5 Bariho Gummies!"

func _ready() -> void:
	texture.texture = txtr
	label.text = lbl
	anim.play("popin")

func disappear() -> void:
	anim.play("popout")
	await anim.animation_finished
	ready_to_free.emit()

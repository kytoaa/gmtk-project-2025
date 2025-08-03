extends Control

signal ready_to_free

@onready var texture = $Panel/MarginContainer/VBoxContainer/Control/TextureRect
@onready var label = $Panel/MarginContainer/VBoxContainer/Label
@onready var move = $Panel/MarginContainer/VBoxContainer/Label3
@onready var anim = $AnimationPlayer

const WAARIZARD = preload("res://entities/mokepon/waarizard.png")
const MATSUNE = preload("res://entities/mokepon/matsune_hiku.png")
const PIGGLYJUFF = preload("res://entities/mokepon/pigglyjuff.png")

const BARIHO = preload("res://systems/shop/gummybear.png")

var txtr
var lbl
var mv

func init(item: InventoryItem) -> void:
	match item.itemtype:
		InventoryItem.ItemType.MokeponCard:
			match item.mokepon:
				MokeponCard.Mokepon.Waarizard:
					txtr = WAARIZARD
					lbl = "You got shiny Waarizard!"
					mv = "Not Fly"
				MokeponCard.Mokepon.MatsuneHiku:
					txtr = MATSUNE
					lbl = "You got Matsune Hiku!"
					mv = "Hiku Hiku Beam"
				MokeponCard.Mokepon.Pigglyjuff:
					txtr = PIGGLYJUFF
					lbl = "You got Pigglyjuff!"
					mv = "Marker"
				MokeponCard.Mokepon.MoroGajima:
					lbl = "You got Moro Gajima!"
					mv = "Breakdance"
		InventoryItem.ItemType.GummyBear:
			txtr = BARIHO
			lbl = "You got 5 Bariho Gummies!"
			mv = "Edible"

func _ready() -> void:
	texture.texture = txtr
	label.text = lbl
	move.text = "Special Move: " + mv
	anim.play("popin")

func disappear() -> void:
	anim.play("popout")
	await anim.animation_finished
	ready_to_free.emit()

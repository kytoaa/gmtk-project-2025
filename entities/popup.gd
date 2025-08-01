extends Control

@onready var anim = $Panel/AnimationPlayer
@onready var panel = $Panel

@onready var header = $Panel/VBoxContainer/HBoxContainer/PanelMain/Label
@onready var body = $Panel/VBoxContainer/Text/MarginContainer/Label

signal ready_to_free

func _ready() -> void:
	panel.visible = false
	anim.play("popin")

func disappear() -> void:
	anim.play("popout")
	await anim.animation_finished
	ready_to_free.emit()

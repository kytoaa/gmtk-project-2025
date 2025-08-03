extends Control

@onready var anim = $AnimationPlayer

@onready var header = $VBoxContainer/PanelMain/MarginContainer/Label
@onready var body = $VBoxContainer/Text/MarginContainer/Label

var header_text := ""
var body_text := ""

signal ready_to_free

func init(header: String, body: String) -> void:
	self.header_text = header
	self.body_text = body

func _ready() -> void:
	$VBoxContainer.set_anchors_preset(Control.PRESET_RIGHT_WIDE)
	anim.play("popout")
	self.header.text = self.header_text
	self.body.text = self.body_text

func disappear() -> void:
	anim.play("popin")
	await anim.animation_finished
	ready_to_free.emit()

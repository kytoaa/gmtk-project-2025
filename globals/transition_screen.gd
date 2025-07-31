extends CanvasLayer


@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer


# verbatim
const FADE_TO_BLACK = "fade_to_black"
const FADE_TO_NORMAL = "fade_to_normal"

func _ready():
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
	if anim_name == FADE_TO_BLACK:
		SignalBus.on_scene_transition_fade_to_black.emit()
		animation_player.play(FADE_TO_NORMAL)
	elif anim_name == FADE_TO_NORMAL:
		color_rect.visible = false
		SignalBus.on_scene_transition_finished.emit()
		color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func play_transition():
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	color_rect.visible = true
	animation_player.play(FADE_TO_BLACK)
	

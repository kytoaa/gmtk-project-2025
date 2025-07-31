extends CanvasLayer


@onready var color_rect = $ColorRect
@onready var animation_player = $AnimationPlayer


# verbatim
const FADE_TO_BLACK = "fade_to_black"
const FADE_TO_NORMAL = "fade_to_normal"

func _ready():
	color_rect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)

func _on_animation_finished(anim_name):
	if anim_name == FADE_TO_BLACK:
		animation_player.play(FADE_TO_NORMAL)
		on_transition_finished.emit()
	elif anim_name == FADE_TO_NORMAL:
		color_rect.visible = false
	
func play_transition():
	color_rect.visible = true
	animation_player.play(FADE_TO_BLACK)
	

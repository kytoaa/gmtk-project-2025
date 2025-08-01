extends Button

@onready var audio_player = $SfxPlayer

func on_button_pressed():
	audio_player.playing = !audio_player.playing

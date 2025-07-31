extends Control

const SETTINGS_SCENE := preload("res://ui/settings.tscn")

func on_start_game_pressed():
	pass

func on_settings_pressed():
	NavigationManager.go_to_scene(SETTINGS_SCENE)
	
func on_exit_pressed():
	get_tree().quit()

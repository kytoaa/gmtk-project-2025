extends Control

func on_start_game_pressed():
	pass

func on_settings_pressed():
	NavigationManager.go_to_scene(preload("res://UI/settings.tscn"))
	
func on_exit_pressed():
	get_tree().quit()

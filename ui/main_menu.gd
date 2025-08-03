extends Control

func on_start_game_pressed():
	GameData.init()
	NavigationManager.go_to_scene(SceneList.tutorial())

func on_settings_pressed():
	NavigationManager.go_to_scene(SceneList.settings_menu())
	
func on_exit_pressed():
	get_tree().quit()

func on_credits_pressed() -> void:
	NavigationManager.go_to_scene(SceneList.credits())

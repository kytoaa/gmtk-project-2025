extends Control

func on_back_pressed():
	NavigationManager.go_to_scene(SceneList.main_menu())

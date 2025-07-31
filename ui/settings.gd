extends Control

const MAIN_MENU_SCENE := preload("res://ui/main_menu.tscn")
func on_back_pressed():
	if MAIN_MENU_SCENE.get_state().get_node_count() == 0:
		print("oh noooo")
	NavigationManager.go_to_scene(MAIN_MENU_SCENE)

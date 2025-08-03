extends Control

func _on_button_pressed() -> void:
	NavigationManager.go_to_scene(SceneList.main_menu())

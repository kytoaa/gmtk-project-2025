extends Control

func init(out_of_money: bool) -> void:
	if out_of_money:
		$PanelContainer/MarginContainer/VBoxContainer/Label2.text = "out of money!"
	else:
		$PanelContainer/MarginContainer/VBoxContainer/Label2.text = "you got kicked out!"

func _on_button_pressed() -> void:
	NavigationManager.go_to_scene(SceneList.main_menu())

extends Control

func init(reason: GameData.LossReason) -> void:
	match reason:
		GameData.LossReason.NO_MONEY:
			$PanelContainer/MarginContainer/VBoxContainer/Label2.text = "out of money!"
		GameData.LossReason.CHEATING:
			$PanelContainer/MarginContainer/VBoxContainer/Label2.text = "you got kicked out!"

func _on_button_pressed() -> void:
	NavigationManager.go_to_scene(SceneList.main_menu())

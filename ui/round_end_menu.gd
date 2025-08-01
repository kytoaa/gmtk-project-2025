extends Control

func init(win: bool) -> void:
	if win:
		$PanelContainer/MarginContainer/VBoxContainer/Label2.text = "Win!"
	else:
		$PanelContainer/MarginContainer/VBoxContainer/Label2.text = "Loss"

func _on_shop_button_pressed() -> void:
	SignalBus.go_to_shop.emit()

func _on_continue_button_pressed() -> void:
	SignalBus.continue_game.emit()

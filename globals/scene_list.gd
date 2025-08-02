class_name SceneList
extends Resource

static func main_menu() -> PackedScene:
	return preload("res://ui/main_menu.tscn")

static func settings_menu() -> PackedScene:
	return preload("res://ui/settings.tscn")

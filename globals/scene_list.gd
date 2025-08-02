class_name SceneList
extends Resource

static func main_menu() -> PackedScene:
	return preload("res://ui/main_menu.tscn")

static func settings_menu() -> PackedScene:
	return preload("res://ui/settings.tscn")

static func game() -> PackedScene:
	return preload("res://scenes/game_scene.tscn")

static func shop() -> PackedScene:
	return preload("res://systems/shop/shop.tscn")

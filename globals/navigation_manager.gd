extends Node


var scenes: Array[Node] = []
const MAIN_MENU_SCENE := preload("res://ui/main_menu.tscn")
const SETTINGS_SCENE := preload("res://ui/settings.tscn")

func _ready() -> void:
	self.call_deferred("game_start")

func game_start() -> void:
	go_to_scene(MAIN_MENU_SCENE)

func go_to_scene(scene: PackedScene):
	TransitionScreen.play_transition()
	
	await SignalBus.on_scene_transition_fade_to_black
	
	
	if scene == null:
		print("Scene is null")
	elif scene.get_state().get_node_count() == 0:
		print("Scene is empty!")
	else:
		print("Scene is valid!")
		
	for loaded_scene in scenes:
		
		loaded_scene.queue_free()
		
	scenes.clear()
	var current_scene = scene.instantiate()
	scenes.append(current_scene)
	get_tree().root.add_child(current_scene)
	print(SETTINGS_SCENE.get_state().get_node_count())

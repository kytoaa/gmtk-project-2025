extends Node


var scenes: Array[Node] = []


func _ready() -> void:
	self.call_deferred("game_start")

func game_start() -> void:
	go_to_scene(preload("res://ui/main_menu.tscn"))


func go_to_scene(scene: PackedScene):
	TransitionScreen.play_transition()
	
	await SignalBus.on_scene_transition_fade_to_black
	
	for loaded_scene in scenes:
		loaded_scene.queue_free()
	
	var current_scene = scene.instantiate()
	scenes.append(current_scene)
	get_tree().root.add_child(current_scene)
	
	

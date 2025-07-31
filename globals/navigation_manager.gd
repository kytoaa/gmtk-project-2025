extends Node


var scenes: Array[Node] = []

func _ready() -> void:
	self.call_deferred("game_start")

func game_start() -> void:
	go_to_scene(SceneList.main_menu())

func go_to_scene(scene: PackedScene):
	TransitionScreen.play_transition()
	
	await SignalBus.on_scene_transition_fade_to_black
	
	print(scene.get_state())
	
	for loaded_scene in scenes:
		loaded_scene.queue_free()
		
	scenes.clear()
	var current_scene := scene.instantiate()
	scenes.append(current_scene)
	self.add_child(current_scene)

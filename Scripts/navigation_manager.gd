extends Node


func go_to_scene(scene: PackedScene):
	TransitionScreen.play_transition()
	await TransitionScreen.on_transition_finished
	scene.instantiate()
	

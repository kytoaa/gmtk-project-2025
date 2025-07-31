extends Node



func go_to_scene(scene: PackedScene):
	TransitionScreen.play_transition()
	
	await TransitionScreen.on_scene_transition_fade_to_black
	for child in self.get_children():
		child.queue_free()
	
	var current_scene = scene.instantiate()
	self.add_child(current_scene)
	
	

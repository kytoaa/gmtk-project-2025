extends AudioStreamPlayer

@export var initial_value: float = -30.0
@export var tween_time: float = 5

func _ready() -> void:
	self.volume_db = initial_value
	get_tree().create_tween().tween_property(self, "volume_db", 0.0, tween_time)

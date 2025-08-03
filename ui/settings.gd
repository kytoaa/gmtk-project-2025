extends Control

@onready var master_index = AudioServer.get_bus_index("Master")
@onready var music_index = AudioServer.get_bus_index("Music")
@onready var sfx_index = AudioServer.get_bus_index("Sfx")
@onready var color_rect = $ColorRect

@onready var master_volume_slider = $MarginContainer/VBoxContainer/GridContainer2/MasterVolume
@onready var sfx_volume_slider = $MarginContainer/VBoxContainer/GridContainer2/SfxVolume
@onready var music_volume_slider = $MarginContainer/VBoxContainer/GridContainer2/MusicVolume

var master_volume: float
var music_volume: float
var sfx_volume: float

func _ready():
	color_rect.mouse_filter = Control.MOUSE_FILTER_STOP
	master_volume = db_to_linear(AudioServer.get_bus_volume_db(master_index))
	music_volume = db_to_linear(AudioServer.get_bus_volume_db(music_index))
	sfx_volume = db_to_linear(AudioServer.get_bus_volume_db(sfx_index))
	master_volume_slider.value = master_volume 
	music_volume_slider.value = music_volume
	sfx_volume_slider.value = sfx_volume 
	
func on_back_pressed():
	NavigationManager.go_to_scene(SceneList.main_menu())

func on_master_volume_changed(value: float):
	AudioServer.set_bus_volume_db(master_index, linear_to_db(value))
	
func on_music_volume_changed(value: float):
	AudioServer.set_bus_volume_db(music_index, linear_to_db(value))
	
func on_sfx_volume_changed(value: float):
	AudioServer.set_bus_volume_db(sfx_index, linear_to_db(value))


func _on_check_box_toggled(toggled_on: bool) -> void:
	GameData.show_popups = toggled_on
	$MarginContainer/VBoxContainer/HBoxContainer/CheckBox/Label.visible = !toggled_on

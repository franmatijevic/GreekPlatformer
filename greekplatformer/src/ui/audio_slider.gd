extends Control

@onready var audio_bus: Label = $HBoxContainer/AudioBus as Label
@onready var audio_value: Label = $HBoxContainer/AudioValue as Label
@onready var h_slider: HSlider = $HBoxContainer/HSlider as HSlider


@export_enum("Master", "SFX", "Music") var bus_name : String

var index : int = 0

func _ready() -> void:
	h_slider.value_changed.connect(on_value_changed)
	get_audio_bus_index()
	load_data()
	set_audio_bus_label_text()
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(index))
	set_audio_value_label_text()
	
func load_data():
	var audio_settings = ConfigFileHandler.load_audio_settings()
	match bus_name:
		"Master":
			on_value_changed(min(audio_settings.master_volume, 1.0))
		"SFX":
			on_value_changed(min(audio_settings.sfx_volume, 1.0))
		"Music":
			on_value_changed(min(audio_settings.music_volume, 1.0))
	
func set_audio_bus_label_text():
	audio_bus.text = str(bus_name) + " Volume"
	
func set_audio_value_label_text():
	audio_value.text = str(h_slider.value * 100) + "%"

func get_audio_bus_index():
	index = AudioServer.get_bus_index(bus_name)

func on_value_changed(value : float):
	AudioServer.set_bus_volume_db(index, linear_to_db(value))
	set_audio_value_label_text()
	
	match index:
		0:
			ConfigFileHandler.save_audio_settings("master_volume", value)
		1:
			ConfigFileHandler.save_audio_settings("sfx_volume", value)
		2:
			ConfigFileHandler.save_audio_settings("music_volume", value)

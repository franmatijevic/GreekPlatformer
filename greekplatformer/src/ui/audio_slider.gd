extends Control

@onready var audio_bus: Label = $HBoxContainer/AudioBus as Label
@onready var audio_value: Label = $HBoxContainer/AudioValue as Label
@onready var h_slider: HSlider = $HBoxContainer/HSlider as HSlider


@export_enum("Master", "SFX", "Music") var bus_name : String

var index : int = 0

func _ready() -> void:
	h_slider.value_changed.connect(on_value_changed)
	get_audio_bus_index()
	set_audio_bus_label_text()
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(index))
	set_audio_value_label_text()
	
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
			SignalBus.emit_on_master_volume(value)
		1:
			SignalBus.emit_on_sfx_volume(value)
		2:
			SignalBus.emit_on_music_volume(value)

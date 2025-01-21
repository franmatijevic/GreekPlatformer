extends Node2D

func _ready() -> void:
	var t = create_tween()
	t.set_parallel(false)
	t.tween_property($GodotSplash, "modulate:a", 1, 1)
	t.tween_interval(2)
	t.tween_callback(mainMenu)

func mainMenu():
	SceneLoader.load_more_level("res://src/ui/main_menu.tscn")

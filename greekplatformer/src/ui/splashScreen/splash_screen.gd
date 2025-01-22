extends Node2D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	var t = create_tween()
	t.set_parallel(true)
	#t.tween_property($GodotSplash, "modulate:a", 1, 1)
	t.tween_property($BeRemoved, "modulate:a", 0, 1)
	t.chain().tween_interval(2)
	t.chain().tween_callback(mainMenu)

func mainMenu():
	SceneLoader.load_more_level("res://src/ui/main_menu.tscn")

extends Node2D

var new_game = "res://src/levels/test_level.tscn"

func open_menu(option_name:String):
	for i in get_node("options").get_children():
		i.set_visible(false)
	
	get_node("options").get_node(option_name).set_visible(true)
	get_node("options").get_node(option_name).visible=true

func _on_new_game_pressed() -> void:
	SceneLoader.load_scene(new_game)

func _on_continue_pressed() -> void: # continue the saved file
	pass # Replace with function body.

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_play_pressed() -> void:
	open_menu("playOptions")

func _on_settings_pressed() -> void:
	open_menu("settings")
	
func _on_back_to_main_pressed() -> void:
	open_menu("main")

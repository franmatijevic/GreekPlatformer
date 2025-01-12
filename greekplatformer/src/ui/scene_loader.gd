extends Node

@onready var loading_screen = preload("res://src/ui/loading_screen.tscn")
@onready var black_loading = preload("res://src/ui/black_loading_screen.tscn")

var scene_to_load_path
var loading_screen_instance
var loading = false

var minTime:float=1

var room_name

func load_scene(path):
	var current_scene = get_tree().current_scene
	
	loading_screen_instance = loading_screen.instantiate()
	get_tree().root.call_deferred("add_child", loading_screen_instance)
	
	if ResourceLoader.has_cached(path):
		ResourceLoader.load_threaded_get(path)
	else:
		ResourceLoader.load_threaded_request(path)
	
	current_scene.queue_free()
	loading = true
	minTime = 1
	scene_to_load_path = path

func load_more_level(path):
	var current_scene = get_tree().current_scene
	
	
	loading_screen_instance = black_loading.instantiate()
	get_tree().root.call_deferred("add_child", loading_screen_instance)
	
	if ResourceLoader.has_cached(path):
		ResourceLoader.load_threaded_get(path)
	else:
		ResourceLoader.load_threaded_request(path)
	
	current_scene.queue_free()
	loading = true
	minTime = 0
	scene_to_load_path = path


func continue_from_save(chapter_path, name_of_the_room):
	load_scene(chapter_path)
	room_name=name_of_the_room

func _process(delta: float) -> void:
	if !loading:
		if room_name!=null:
			var level
			for i in get_node("/root").get_children():
				if i is Level:
					level=i
			if level.has_node(room_name):
				level.current_room=level.get_node(room_name)
				level.get_node("Player").global_position=level.current_room.get_node("Respawn").global_position
			room_name=null
		return
	if minTime>0:
		minTime-=delta
		return
	
	if ResourceLoader.THREAD_LOAD_LOADED:
		var level = ResourceLoader.load_threaded_get(scene_to_load_path)
		get_tree().change_scene_to_packed(level)
		loading_screen_instance.queue_free()
		loading = false

extends Node2D

@export var current_room:Area2D
@onready var canvas_layer_pause: CanvasLayer = $CanvasLayerPause

@warning_ignore("unused_signal")
signal toggle_paused(paused: bool)


var current_room_file
var new_next_level
var prev_room

var current_room_position
var holding_object:Throwable=null

var game_paused: bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_paused", game_paused)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart"):
		if(get_node("Camera").block==false):
			restart()
	if Input.is_action_just_pressed("pause"):
		if(get_node("Camera").block==false):
			game_paused = !game_paused

func restart():
	if(current_room != new_next_level):
		return
	get_node("BlackScreen/Control").modulate.a=1
	get_node("Player").global_position = current_room.get_node("Respawn").global_position
	
	current_room.process_mode=Node.PROCESS_MODE_DISABLED
	if(new_next_level != current_room):
		new_next_level = null
		#new_next_level.process_mode=Node.PROCESS_MODE_DISABLED
	
	if(holding_object):
		holding_object.queue_free()
	holding_object=null
	get_node("Player").holding_object=null
	
	
	current_room.queue_free()
	current_room = current_room_file.instantiate()
	add_child(current_room)
	current_room.global_position = current_room_position
	
	get_node("Player").set_state("MoveState")
	create_tween().tween_property(get_node("BlackScreen/Control"), "modulate:a", 0, 0.6)

func _ready() -> void:
	create_tween().tween_property(get_node("BlackScreen/Control"), "modulate:a", 0, 0.6)
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	current_room_file = load(current_room.scene_file_path)
	current_room_position= current_room.global_position

func next_level():
	prev_room = current_room
	current_room=new_next_level
	holding_object=get_node("Player").holding_object
	
	current_room_position= current_room.global_position
	
	current_room_file = load(current_room.scene_file_path)
	
	get_node("Camera").set_state("RoomTransition")


func _on_room_transition_end_transition() -> void:
	if prev_room == null:
		return
	
	#prev_room.get_node("Objects").queue_free()
	for i in prev_room.get_node("Objects").get_children(): #mora pojedinacan inace obrise i holding_object
		if(get_node("Player").holding_object != i):
			i.call_deferred("queue_free")

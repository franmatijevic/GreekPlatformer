extends Node2D

@export var current_room:Area2D
@onready var canvas_layer_pause: CanvasLayer = $CanvasLayerPause

@warning_ignore("unused_signal")
signal toggle_paused(paused: bool)
var game_paused: bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_paused", game_paused)

var new_next_level
var prev_room

var original_object_positions=[]

var holding_object:Throwable=null

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart"):
		if(get_node("Camera").block==false):
			restart()
	if Input.is_action_pressed("pause"):
		if(get_node("Camera").block==false):
			game_paused = !game_paused

func restart():
	get_node("BlackScreen/Control").modulate.a=1
	create_tween().tween_property(get_node("BlackScreen/Control"), "modulate:a", 0, 0.6)
	get_node("Player").global_position = current_room.get_node("Respawn").global_position
	
	if(holding_object):
		holding_object.queue_free()
	holding_object=null
	get_node("Player").holding_object=null
	
	#for i in original_object_positions:
	#	pass

func _ready() -> void:
	create_tween().tween_property(get_node("BlackScreen/Control"), "modulate:a", 0, 0.6)
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func next_level():
	prev_room = current_room
	current_room=new_next_level
	holding_object=get_node("Player").holding_object
	
	#original_object_positions.clear()
	#for i in current_room.get_node("Objects").get_children():
	#	original_object_positions.
	
	get_node("Camera").set_state("RoomTransition")


func _on_room_transition_end_transition() -> void:
	if prev_room == null:
		return
	
	for i in prev_room.get_node("Objects").get_children():
		if(get_node("Player").holding_object != i):
			i.call_deferred("queue_free")

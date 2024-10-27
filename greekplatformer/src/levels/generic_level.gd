extends Node2D

#PAUSE SECTION
var paused: bool = false

@export var current_room:Area2D
@onready var canvas_layer_pause: CanvasLayer = $CanvasLayerPause


var new_next_level
var prev_room

var original_object_positions=[]

var holding_object:Throwable=null

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart"):
		if(get_node("Camera").block==false):
			restart()
	#PAUSE SECTION
	if Input.is_action_pressed("pause"):
		pauseMenu()
		

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
			
			
#PAUSE SECTION

func pauseMenu():
	if paused:
		canvas_layer_pause.hide()
		get_tree().paused = false
	else:
		canvas_layer_pause.show()
		get_tree().paused = true
	paused = !paused

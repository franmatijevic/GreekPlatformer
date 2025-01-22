extends Node2D

class_name Level

@export var ChapterName:String
@export var current_room:Area2D
@onready var canvas_layer_pause: CanvasLayer = $CanvasLayerPause
@onready var dialogue_player: Node2D = $DialoguePlayer

@onready var pause_menu: Control = $CanvasLayerPause/PauseMenu/Panel/SettingsPauseMenu

@export var lineLength:float=650

@warning_ignore("unused_signal")
signal toggle_paused(paused: bool)

var cnt_spawn_skip_level = 0

var current_room_file
var new_next_level
var prev_room

var respawnLocation
var current_room_position
var holding_object:Throwable=null

var interactWithArtefact = false

var game_paused: bool = false:
	get:
		return game_paused
	set(value):
		game_paused = value
		get_tree().paused = game_paused
		emit_signal("toggle_paused", game_paused)

@export var background:Node2D

func _process(delta: float) -> void:
	if background:
		background.global_position.y = $Camera/Camera2D.get_screen_center_position().y
		


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart"):
		if(get_node("Camera").block==false and !get_node("Player").dead and !game_paused and (!dialogue_player or !dialogue_player.inProgress)):
			restart()
			game_paused = false
		elif (game_paused || (!dialogue_player or !dialogue_player.inProgress)):
			pass
	if Input.is_action_just_pressed("pause"):
		if (game_paused && pause_menu.visible):
			pass
		elif (interactWithArtefact):
			get_tree().paused = false
			interactWithArtefact = false
		elif(get_node("Camera").block==false) and (!dialogue_player or !dialogue_player.inProgress):
			game_paused = !game_paused
	#if Input.is_action_just_pressed("ui_accept"):
	#	skip()

func restart():
	teleport(current_room.get_node("Respawn"))

func skip():
	teleport(current_room.get_node("Skip"))

func teleport(spot):
	if(current_room != new_next_level):
		return
	get_node("BlackScreen/Control").modulate.a=1
	#get_node("Player").velocity = Vector2.ZERO
	get_node("Player").restart()
	get_node("Player").global_position = spot.global_position#current_room.get_node("Respawn").global_position
	
	current_room.process_mode=Node.PROCESS_MODE_DISABLED
	if(new_next_level != current_room):
		new_next_level = null
		#new_next_level.process_mode=Node.PROCESS_MODE_DISABLED
	
	if(holding_object):
		holding_object.queue_free()
	holding_object=null
	get_node("Player").holding_object=null
	get_node("Player").flip_player(true)
	get_node("Player").starting()
	
	#respawnLocation
	current_room.queue_free()
	current_room = current_room_file.instantiate()
	add_child(current_room)
	current_room.global_position = current_room_position
	current_room.get_node("Respawn").global_position=respawnLocation
	
	get_node("Camera").global_position = spot.global_position#current_room.get_node("Respawn").global_position
	get_node("Camera/Camera2D").reset_smoothing()
	get_node("Camera/Camera2D").force_update_scroll()
	get_node("Camera").set_state("FollowPlayer")
	
	$Timer.start(0.1)
	get_node("Player").set_state("MoveState")
	get_node("Player").visible=true
	create_tween().tween_property(get_node("BlackScreen/Control"), "modulate:a", 0, 0.6)

func _ready() -> void:
	
	get_node("BlackScreen/Text/Line2D").points.set(0, Vector2(-lineLength,0))
	get_node("BlackScreen/Text/Line2D").points.set(1, Vector2(lineLength,0))
	
	SignalBus.on_interacted_artefact.connect(on_interacted_artefact)
	SignalBus.on_death.connect(show_skip_level)
	get_node("BlackScreen/Text/Label").text=ChapterName
	var t = create_tween()
	t.tween_property(get_node("BlackScreen/Text"), "modulate:a", 1, 1)
	t.tween_interval(0.3)
	t.set_parallel()
	t.tween_property(get_node("BlackScreen/Control"), "modulate:a", 0, 1.75)#0.6)
	t.tween_property(get_node("BlackScreen/Text"), "modulate:a", 0, 2.25)#0.6)
	
	
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	current_room_file = load(current_room.scene_file_path)
	current_room_position= current_room.global_position
	respawnLocation=current_room.get_node("Respawn").global_position
	
	room_changed(get_tree().current_scene.scene_file_path, current_room.to_string().split(":")[0])
	
	current_room.pause_all_objects(false)

func next_level():
	prev_room = current_room
	AudioController.stop_door_opening()
	
	#for i in current_room.get_node("Objects").get_children():
	#	if !(i is Throwable):
	#		i.queue_free()
	#	elif i != get_node("Player").holding_object:
	#		i.queue_free()
	
	current_room=new_next_level
	holding_object=get_node("Player").holding_object
	
	respawnLocation=current_room.get_node("Respawn").global_position
	
	current_room_position= current_room.global_position
	
	current_room_file = load(current_room.scene_file_path)
	
	room_changed(get_tree().current_scene.scene_file_path, current_room.to_string().split(":")[0])
	hide_skip_level()
	
	get_node("Camera").set_state("RoomTransition")

##Camera - amount je izmedu 0 do 1, decayValue je brzina nestajanja shakea
func camShake(amount:float):#dosta kratki shake
	$Camera.add_trauma(amount)

func longCamShake(amount:float, decayValue:float):#shake s zeljenim trajanjem
	$Camera.add_long_trauma(amount, decayValue)

func setCamShake(amount:float):#kad se ne zna koliko ce trajati shake, moze se pozivati svaki frame pa kad se prestane pozivat onda stane dosta brzo
	$Camera.set_trauma(amount)

func _on_room_transition_end_transition() -> void:
	if prev_room == null:
		return
	if prev_room == current_room:
		return
	
	#prev_room.get_node("Objects").queue_free()
	#prev_room.call_deferred("queue_free")
	
	for i in prev_room.get_node("Objects").get_children(): #mora pojedinacan inace obrise i holding_object
		if(get_node("Player").holding_object != i):
			pass
			i.call_deferred("queue_free")

func _on_timer_timeout() -> void:
	current_room.pause_all_objects(false)

func room_changed(path: String, room : String):
	SignalBus.emit_on_changed_room(path, room)

func on_interacted_artefact():
	interactWithArtefact = true
	get_tree().paused = true

func show_skip_level():
	cnt_spawn_skip_level = cnt_spawn_skip_level + 1
	
	if (cnt_spawn_skip_level >= 7):
		SignalBus.emit_show_skip_level()

func hide_skip_level():
	cnt_spawn_skip_level = 0
	SignalBus.emit_hide_skip_level()

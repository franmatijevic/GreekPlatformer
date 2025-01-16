extends State

class_name ZeusThunder

@export var hand1:Node2D
@export var hand2:Node2D

@export var time:float=1

var move

#@onready var camera =source().get_parent().get_parent().get_node("Camera/Camera2D")

var camera

var t=0


func _ready() -> void:
	camera = hand1.camera

func enter():
	t=0
	#move=camera.get_screen_center_position().y - DisplayServer.screen_get_size().y/2
	
	#camera = hand1.camera
	
	var t=create_tween()
	t.tween_interval(1)
	t.tween_callback(activate_hands)

func activate_hands():
	if hand1:
		hand1.state=1
		hand1.t=5
	if hand2:
		hand2.state=1
		hand2.t=5

func update_physics_process(delta:float):
	if t>time:
		player().next_attack()
		#player().block=true
	t=t+delta
	
	var target = camera.get_screen_center_position().y - DisplayServer.screen_get_size().y/2 - 1000
	player().global_position.y=move_toward(player().global_position.y, target, 500*delta)


func exit():
	if hand1:
		hand1.state=0
	if hand2:
		hand2.state=0
	t=0

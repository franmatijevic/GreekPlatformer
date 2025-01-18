extends State

@export var hand1:Node2D
@export var hand2:Node2D

@export var time:float=1##vrijeme za kolko ce pucat, player se mora pripremit mentalno

@export var handSpeed:float=400##neka bude dovoljno brzo da ruka stigne ispucat

@export var target1:Node2D
@export var target2:Node2D

var camera

var t=0


func _ready() -> void:
	camera = hand1.camera

func enter():
	t=time + 5#vrijeme prije pucanja + jos malo vremena(odmor valjda)
	
	if hand1.state==0:
		var t=create_tween()
		t.tween_interval(1)
		t.tween_callback(activate_hands)
	else:
		activate_hands()

func activate_hands():
	if hand1 and target1:
		hand1.state=2
		hand1.target = target1.global_position.x
		hand1.t=time
		hand1.horizontalVelocity  = handSpeed
	if hand2 and target2:
		hand2.state=2
		hand2.target = target2.global_position.x
		hand2.t=time
		hand2.horizontalVelocity  = handSpeed

func update_physics_process(delta:float):
	if t>time:
		player().next_attack()
		#player().block=true
	t=t+delta
	
	var target
	if camera:
		target = camera.get_screen_center_position().y - DisplayServer.screen_get_size().y/2
	else:
		target = player().global_position.y - 1000
	
	#var target = camera.get_screen_center_position().y - DisplayServer.screen_get_size().y/2 - 1000
	player().global_position.y=move_toward(player().global_position.y, target, 500*delta)


func exit():
	if hand1:
		hand1.state=0
	if hand2:
		hand2.state=0
	t=0

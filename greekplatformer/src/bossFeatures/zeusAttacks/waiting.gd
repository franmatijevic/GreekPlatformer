extends State

@export var time:float=1
@export var chillPosition:Node2D
var t=time

@export var setPos:bool=true

func enter():
	t=0
	#global_position.y =camera.get_screen_center_position().y - DisplayServer.screen_get_size().y/2
	
	if setPos:
		player().global_position.y = chillPosition.global_position.y-500
	
	var t = create_tween()
	t.tween_property(player(), "global_position", chillPosition.global_position, 3)

func update_physics_process(delta:float):
	t=t+delta
	if t>time:
		#player().block=true
		player().next_attack()
	
	#if chillPosition:
	#	player().global_position=player().global_position.move_toward(chillPosition.global_position, 1500*delta)
	
	#player().rotation=move_toward(player().rotation, 0, 20*delta)

func exit():
	t=0

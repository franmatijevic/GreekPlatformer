extends State

@export var time:float=1
var t=time

func enter():
	t=0

func update_physics_process(delta:float):
	t=t+delta
	if t>time:
		#player().block=true
		player().next_attack()
	
	
	player().global_position=player().global_position.move_toward(player().originalPosition, 400*delta)

func exit():
	t=0

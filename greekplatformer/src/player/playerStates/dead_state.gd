extends State

var time:float=3

func enter():
	player().modulate.r=1
	time=1
	#player().set_collision_layer_value(1, false)

func update_physics_process(delta:float):
	if time>0:
		time-=delta
		player().rotation+=delta*5
	else:
		player().get_parent().restart()

func exit():
	player().modulate.r=0
	player().rotation=0
	#player().set_collision_layer_value(1, true)

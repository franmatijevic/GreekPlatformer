extends State

var time:float=3

func enter():
	time=1
	player().set_collision_layer_value(1, false)

func update_physics_process(delta:float):
	if time>0:
		time-=delta
		player().rotation+=delta*5
	else:
		player().get_parent().restart()

func exit():
	player().rotation=0
	player().set_collision_layer_value(1, true)

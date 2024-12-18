extends State

var target

var t=0

var speed=400

func enter():
	t=0
	
	if(source().holding_object):
		target=source().holding_object
	else:
		pass

func update_physics_process(delta:float):
	
	player().armSpeed=move_toward(player().armSpeed, 700, 99999*delta)
	
	player().targetLeftArm.global_position=target.global_position
	player().targetRightArm.global_position=target.global_position
	
	t=t+delta
	if(t>0.3):
		player().set_arms("IdleState")

func exit():
	player().armSpeed=400

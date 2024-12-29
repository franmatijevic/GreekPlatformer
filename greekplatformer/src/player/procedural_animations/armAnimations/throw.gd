extends State

var target

var t=0

var speed=400

var throwTime=0.3
var putHandsBackTime=0.6

const rest=Vector2(0,135)

func enter():
	t=0
	
	if(source().holding_object):
		target=source().holding_object
	else:
		pass

func update_physics_process(delta:float):
	
	t=t+delta
	
	player().armSpeed=move_toward(player().armSpeed, 700, 99999*delta)
	
	if(t<throwTime):
		player().targetLeftArm.global_position=target.global_position
		player().targetRightArm.global_position=target.global_position
	elif(t<putHandsBackTime):
		player().targetLeftArm.position=rest
		player().targetRightArm.position=rest
	else:
		player().set_arms("IdleState")

func exit():
	player().armSpeed=400

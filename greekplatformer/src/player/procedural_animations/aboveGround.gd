extends State

var targetLeft:Vector2
var targetRight:Vector2

var offset:float=100

var t:float=0

var speed:float=100

func enter():
	t=PI/2
	player().targetLeftLeg.stop_step()
	player().targetRightLeg.stop_step()

func update_physics_process(delta:float):
	t=t-delta*10
	
	var r=30
	player().targetLeftLeg.position=Vector2(r*cos(t), -1.2*r*sin(t)+offset)
	player().targetRightLeg.position=Vector2(r*cos(t+PI), -1.2*r*sin(t+PI)+offset)
	
	#player().leftFoot.global_position=player().leftFoot.global_position.move_toward(targetLeft, speed*delta)
	#player().rightFoot.global_position=player().rightFoot.global_position.move_toward(targetRight, speed*delta)
	
	if(source().is_on_floor()):
		player().set_legs("Walking")

func exit():
	#targetLeft.global_position=player().leftFoot.global_position
	pass

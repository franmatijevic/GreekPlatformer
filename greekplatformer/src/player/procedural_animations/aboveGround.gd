extends State

var targetLeft:Vector2
var targetRight:Vector2

var offset:float=50

var t:float=0

var speed:float=100

func enter():
	t=0

func update_physics_process(delta:float):
	t=t+delta*5
	
	targetLeft=Vector2(cos(t), sin(t)+offset) * 40
	targetRight=Vector2(cos(t+PI), sin(t+PI)+offset) * 40
	
	player().leftFoot.global_position=player().leftFoot.global_position.move_toward(targetLeft, speed*delta)
	player().rightFoot.global_position=player().rightFoot.global_position.move_toward(targetRight, speed*delta)
	
	if(source().is_on_floor()):
		player().set_legs("Walking")

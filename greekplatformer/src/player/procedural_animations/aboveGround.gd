extends State

var offset:float=100

var t:float=0

var speed:float=100

var legSpeed=100

func enter():
	t=PI/2

func update_physics_process(delta:float):
	
	player().legSpeed=move_toward(player().legSpeed, legSpeed, 150*delta)
	
	t=t-delta*10*player().k
	
	if(source().facing_direction):
		player().rightFoot.rotation=move_toward(player().rightFoot.rotation,0, 50*delta)
	else:
		player().rightFoot.rotation=move_toward(player().rightFoot.rotation, -PI, 50*delta)
	
	
	var r=30
	player().targetLeftLeg.position=Vector2(r*cos(t), -1.2*r*sin(t)+offset)
	player().targetRightLeg.position=Vector2(r*cos(t+PI), -1.2*r*sin(t+PI)+offset)
	
	
	if(source().is_on_floor()):
		player().set_legs("Walking")

extends State

var offset:float=120

var t:float=0
var count:float=0

var speed:float=100

var legSpeed=100

func enter():
	t=PI/2
	count=0

#func update_physics_process(delta:float):
func update_process(delta:float):
	
	player().legSpeed=move_toward(player().legSpeed, legSpeed, 150*delta)
	
	t=t-delta*1*player().k
	count=count+delta
	
	if count>0.1:
		if(source().facing_direction):
			player().rightFoot.rotation=move_toward(player().rightFoot.rotation,0, 50*delta)
		else:
			player().rightFoot.rotation=move_toward(player().rightFoot.rotation, -PI, 50*delta)
		player().leftFoot.rotation=player().rightFoot.rotation
	
	var r=20
	player().targetLeftLeg.position=Vector2(0.8*r*cos(1.5*t), -1*r*sin(t)+offset)
	player().targetRightLeg.position=Vector2(0.8*r*cos(1.5*t+PI), -1*r*sin(t+PI)+offset)
	
	
	if(source().is_on_floor()):
		player().set_legs("Walking")

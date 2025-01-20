extends State

const angleSpeed=1
const angleTarget=0

const height=45#60#55

var t=0

func enter():
	t=0

#func update_physics_process(delta:float):
func update_process(delta:float):
	t+=delta*5
	
	#player().hip.position.y=move_toward(player().hip.position.y, 45, 20*delta)
	
	player().hip.position.y=move_toward(player().hip.position.y, height +1*sin(t), 20*delta)
	
	#player().hip.rotation=move_toward(player().hip.rotation, angleTarget, angleSpeed*delta)
	#player().hip.position.y=move_toward(player().hip.position.y, height, 3*delta)
	
	if(source().velocity.x==0 and source().is_on_floor()):
		player().set_hip("Idle")

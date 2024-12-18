extends State

const angleSpeed=1
const angleTarget=0

const height=60#55

func update_physics_process(delta:float):
	
	player().hip.position.y=move_toward(player().hip.position.y, 45, 20*delta)
	
	#player().hip.rotation=move_toward(player().hip.rotation, angleTarget, angleSpeed*delta)
	#player().hip.position.y=move_toward(player().hip.position.y, height, 3*delta)
	
	if(source().velocity.x==0 and source().is_on_floor()):
		player().set_hip("Idle")

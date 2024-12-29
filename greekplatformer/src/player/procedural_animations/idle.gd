extends State

const rest=Vector2(0,135)


func update_process(delta:float):
	
	player().targetLeftLeg.position=rest
	player().targetRightLeg.position=rest
	#player().targetLeftLeg.position.y=135 - (45 - player().hip.position.y)
	
	player().legSpeed=move_toward(player().legSpeed, 40, 5*delta)
	
	if(source().facing_direction):
		player().rightFoot.rotation=move_toward(player().rightFoot.rotation,0, 50*delta)
	else:
		player().rightFoot.rotation=move_toward(player().rightFoot.rotation, -PI, 50*delta)
	player().leftFoot.rotation=player().rightFoot.rotation
	
	
	if(source().velocity.x!=0):
		player().set_legs("Walking")
	elif(!source().is_on_floor()):
		player().set_legs("AboveGround")

extends State

func enter():
	#player().leftFoot.position=Vector2(0,135)
	#player().rightFoot.position=Vector2(0,135)
	player().targetLeftLeg.position=Vector2(0,150)
	player().targetRightLeg.position=Vector2(0,150)

func update_process(delta:float):
	
	#player().targetLeftLeg.position.y=135 - (45 - player().hip.position.y)
	
	player().legSpeed=move_toward(player().legSpeed, 40, 5*delta)
	
	#player().targetLeftLeg.global_position.x=holdLeft.x
	#if(source().velocity.x==0 or 1==1):
	#	player().targetLeftLeg.position.x=holdLeft.x
		#player().targetRightLeg.position.x=holdRight.x
	#else:
	#	holdLeft.x=player().leftFoot.global_position.x
		#holdRight.x=player().rightFoot.global_position.x
	
	#player().targetLeftLeg.global_position.y=holdLeft.y
	#if(source().velocity.y==0 or 1==1):
	#	player().targetLeftLeg.global_position.y=holdLeft.y
	#	player().targetRightLeg.global_position.y=holdRight.y
	#else:
	#	holdLeft.y=player().leftFoot.global_position.y
	#	holdRight.y=player().rightFoot.global_position.y
	
	
	if(source().velocity.x!=0):
		player().set_legs("Walking")
	elif(!source().is_on_floor()):
		player().set_legs("AboveGround")

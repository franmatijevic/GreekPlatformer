extends State


const restPose=Vector2(0,80)

func enter():
	player().targetLeftArm.position=restPose
	player().targetRightArm.position=restPose

func update_physics_process(delta:float):
	
	player().armSpeed=move_toward(player().armSpeed, 300, 50*delta)
	
	#player().leftArm.position=player().leftArm.position.move_toward(restPose,speed*delta)
	#player().rightArm.position=player().rightArm.position.move_toward(restPose,speed*delta)
	
	if(source().velocity.x!=0):
		player().set_arms("Moving")

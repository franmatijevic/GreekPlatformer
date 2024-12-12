extends State

const speed=200

var restPose=Vector2(0,80)

func enter():
	pass
	#player().tar

func update_physics_process(delta:float):
	player().leftArm.position=player().leftArm.position.move_toward(restPose,speed*delta)
	player().rightArm.position=player().rightArm.position.move_toward(restPose,speed*delta)
	
	if(source().velocity.x!=0):
		player().set_arms("Moving")

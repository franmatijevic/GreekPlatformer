extends State

var targetLeft:Vector2
var targetRight:Vector2

#var speed=200

func enter():
	player().targetLeftArm.position.y=60
	player().targetRightArm.position.y=60

func update_physics_process(delta:float):
	
	var speed=player().armSpeed
	player().armSpeed=move_toward(player().armSpeed, 500, 100*delta)
	
	if(source().velocity.x==0):
		player().set_arms("IdleState")
	
	
	player().targetLeftArm.position.x=player().rightFoot.position.x
	player().targetRightArm.position.x=player().leftFoot.position.x
	
	#player().leftArm.position.y #ovisi o player().rightFoot.position.x
	
	
	player().leftArm.position=player().leftArm.position.move_toward(targetLeft,speed*delta)
	player().rightArm.position=player().rightArm.position.move_toward(targetRight,speed*delta)

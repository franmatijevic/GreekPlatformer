extends State

var targetLeft:Vector2
var targetRight:Vector2

#var speed=200

func enter():
	player().targetLeftArm.position.y=120
	player().targetRightArm.position.y=120

func update_physics_process(delta:float):
	
	var speed=player().armSpeed
	player().armSpeed=move_toward(player().armSpeed, 900, 500*delta)
	
	if(source().velocity.x==0):
		player().set_arms("IdleState")
	
	
	player().targetLeftArm.position.x=player().rightFoot.position.x*0.6
	player().targetRightArm.position.x=player().leftFoot.position.x*0.6
	
	#if abs(player().leftArm.position.x-player().rightFoot.position.x)>12:
	#	player().targetLeftArm.position.x=player().rightFoot.position.x/2
	#	player().targetRightArm.position.x=player().leftFoot.position.x/2
	#player().leftArm.position.y #ovisi o player().rightFoot.position.x
	
	
	player().leftArm.position=player().leftArm.position.move_toward(targetLeft,speed*delta)
	player().rightArm.position=player().rightArm.position.move_toward(targetRight,speed*delta)

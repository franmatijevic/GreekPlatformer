extends State

var targetLeft:Vector2
var targetRight:Vector2

var speed=200

func enter():
	targetLeft.y=50
	targetRight.y=50

func update_physics_process(delta:float):
	
	if(source().velocity.x==0):
		player().set_arms("IdleState")
	
	
	targetLeft.x=player().rightFoot.position.x
	targetRight.x=player().leftFoot.position.x
	
	#player().leftArm.position.y #ovisi o player().rightFoot.position.x
	
	
	player().leftArm.position=player().leftArm.position.move_toward(targetLeft,speed*delta)
	player().rightArm.position=player().rightArm.position.move_toward(targetRight,speed*delta)

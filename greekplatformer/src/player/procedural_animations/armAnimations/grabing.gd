extends State

var target


var armLength=100

var hip

var k

func enter():
	if(source().facing_direction):
		k=1
	else:
		k=-1
	
	
	target=source().holding_object.get_node_or_null("Handle/Point")#.global_position
	if(target==null):
		target=source().holding_object
	
	#player().targetLeftArm.global_position=target.global_position
	#player().targetRightArm.global_position=target.global_position
	
	player().set_hip("Dummy")

func update_physics_process(delta:float):
	
	player().targetLeftArm.global_position=target.global_position
	player().targetRightArm.global_position=target.global_position
	
	var speed=player().armSpeed
	player().armSpeed=move_toward(player().armSpeed, 400, 50*delta)
	
	if(abs(target.global_position.y - player().shoulder.global_position.y)>0.6*armLength):
		player().hip.position.y=move_toward(player().hip.position.y,70,speed*delta)
	if(abs(target.global_position.x - player().shoulder.global_position.x)>armLength):
		player().hip.rotation=move_toward(player().hip.rotation, PI/2*0.8  ,1.8*delta)
	
	
	#player().leftArm.global_position=player().leftArm.global_position.move_toward(target.global_position, speed*delta)
	#player().rightArm.global_position=player().rightArm.global_position.move_toward(target.global_position, speed*delta)

func exit():
	player().set_hip("Idle")

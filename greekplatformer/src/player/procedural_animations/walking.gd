extends State

const straight:float=45
const bent:float=55

const step=50

var leftStart
var rightStart

func enter():
	#print("EEEEEEEEEEEEEE")
	
	leftStart=player().targetLeftLeg.global_position
	rightStart=player().targetRightLeg.global_position
	
	if(source().velocity.x==0):
		player().set_legs("EndWalking")
	
	#var k=1
	#if(source().velocity.x<0):
	#	k=-1
	
	
	
	#player().hip.position.y=100#umjesto 45
	
	#create_tween().tween_property(player().hip,"position", Vector2(player().hip.position.x,bent), 0.7)
	
	#if(k*player().leftFoot.global_position.x<k*player().rightFoot.global_position.x):
	#	player().set_legs("LeftLegForward")
	#else:
	#	player().set_legs("RightLegForward")

func update_physics_process(_delta:float):
	if(source().velocity.x!=0):
		player().targetLeftLeg.global_position.x=leftStart.x
		player().targetRightLeg.global_position.x=rightStart.x
	if(source().velocity.y!=0):
		player().targetLeftLeg.global_position.y=leftStart.y
		player().targetRightLeg.global_position.x=rightStart.y
	
	if(player().leftFoot.global_position.distance_to(player().rightFoot.global_position))>step:
		if(abs(player().rightFoot.position.x)>abs(player().leftFoot.position.x)):
			player().set_legs("RightLegForward")
			print("DES")
		else:
			player().set_legs("LeftLegForward")
			print("LIJ")
	
	elif abs(player().leftFoot.global_position.distance_to(player().targetLeftLeg.global_position))>step:
		player().set_legs("LeftLegForward")
	elif abs(player().rightFoot.global_position.distance_to(player().targetRightLeg.global_position))>step:
		player().set_legs("RightLegForward")

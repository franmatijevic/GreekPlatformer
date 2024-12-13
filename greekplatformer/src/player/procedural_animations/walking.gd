extends State

const step=100

var leftHold
var rightHold

func enter():
	#leftHold=player().targetLeftLeg.global_position
	#rightHold=player().targetRightLeg.global_position
	
	#if((player().position.x+player().position.x)/2>30):
	#	if(abs(player().leftFoot.position.x)>abs(player().rightFoot.position.x)):
	#		player().targetLeftLeg.step()
	#	else:
	#		player().targetRightLeg.step()
	
	#player().hip.position.y=60
	
	if(source().velocity.x==0):
		#player().set_legs("EndWalking")
		pass
		#player().set_legs("IdleState")
	
	k=1
	t1=PI
	t2=0
	if(source().velocity.x<0):
		k=-1
		t1=0
		t2=PI
	
	#player().hip.position.y=100#umjesto 45
	player().hip.position.y=60
	
	#create_tween().tween_property(player().hip,"position", Vector2(player().hip.position.x,bent), 0.7)
	
	#if(k*player().leftFoot.global_position.x<k*player().rightFoot.global_position.x):
	#	player().set_legs("LeftLegForward")
	#else:
	#	player().set_legs("RightLegForward")

func exit():
	player().hip.position.y=45

var r=30
var t1=0
var t2=0
var offset:float=135#-r/2.0
var k=0

var speed=10

var inclineOffset:Vector2

func update_physics_process(delta:float):
	
	if(source().velocity.x<0):
		k=-1
	else:
		k=1
	
	var normal = source().get_floor_normal()
	var angle = PI/2
	if(normal):
		var dir=Vector2(-normal.y, normal.x) * k
		player().leftFoot.rotation=dir.angle()
		player().rightFoot.rotation=dir.angle()
		
		inclineOffset=normal*r/2.0
	else:
		inclineOffset=Vector2(0,r/2.0)
	
	#player().hip.position.y=45 - 15*sin(angle) +15
	
	
	
	#Basic rjesenje
	t1=t1-delta*speed*k
	t2=t2-delta*speed*k
	player().targetLeftLeg.position=Vector2(r*cos(t1), -r*sin(t1)+offset-r/2)+inclineOffset
	player().targetRightLeg.position=Vector2(r*cos(t2), -r*sin(t2)+offset-r/2)+inclineOffset

	if(source().velocity.x==0):
		player().set_legs("EndWalking")
		#player().set_legs("IdleState")
		pass
	
	if(!source().is_on_floor()):
		player().set_legs("AboveGround")

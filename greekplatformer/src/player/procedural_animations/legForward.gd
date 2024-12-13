extends State

@export var currentLeg:Node2D
@export var secondLeg:Node2D

@export var stepTarget:Marker2D

const floor_level:float=135

const stepDistance:float=50 #max duljina koraka
#const maxLegBehind:float=20 # max udaljenost noge iza 

const kneeRaise:float=65

var speedX:float=0
var t:float=0

var distance:float
var start:Vector2

var balance:Vector2

var k

var touch:bool=false

var target_pos
var half_way

func enter():
	
	
	#player().hip.position.y=45+15
	#player().fix_legs()
	
	#target.global_position=Vector2(0,120)
	
	if(!source().direction):
		player().set_legs("IdleState")
	
	touch=false
	t=0
	balance = secondLeg.global_position
	start = currentLeg.global_position
	
	stepTarget.position = Vector2(-2, 135)
	if(source().velocity.x>0):
		#distance=stepDistance
		k=1
		stepTarget.global_position.x += stepDistance
	else:
		#distance=-stepDistance
		stepTarget.global_position.x += -stepDistance
		k=-1
	
	var point=stepTarget.get_node("RayCast2D").get_collision_point()
	if(point):
		stepTarget.global_position.y=point.y
	
	#stepTarget.position = Vector2(-2, 135)
	#target_pos = stepTarget.global_position
	#half_way = (currentLeg.global_position + stepTarget.global_position)/2
	
	#var t = get_tree().create_tween()
	#t.tween_property(currentLeg, "global_position", half_way +Vector2(0,-kneeRaise), 0.1)
	#t.tween_property(currentLeg, "global_position", target_pos, 0.1)
	#t.tween_callback(func(): player().set_legs("Walking"))
	
	stepTarget.position=currentLeg.position

func update_physics_process(delta:float):
	
	#if(!touch):
	#	currentLeg.global_position=currentLeg.global_position.move_toward(half_way +Vector2(0,-kneeRaise), delta*200)
	#	if(currentLeg.global_position==half_way +Vector2(0,-kneeRaise)):
	#		touch=true
	#else:
	#	currentLeg.global_position=currentLeg.global_position.move_toward(target_pos, delta*200)
	#	if(currentLeg.global_position==target_pos):
	#		player().set_legs("Walking")
	
	var time = (abs(currentLeg.global_position.x-source().global_position.x)+distance)/source().velocity.x
	speedX = min(stepDistance / time,200)
	
	var r=30
	
	t=t+delta*4#source().velocity.x*0.2
	
	#if(!stepTarget.get_node("RayCast2D").is_colliding() or t<PI/2):
	#	stepTarget.position.x = 0.9*k*r + r*cos(t)
	#	stepTarget.position.y = 1.4*r*sin(t) + 135
	#else:
	#	if(currentLeg.position == stepTarget.position):
	#		player().set_legs("Walking")
	
	stepTarget.position.x = k*r + r*cos(t-PI/2) - 2
	stepTarget.position.y = -r*sin(t) + 135
	
	#stepTarget.position=currentLeg.position
	
	if(t>PI):
		player().set_legs("Walking")
	
	currentLeg.position=currentLeg.position.move_toward(stepTarget.position, 700*delta)
	
	
	
	#if(source().velocity.x!=0):
	#	distance = k * min(stepDistance, abs(source().SPEED/source().velocity.x * stepDistance))
	#else:
	#	distance = k
	
	#if(!currentLeg.get_node("RayCast2D").is_colliding()):
	if(1==1):
		if(source().velocity.x!=0):
			secondLeg.global_position.x=balance.x
		if(source().velocity.y!=0):
			secondLeg.global_position.y=balance.y
		if(abs(secondLeg.position.x-player().position.x)>70):
			player().set_legs("Walking")
	#secondLeg.global_position=Vector2(0,135)
	
	#if(!touch):
	#	var b= 4*(kneeRaise-135)/distance
	#	var a= -b/distance
	#	target.position.x=t*k
	#	target.position.y = (a*t*t + b *t*k +135)
	#else:
	#	target.global_position=start
	#	target.global_position.y+=t*15
		#speedX*=10
	#	if(currentLeg.position==target.position):
	#		player().set_legs("Walking")
	
	
	#currentLeg.position=currentLeg.position.move_toward(target.position, speedX*delta)
	
	#if(currentLeg.get_node("RayCast2D").is_colliding()):
	#	player().set_legs("Walking")
	
	#if(source().velocity.x==0):
	#	player().set_legs("EndWalking")
	
	if(!source().is_on_floor()):
		player().set_legs("AboveGround")

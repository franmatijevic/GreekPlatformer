extends State

const r=35#radijus kruznice koja je putanja
var offset:float=145 + 35  #po y od centra do stopala

var t1=0
var t2=0

var speed=10#target position speed

var legSpeed=300

var inclineOffset:Vector2

func enter():
	t1=PI
	t2=0
	if(source().velocity.x<0):
		t1=0
		t2=PI

#func update_physics_process(delta:float):
func update_process(delta:float):
	
	player().legSpeed=move_toward(player().legSpeed, legSpeed, 150*delta)
	#player().legSpeed=10000
	
	var k=player().k
	
	var walkDir=-1
	if(source().velocity.x>0):
		walkDir=1
	
	var normal = source().get_floor_normal()
	if(normal):
		var dir=(Vector2(-normal.y, normal.x) * k).angle()
		player().leftFoot.rotation=move_toward(player().leftFoot.rotation, dir, 50*delta)
		player().rightFoot.rotation=move_toward(player().rightFoot.rotation, dir, 50*delta)
		inclineOffset=normal*r/2.0
	else:
		inclineOffset=Vector2(0,r/2.0)
		player().leftFoot.rotation=move_toward(player().leftFoot.rotation, PI/2 *(1-k), 30*delta)
		player().rightFoot.rotation=move_toward(player().rightFoot.rotation, PI/2 *(1-k), 30*delta)
	
	
	
	t1=t1-delta*speed*walkDir
	t2=t2-delta*speed*walkDir#*0.6
	player().targetLeftLeg.position=Vector2(r*cos(t1), -r*sin(t1)+offset-r/2.0)+inclineOffset
	player().targetRightLeg.position=Vector2(r*cos(t2), -r*sin(t2)+offset-r/2.0)+inclineOffset

	if(source().velocity.x==0):
		player().set_legs("EndWalking")
	
	if(!source().is_on_floor()):
		player().set_legs("AboveGround")

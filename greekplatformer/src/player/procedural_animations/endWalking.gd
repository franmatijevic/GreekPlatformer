extends State

@export var leftFoot:Node2D
@export var rightFoot:Node2D

const speed:float=500
const stable:float=50

const legSpeed=50

var stablize

var target

var t=0

func enter():
	t=PI/2

func update_physics_process(delta:float):
	
	player().legSpeed=move_toward(player().legSpeed, legSpeed, 50*delta)
	
	t=t+delta*10
	player().targetLeftLeg.position=Vector2(0, -68*sin(t) + 135)
	player().targetRightLeg.position=Vector2(0, -68*sin(t) + 135)
	if(t>3/2.0*PI):
		player().set_legs("IdleState")

func exit():
	player().targetLeftLeg.position=Vector2(0,150)
	player().targetRightLeg.position=Vector2(0, 150)
	#var normal = source().get_floor_normal()
	#if(normal):
	#	var dir=(Vector2(-normal.y, normal.x) * 1).angle()
	#	player().leftFoot.rotation=dir
	#	player().rightFoot.rotation=dir
	#player().fix_legs()
	#player().targetLeftLeg.position=player().leftFoot.position+Vector2(0,20)
	#player().targetRightLeg.position=player().rightFoot.position

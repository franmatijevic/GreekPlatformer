extends State

@export var leftFoot:Node2D
@export var rightFoot:Node2D

const speed:float=500
const stable:float=50

var stablize

var target

var t=0

func enter():
	t=PI/2
	#player().targetLeftLeg.global_position=player().leftFoot.global_position
	#player().targetRightLeg.global_position=player().rightFoot.global_position
	#player().set_legs("IdleState")

func update_physics_process(delta:float):
	t=t+delta*10
	player().targetLeftLeg.position=Vector2(-2, -68*sin(t) + 135)
	player().targetRightLeg.position=Vector2(-2, -68*sin(t) + 135)
	if(t>3/2*PI):
		player().set_legs("IdleState")

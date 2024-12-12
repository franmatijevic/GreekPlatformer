extends State

@export var leftFoot:Node2D
@export var rightFoot:Node2D

const speed:float=500
const stable:float=50

var stablize

var target

var t=0

func enter():
	player().targetLeftLeg.global_position=player().leftFoot.global_position
	player().targetRightLeg.global_position=player().rightFoot.global_position
	player().set_legs("IdleState")

func update_physics_process(delta:float):
	pass

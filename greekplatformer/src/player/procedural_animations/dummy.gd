extends State

var hip

var legLength=135

func enter():
	hip=player().hip.position.y
	hip=45

func update_physics_process(_delta:float):
	var distance=hip-player().hip.position.y
	
	
	player().targetLeftLeg.position.y = legLength+distance
	player().targetRightLeg.position.y = legLength+distance
	#player().leftFoot.position.y = legLength+distance
	#player().rightFoot.position.y = legLength+distance
	

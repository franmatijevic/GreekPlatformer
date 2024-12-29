extends State

var hip

var legLength=135

func enter():
	hip=player().hip.position.y
	hip=45

func update_physics_process(_delta:float):
	var distance=hip-player().hip.position.y
	
	
	player().targetLeftLeg.position.y = legLength+distance+10
	player().targetRightLeg.position.y = legLength+distance+10
	#player().leftFoot.position.y = legLength+distance
	#player().rightFoot.position.y = legLength+distance

func exit():
	var t=create_tween()
	t.tween_property(player().hip, "rotation", 0, 0.5)

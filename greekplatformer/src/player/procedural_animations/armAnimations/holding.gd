extends State


func enter():
	player().leftArm.position=source().get_node("Marker2D").position
	player().rightArm.position=source().get_node("Marker2D").position

func update_physics_process(delta:float):
	
	player().armSpeed=move_toward(player().armSpeed, 400, 100*delta)
	
	player().leftArm.position=source().get_node("Marker2D").position
	player().rightArm.position=source().get_node("Marker2D").position
	
	#player().leftArm.position=player().leftArm.position.move_toward(source().get_node("Marker2D").position, delta*100)
	#player().rightArm.position=player().rightArm.position.move_toward(source().get_node("Marker2D").position, delta*100)

extends State

var target

var speed=200

func enter():
	target=source().holding_object.get_node("Handle/Point")#.global_position
	if(target==null):
		target=source().holding_object

func update_physics_process(delta:float):
	
	player().leftArm.global_position=player().leftArm.global_position.move_toward(target.global_position, speed*delta)
	player().rightArm.global_position=player().rightArm.global_position.move_toward(target.global_position, speed*delta)

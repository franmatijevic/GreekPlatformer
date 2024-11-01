extends State

var timer:float=0

func enter():
	timer = player().holding_object.use_time
	player().holding_object.player_interaction()

func update_physics_process(delta:float):
	if Input.is_action_just_released("pickThrow"):
		player().holding_object.stop_player_interaction()
		player().set_state("MoveState")
	
	if(timer>0):
		timer =  timer - delta
	else:
		player().set_state("MoveState")

func exit():
	player().holding_object = null

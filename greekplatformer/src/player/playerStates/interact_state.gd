extends State

var timer:float=0

var left
var right

var holding:bool=false

func enter():
	player().direction=0
	holding=false
	timer = player().holding_object.use_time
	
	player().get_node("ProceduralAnimation").set_arms("Grab")
	left=player().get_node("ProceduralAnimation").leftArm
	right=player().get_node("ProceduralAnimation").rightArm
	
	#player().holding_object.player_interaction()

func update_physics_process(delta:float):
	if Input.is_action_just_released("pickThrow"):
		player().holding_object.stop_player_interaction()
		player().set_state("MoveState")
	
	if(player().holding_object and (left.global_position.distance_squared_to(player().holding_object.holding_point())<15 or right.global_position.distance_squared_to(player().holding_object.holding_point())<15)):
		if(!holding):
			holding=true
			player().holding_object.player_interaction()
	
	if(holding):
		if(timer>0):
			timer =  timer - delta
		else:
			player().set_state("MoveState")

func exit():
	player().holding_object = null
	player().get_node("ProceduralAnimation").set_arms("IdleState")

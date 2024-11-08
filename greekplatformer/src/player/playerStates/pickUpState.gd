extends State

var timer:float=0

func enter():
	timer = player().holding_object.picking_up_time

func update_physics_process(delta:float):
	if(timer>0):
		timer =  timer - delta
	else:
		player().holding_object.be_picked_up(player())
		
		player().set_state("MoveState")
	
	if(player().is_on_floor()):
		player().direction=0

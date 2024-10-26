extends State


var time:float

func enter():
	time=0.8
	player().player.process_mode=Node.PROCESS_MODE_DISABLED
	player().get_parent().current_room.pause_all_objects(true)
	
	
	var room = player().get_parent().current_room.get_node("RoomSize")#ovo je collisionShape2D scene Room
	var camera = player().get_node("Camera2D")
	camera.set_limit(SIDE_LEFT, room.global_position.x - room.shape.size.x/2)
	camera.set_limit(SIDE_RIGHT, room.global_position.x + room.shape.size.x/2)
	camera.set_limit(SIDE_TOP, room.global_position.y - room.shape.size.y/2)
	camera.set_limit(SIDE_BOTTOM, room.global_position.y + room.shape.size.y/2)

func update_physics_process(delta:float):
	if time>0:
		time-=delta
	else:
		player().set_state("FollowPlayer")

func exit():
	player().player.process_mode=Node.PROCESS_MODE_INHERIT
	player().get_parent().current_room.pause_all_objects(false)

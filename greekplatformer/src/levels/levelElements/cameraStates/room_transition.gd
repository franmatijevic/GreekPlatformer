extends State

signal end_transition

var time:float

func enter():
	time=0.8
	player().player.process_mode=Node.PROCESS_MODE_DISABLED
	player().get_parent().current_room.pause_all_objects(true)
	
	var current_room =player().get_parent().current_room
	var room = current_room.get_node("RoomSize")#ovo je collisionShape2D scene Room
	
	var camera = player().get_node("Camera2D")
	camera.set_limit(SIDE_LEFT, room.global_position.x - room.shape.size.x/2 + current_room.leftOffset)
	camera.set_limit(SIDE_RIGHT, room.global_position.x + room.shape.size.x/2 - current_room.rightOffset)
	camera.set_limit(SIDE_TOP, room.global_position.y - room.shape.size.y/2 + current_room.upOffset)
	camera.set_limit(SIDE_BOTTOM, room.global_position.y + room.shape.size.y/2 - current_room.downOffset)
	
	camera.set_rotation_smoothing_speed(5)

func update_physics_process(delta:float):
	if time>0:
		time-=delta
		#var sp = player().get_node("Camera2D").get_rotation_smoothing_speed()+delta*100
		#player().get_node("Camera2D").set_rotation_smoothing_speed(sp)
	else:
		player().set_state("FollowPlayer")

func exit():
	#player().get_parent().current_room.get_node("Wall/CollisionShape2D").set_deferred("disabled", false)
	#player().get_node("Camera2D").position_smoothing_enabled=false
	#player().get_node("Camera2D").set_rotation_smoothing_speed(1000)
	
	player().player.process_mode=Node.PROCESS_MODE_PAUSABLE
	player().get_parent().current_room.pause_all_objects(false)
	end_transition.emit()

extends State

@export var vertical_follow_speed:float = 500#brzina kamere dok player skace
@export var faster_vert_speed:float=999999999

@export var max_camera_to_player_distance:float=300
@export var max_player_velocity:float=500

var playerY

func enter():
	playerY = player().player.global_position.y
	
	player().block=false
	var current_room = player().get_parent().current_room
	var room = current_room.get_node("RoomSize")#ovo je collisionShape2D scene Room
	var camera = player().get_node("Camera2D")
	
	camera.set_limit(SIDE_LEFT, room.global_position.x - room.shape.size.x/2 + current_room.leftOffset)
	camera.set_limit(SIDE_RIGHT, room.global_position.x + room.shape.size.x/2 - current_room.rightOffset)
	camera.set_limit(SIDE_TOP, room.global_position.y - room.shape.size.y/2 + current_room.upOffset)
	camera.set_limit(SIDE_BOTTOM, room.global_position.y + room.shape.size.y/2 - current_room.downOffset)
	
	player().get_node("Camera2D").set_rotation_smoothing_speed(9999999)

func exit():
	player().block=true


func update_physics_process(delta:float):
	#player() vraca Node2D "Camera", a player().player je zapravo player
	player().global_position.x=player().player.global_position.x
	
	if(player().player.is_on_floor() or abs(player().player.velocity.y)>max_player_velocity):
		playerY = player().global_position.y
	
	if(player().player.global_position.y-player().get_node("Camera2D").get_target_position().y>max_camera_to_player_distance):
		playerY = player().player.global_position.y+1080
		player().global_position.y = playerY
		
		#var x = player().get_node("Camera2D").get_target_position().x
		#player().get_node("Camera2D").reset_smoothing()
		#player().get_node("Camera2D").force_update_scroll()
		#player().global_position.x = x
		
		#player().global_position.y = move_toward(player().player.global_position.y,playerY,faster_vert_speed*delta)
	else:
		player().global_position.y = move_toward(player().player.global_position.y,playerY,vertical_follow_speed*delta)

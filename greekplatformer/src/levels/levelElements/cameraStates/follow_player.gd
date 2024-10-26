extends State

@export var vertical_follow_speed:float = 300#brzina kamere dok player skace
@export var max_camera_to_player_distance:int=180
@export var max_player_velocity:float=300

func enter():
	var room = player().get_parent().current_room.get_node("RoomSize")#ovo je collisionShape2D scene Room
	var camera = player().get_node("Camera2D")
	
	
	camera.set_limit(SIDE_LEFT, room.global_position.x - room.shape.size.x/2)
	camera.set_limit(SIDE_RIGHT, room.global_position.x + room.shape.size.x/2)
	camera.set_limit(SIDE_TOP, room.global_position.y - room.shape.size.y/2)
	camera.set_limit(SIDE_BOTTOM, room.global_position.y + room.shape.size.y/2)




func update_physics_process(delta:float):
	#player() vraca Node2D "Camera", a player().player je zapravo player
	player().global_position.x=player().player.global_position.x
	
	if(player().player.is_on_floor() or abs(player().player.velocity.y)>500):
		player().global_position.y = move_toward(player().global_position.y,player().player.global_position.y,vertical_follow_speed*delta)

func tooFarAway():#s ovim kamera trza
	return abs(player().global_position.y-player().player.global_position.y)>max_camera_to_player_distance

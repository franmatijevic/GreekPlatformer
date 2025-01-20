extends State


func enter():
	player().targetLeftArm.position=source().get_node("Marker2D").position
	player().targetRightArm.position=source().get_node("Marker2D").position
	
	#player().get_node("CharacterContainer/Bones/Skeleton2D/Hip/LeftArm/UpperArm").position.y=42
	#player().get_node("CharacterContainer/Bones/Skeleton2D/Hip/RightArm/UpperArm").position.y=42

#func update_physics_process(delta:float):
func update_process(delta:float):
	
	player().armSpeed=move_toward(player().armSpeed, 400, 100*delta)
	
	player().targetLeftArm.position=source().get_node("Marker2D").position
	player().targetRightArm.position=source().get_node("Marker2D").position
	
	#player().get_node("CharacterContainer/Bones/Skeleton2D/Hip/RightArm/UpperArm").rotation=-PI/2
	#player().get_node("CharacterContainer/Bones/Skeleton2D/Hip/LeftArm/UpperArm").rotation=-PI/2
	
	#player().get_node("CharacterContainer/Bones/Skeleton2D/Hip/LeftArm").rotation=0
	#player().get_node("CharacterContainer/Bones/Skeleton2D/Hip/RightArm").rotation=0
	
	#player().leftArm.position=player().leftArm.position.move_toward(source().get_node("Marker2D").position, delta*100)
	#player().rightArm.position=player().rightArm.position.move_toward(source().get_node("Marker2D").position, delta*100)

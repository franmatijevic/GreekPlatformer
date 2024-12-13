extends State

const speed=20

func update_process(_delta:float):
	
	
	if(source().velocity.x!=0):
		player().set_legs("Walking")
	elif(!source().is_on_floor()):
		player().set_legs("AboveGround")
	
	#if(!player().leftFoot.get_node("RayCast2D").is_colliding() or !player().leftFoot.get_node("RayCast2D").is_colliding()):
		#player().get_node("CharacterContainer/Bones/Skeleton2D/Hip").position.y+=speed*delta
		#player().get_node("CharacterContainer/Bones/Skeleton2D/Hip").position.y=move_toward(player().get_node("CharacterContainer/Bones/Skeleton2D/Hip").position.y, 45+30, speed*delta)

func exit():
	pass
	#player().get_node("CharacterContainer/Bones/Skeleton2D/Hip").position.y=45

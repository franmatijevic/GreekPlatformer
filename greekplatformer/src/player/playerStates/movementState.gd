extends State

func update_physics_process(_delta:float):
	
	player().direction = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("up"):
		player().jump()
	elif Input.is_action_just_released("up"):
		player().stop_jump()

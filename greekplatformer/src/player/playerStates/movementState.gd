extends State

func exit():
	player().direction=0

func update_physics_process(_delta:float):
	
	player().direction = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("up"):
		player().jump()
	elif Input.is_action_just_released("up"):
		player().stop_jump()
	elif Input.is_action_just_released("shoot"):
		player().shoot()
	if Input.is_action_just_pressed("pickThrow"):
		player().pick_or_throw()
	elif Input.is_action_just_pressed("down"):
		player().throw( Vector2(0, -10) )

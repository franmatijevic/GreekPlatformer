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
	elif Input.is_action_just_pressed("pick_up_item"):
		player().pick_up()
	elif Input.is_action_just_pressed("drop_item"):
		player().throw( Vector2(0, -10) )
	elif Input.is_action_just_pressed("throw_item"):
		player().throw(player().throw_force)

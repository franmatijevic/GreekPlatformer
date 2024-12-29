extends State

func enter():
	player().set_collision_layer_value(1, true)

func exit():
	if player().is_on_floor():
		player().direction=0

func update_physics_process(_delta:float):
	
	player().direction = Input.get_axis("left", "right")
	
	if Input.is_action_just_pressed("jump"):
		player().jump()
	elif Input.is_action_just_pressed("alt_jump"):
		player().jump()
	elif Input.is_action_just_released("jump"):
		player().stop_jump()
	elif Input.is_action_just_released("alt_jump"):
		player().stop_jump()
	elif Input.is_action_just_released("shoot"):
		player().shoot()
	if Input.is_action_just_pressed("pickThrow"):
		player().pick_or_throw()
	elif Input.is_action_just_pressed("down"):
		player().throw( Vector2(0, -10) )

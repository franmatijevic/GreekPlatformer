extends Line2D

func update_trajectory(dir: Vector2, speed: float, gravity: float, delta: float, start_offset: float) -> void:
	var max_points = 100
	var time_step = 0.01
	clear_points()
	
	var pos: Vector2 = Vector2.ZERO
	var vel = dir * speed
	
	var accumulated_distance = 0.0
	
	for i in range(max_points):
		if accumulated_distance >= start_offset:
			add_point(pos)
		
		var previous_pos = pos
		vel.y += gravity * time_step
		pos += vel * time_step
		
		accumulated_distance += previous_pos.distance_to(pos)
		
		if pos.y > 1000:
			break

extends Area2D

const max_force:float=800

const charge:float=0.1

func _on_body_entered(body: Node2D) -> void:
	if($Timer.time_left>0):
		return
	
	if(body is Character):
		if(body.velocity.y>=0):
			$Timer.start(charge)
	elif(body is Throwable):
		if(body.linear_velocity.y>=0):
			$Timer.start(charge)

func _on_timer_timeout() -> void:
	for i in get_overlapping_bodies():
		if(i is Character):
			i.velocity.y = -max_force
		elif(i is Throwable):
			i.linear_velocity.y = -max_force

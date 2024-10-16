extends Area2D

const max_force:float=800

const charge:float=0.1

var ticking:bool=false

func _on_body_entered(body: Node2D) -> void:
	if(ticking):
		return
	ticking=true
	
	if(body.name=="Player"):
		if(body.velocity.y>=0):
			$Timer.start(charge)


func _on_timer_timeout() -> void:
	ticking=false
	for i in get_overlapping_bodies():
		i.velocity.y = -max_force

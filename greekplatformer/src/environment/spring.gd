extends Area2D

@export var max_force:float=800##Snaga opruge kojom te odgurne
@export var side_force:float=1200##nadodanje vertikalne sile na horizontalne opruge

const charge:float=0.1

var total_force:Vector2=Vector2.DOWN

func _ready() -> void:
	total_force = Vector2(sin(rotation), -cos(rotation))*max_force#sin i cos su tako poslozeni jer se uracunava defaultno rotiranje za 90 stupnjeva u smjeru kazaljke na satu
	#side_force = -abs(sin(rotation)*side_force)
	total_force.y -= abs(pow(sin(rotation),3)*side_force)

func _on_body_entered(body: Node2D) -> void:
	if($Timer.time_left>0):
		return
	
	if(body is Character):
		#if(body.velocity.y>=0):
		$Timer.start(charge)
	elif(body is Throwable):
		#if(body.linear_velocity.y>=0):
		$Timer.start(charge)

func _on_timer_timeout() -> void:#odbacivanje tijela iz opruge
	for i in get_overlapping_bodies():
		if(i is Character):
			i.velocity=total_force
			#i.velocity.y = -max_force
			i.jumped=false
		elif(i is Throwable):
			#i.linear_velocity.y = -max_force
			i.linear_velocity = total_force
